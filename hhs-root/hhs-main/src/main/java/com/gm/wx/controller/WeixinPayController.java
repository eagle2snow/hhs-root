package com.gm.wx.controller;

import java.math.BigDecimal;

import javax.annotation.Resource;
import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gm.api.wx.WeixinPayApi;
import com.gm.base.model.Member;
import com.gm.base.model.PayBill;
import com.gm.service.IPayBillService;
import com.gm.service.impl.OrderServiceImpl;
import com.lly835.bestpay.model.PayResponse;

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
	public PayResponse prePay(String orderNo, String orderName, BigDecimal amount) {
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
		PayResponse res = WeixinPayApi.pay(orderNo, orderName, amount, getCurMember().getOpenid());
		return res;
	}

	@RequestMapping("/prePayCombo")
	@ResponseBody
	public PayResponse prePayCombo() {
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
		PayResponse res = WeixinPayApi.pay(payBill.getOrderNo(),"购买套餐",  BigDecimal.valueOf(398), openid);
		return res;
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
		String time  = response2.getTimeStamp();
		String outTradeNo  = response2.getOutTradeNo();

		payBillService.paySuccess( orderId, amount,  time,outTradeNo);

		return "";

	}

}
