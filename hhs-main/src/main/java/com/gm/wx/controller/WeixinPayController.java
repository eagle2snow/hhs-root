package com.gm.wx.controller;

import java.math.BigDecimal;
import java.util.Map;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.api.pay.exception.BestPayException;
import com.gm.api.pay.model.PayResponse;
import com.gm.api.wx.WeixinPayApi;
import com.gm.base.consts.Const;
import com.gm.base.model.Member;
import com.gm.base.model.PayBill;
import com.gm.service.IPayBillService;
import com.gm.service.impl.OrderServiceImpl;

/**
 * 
 * <p>
 * Description: 微信支付入口
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年5月7日
 */
@RequestMapping("/wx/pay/")
@Controller
public class WeixinPayController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WeixinPayApi.class);

	@Resource
	private IPayBillService payBillService;

	/**
	 * @Title: prePay   
	 * @Description: 订单支付前    应该添加个备注字段
	 * @param orderNo
	 * @param orderName
	 * @param amount 订单金额
	 * @return      
	 * @return: Map<String,Object>      
	 * @throws
	 */
	@RequestMapping("/prePayOrder")
	@ResponseBody
	public Map<String, Object> prePay(String orderNo, String orderName, BigDecimal amount)
	{
		logger.info("prepay:The pay start,ages is orderNo={},orderName={},amount={}", orderNo, orderName, amount);
		
//		amount = amount.multiply(BigDecimal.valueOf(0.01));
		logger.info("prePay:The order parice is amount = {}",JSON.toJSON(amount));
		Member member = WXHelper.getMember(getCurMember());

		PayBill payBill = payBillService.getOne("orderNo", orderNo);

		if (null == payBill) {
			payBill = new PayBill();
			payBill.setOrderNo(orderNo);
			payBill.setOpenid(member.getOpenid());
			payBill.setType(2);
			payBill.setPay(1);
			payBill.setPreFee(amount);
			payBillService.save(payBill);
		}
		logger.info("setMeal is setMeal={}", this.getCurMember().getSetMeal());

		Map<String, Object> map = getMap();
		try {

			PayResponse res = WeixinPayApi.pay(orderNo, orderName, amount, getCurMember().getOpenid(), getDomain());
			map.put("s", 1);
			map.put("data", res);

		} catch (BestPayException e) {
			e.printStackTrace();
			if (e.getCode().equals(17)) {
				map.put("s", "订单已经支付");
			} else {
				map.put("s", "系统有误，请稍候再试");
			}
		}
		return map;
	}

	/**
	 * @Title: prePayCombo   
	 * @Description: 套餐支付前
	 * @return      
	 * @return: Map<String,Object>      
	 * @throws
	 */
	@RequestMapping("/prePayCombo")
	@ResponseBody
	public Map<String, Object> prePayCombo(Integer choosed)
	{
		Map<String, Object> map = getMap();

		Member member = WXHelper.getMember(getCurMember());
		if (member == null) {
			logger.error("member == null");
			map.put("s", "系统有误，请稍候再试！");
			return map;
		}
		
		if (member.getSetMeal() != 1) {
			map.put("s", "您已购买，请勿重新购买套餐!");
			return map;
		}

		PayBill payBill = new PayBill();
		payBill.setOrderNo(OrderServiceImpl.genOrderNo());
		payBill.setType(1);
		payBill.setPay(1);
		payBill.setOpenid(member.getOpenid());
		payBill.setPreFee(Const.MEMBER_AMOUNT);
		payBill.setAddressId(choosed);
		payBillService.save(payBill);
		
		try {			
				PayResponse res = WeixinPayApi.pay(payBill.getOrderNo(), "购买套餐", Const.MEMBER_AMOUNT, member.getOpenid(),
						getDomain());
				map.put("s", 1);
				map.put("data", res);			
		} catch (BestPayException e) {
			e.printStackTrace();
			if (e.getCode().equals(17)) {
				map.put("s", "订单已经支付");
			} else {
				map.put("s", "系统有误，请稍候再试");
			}
		}
			
		logger.info("prePayCombo:the Map map={}", JSON.toJSON(map));

		return map;
	}

	private final Lock lock = new ReentrantLock();
	private final ConcurrentLinkedQueue<PayBill> success = new ConcurrentLinkedQueue<>();
	private final Condition condition = lock.newCondition();

	@PostConstruct
	public void init()
	{
		new Thread(() -> {
			for (;;) {
				try {
					if (success.isEmpty()) {
						try {
							lock.lock();
							condition.await();
						} catch (Exception e) {
							logger.error("condition.await()", e);
						} finally {
							lock.unlock();
						}
					}
					if (success.isEmpty())
						continue;
					PayBill payBill = success.poll();
					payBillService.paySuccess(payBill);
				} catch (Exception e) {
					logger.error("paysuccess thread", e);
				}
			}
		}).start();
	}


	// 成功支付
	// produces: 指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回；
	@PostMapping(value = "/paySuccess", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String WeixinParentNotifyPage(HttpServletRequest request) throws Exception {
		ServletInputStream instream = request.getInputStream();
		StringBuffer sb = new StringBuffer();
		int len = -1;
		byte[] buffer = new byte[1024];

		while ((len = instream.read(buffer)) != -1) {
			sb.append(new String(buffer, 0, len));
		}
		instream.close();

		PayResponse response = WeixinPayApi.getBestPayServiceImpl(getDomain()).asyncNotify(sb.toString());

		String orderId = response.getOrderId();
		Double amount = response.getOrderAmount();
		String outTradeNo = response.getOutTradeNo();

		PayBill payBill = payBillService.getOne("orderNo", orderId);
		if (payBill != null) {
			payBill.setPay(2);
			payBill.setReaFee(BigDecimal.valueOf(amount));
			payBill.setTransactionId(outTradeNo);
			payBillService.update(payBill);
			logger.info("paySuccess支付成功回调={}.","orderId="+orderId+"---------TransactionId="+outTradeNo);
			success.add(payBill);
			try {
				lock.lock();
				condition.signalAll();
			} catch (Exception e) {
				logger.error("condition.signalAll", e);
			} finally {
				lock.unlock();
			}
		}
		return "";
	}

}
