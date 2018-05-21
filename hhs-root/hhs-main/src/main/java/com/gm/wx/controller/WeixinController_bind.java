package com.gm.wx.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * 微信认证入口
 * 
 * @author ying-pc
 *
 */
//@RestController
//@RequestMapping("/wx")
public class WeixinController_bind {

	/**
	 * 绑定微信服务器
	 *
	 * @param request
	 *            请求
	 * @return 响应内容
	 */
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	protected void bind(HttpServletRequest request, HttpServletResponse response) {
		String s = request.getParameter("echostr");
		try {
			response.getOutputStream().print(s);
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
}