package com.gm.wx.controller;

import java.math.BigDecimal;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.github.sd4324530.fastweixin.api.response.GetSignatureResponse;
import com.gm.api.wx.WeiXinApi;
import com.gm.api.wx.WeixinPayApi;
import com.gm.base.consts.Const;
import com.gm.utils.PathUtil;
import com.lly835.bestpay.model.PayResponse;
import com.lly835.bestpay.service.impl.BestPayServiceImpl;
import com.lly835.bestpay.utils.JsonUtil;

/**
 * 
 * 
 * <p>
 * Description: 支付回调
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年5月7日
 */
@RequestMapping("/wx/testPay")
@Controller
public class WeixinPayNotifyController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WeixinPayNotifyController.class);

	// 支付测试
	@RequestMapping("/pay")
	public String testPay(ModelMap map) {
		String httpUrl = PathUtil.getHttpUrl(getRequest());
		logger.info("testpay:The HttpUrl = {}", httpUrl);

		GetSignatureResponse res = WeiXinApi.getJsAPI().getSignature(httpUrl);

		map.put("appId", Const.APPID);
		map.put("res", res);

		logger.info("testpay:The Map map = {}", JSON.toJSON(map));

		return "/wx/pay/test";
	}

	// 支付前
	@RequestMapping("/prePay")
	@ResponseBody
	public PayResponse prePay() {
		logger.info("prePay:发起支付  . . .");

		String orderNo = System.currentTimeMillis() + "";

		PayResponse res = WeixinPayApi.pay(orderNo, "aaaaaaaaa", BigDecimal.valueOf(0.01), getCurMember().getOpenid());
		logger.info("prePay:The PayResponse res = {}", JSON.toJSON(res));

		return res;
	}

	// 成功支付
	@PostMapping("/paySuccess")
	public ModelAndView notify(@RequestBody String notifyData) throws Exception {
		logger.info("【异步回调】request={}", notifyData);
		PayResponse response = new BestPayServiceImpl().asyncNotify(notifyData);
		logger.info("【异步回调】response={}", JsonUtil.toJson(response));

		return new ModelAndView("pay/success");
	}

}
