package com.gm.wx.controller;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.gm.service.IMemberService;
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
	
	@Resource
	private IMemberService memberService;

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
	public Map<String, Object> prePay(String orderNo, String orderName, BigDecimal amount) {
		logger.info("prepay:The pay start,ages is orderNo={},orderName={},amount={}", orderNo, orderName, amount);

		amount = BigDecimal.valueOf(0.01);

		PayBill payBill = payBillService.getOne("orderNo", orderNo);
		
		if (null == payBill) {
			payBill = new PayBill();
			payBill.setOrderNo(orderNo);
			payBill.setOpenid(getCurMember().getOpenid());
			payBill.setType(2);
			payBill.setPay(1);
			payBill.setPreFee(amount);
			payBillService.save(payBill);
		}
		logger.info("setMeal is setMeal={}", this.getCurMember().getSetMeal());
		
		Map<String, Object> map = getMap();
		try {
			
				PayResponse res = WeixinPayApi.pay(orderNo, orderName, amount, getCurMember().getOpenid());
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
	public Map<String, Object> prePayCombo() {

		Map<String, Object> map = getMap();

		Member member = getCurMember();
		String openid = member.getOpenid();

		PayBill payBill = new PayBill();
		payBill.setOrderNo(OrderServiceImpl.genOrderNo());
		payBill.setType(1);
		payBill.setPay(1);
		payBill.setOpenid(openid);
		payBill.setPreFee(Const.MEMBER_AMOUNT);
		payBillService.save(payBill);
		try {
			if (member.getSetMeal()==1) {
				PayResponse res = WeixinPayApi.pay(payBill.getOrderNo(), "购买套餐", Const.MEMBER_AMOUNT, openid);
				map.put("s", 1);
				map.put("data", res);
				
			}else {
				map.put("s", "您已购买，请勿重新购买套餐!");
				
			}
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

	// 成功支付
	// produces: 指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回；
	@PostMapping(value = "/paySuccess", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String WeixinParentNotifyPage(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ServletInputStream instream = request.getInputStream();
		StringBuffer sb = new StringBuffer();
		int len = -1;
		byte[] buffer = new byte[1024];

		while ((len = instream.read(buffer)) != -1) {
			sb.append(new String(buffer, 0, len));
		}
		instream.close();

		PayResponse response2 = WeixinPayApi.getBestPayServiceImpl().asyncNotify(sb.toString());

		String orderId = response2.getOrderId();
		Double amount = response2.getOrderAmount();
		String outTradeNo = response2.getOutTradeNo();

		payBillService.paySuccess(orderId, amount, outTradeNo);

		return "";

	}

}