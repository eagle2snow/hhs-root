package com.gm.wx.controller;

import java.math.BigDecimal;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gm.api.pay.exception.BestPayException;
import com.gm.api.pay.model.PayResponse;
import com.gm.api.wx.WeixinPayApi;
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

	@Resource
	private IPayBillService payBillService;

	@RequestMapping("/prePayOrder")
	@ResponseBody
	public Map<String, Object> prePay(String orderNo, String orderName, BigDecimal amount) {
		System.err.println("发起支付＝＝> orderNo:" + orderNo + " | orderName:" + orderName + " | amount:" + amount);
		amount = BigDecimal.valueOf(0.01);
		PayBill payBill = payBillService.getOne("orderNo", orderNo);
		if (null == payBill) {
			payBill = new PayBill();
			payBill.setOrderNo(orderNo);
			payBill.setType(2);
			payBill.setPay(1);
			payBill.setPreFee(amount);
			payBillService.save(payBill);
		}

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

	@RequestMapping("/prePayCombo")
	@ResponseBody
	public Map<String, Object> prePayCombo() {
		Member member = getCurMember();
		String openid = member.getOpenid();
		PayBill payBill = payBillService.getOne("openid", openid);
		if (null == payBill) {
			payBill = new PayBill();
			payBill.setOrderNo(OrderServiceImpl.genOrderNo());
			payBill.setType(1);
			payBill.setPay(1);
			payBill.setPreFee(BigDecimal.valueOf(398));
			payBillService.save(payBill);
		}
		Map<String, Object> map = getMap();
		try {
			PayResponse res = WeixinPayApi.pay(payBill.getOrderNo(), "购买套餐", BigDecimal.valueOf(398), openid);
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

	// 成功支付
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
