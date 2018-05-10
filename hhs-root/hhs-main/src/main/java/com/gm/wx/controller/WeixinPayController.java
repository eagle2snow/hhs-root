package com.gm.wx.controller;

import java.math.BigDecimal;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gm.api.wx.WeixinPayApi;
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

	@RequestMapping("/prePay")
	@ResponseBody
	public PayResponse prePay(String orderNo, String orderName, BigDecimal amount) {
		System.err.println("发起支付＝＝> orderNo:" + orderNo + " | orderName:" + orderName + " | amount:" + amount);
		amount = BigDecimal.valueOf(0.01);
		PayResponse res = WeixinPayApi.pay(orderNo, orderName, amount, getCurMember().getOpenid());
		return res;
	}

}
