package com.gm.wx.controller;

import java.math.BigDecimal;
import java.util.SortedMap;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.lly835.bestpay.utils.XmlUtil;

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
		
		System.err.println(sb);
		
		PayResponse response2 = WeixinPayApi.getBestPayServiceImpl().asyncNotify(sb.toString());
		System.out.println(response2.getPrePayParams() + "@@");

		return "";

	}

}
