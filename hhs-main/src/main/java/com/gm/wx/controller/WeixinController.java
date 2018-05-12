package com.gm.wx.controller;

import java.io.IOException;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.sd4324530.fastweixin.api.response.GetUserInfoResponse;
import com.github.sd4324530.fastweixin.api.response.OauthGetTokenResponse;
import com.github.sd4324530.fastweixin.message.BaseMsg;
import com.github.sd4324530.fastweixin.message.TextMsg;
import com.github.sd4324530.fastweixin.message.req.TextReqMsg;
import com.github.sd4324530.fastweixin.servlet.WeixinControllerSupport;
import com.gm.api.wx.WeiXinApi;
import com.gm.base.consts.Const;
import com.gm.base.model.Member;
import com.gm.service.IMemberService;
import com.gm.utils.StringUtil;

/**
 * 微信认证入口
 * 
 * @author ying-pc
 *
 */
@RestController
@RequestMapping("/wx")
public class WeixinController extends WeixinControllerSupport {
	private static final Logger log = LoggerFactory.getLogger(WeixinController.class);
	private static final String TOKEN = Const.TOKEN;
	private static final String APPID = Const.APPID;

	@Resource
	private IMemberService memberService;

	// 设置TOKEN，用于绑定微信服务器
	@Override
	protected String getToken() {
		return TOKEN;
	}

	// 使用安全模式时设置：APPID
	@Override
	protected String getAppId() {
		return APPID;
	}

	// 使用安全模式时设置：密钥
	@Override
	protected String getAESKey() {
		return null;
	}

	// 重写父类方法，处理对应的微信消息
	@Override
	protected BaseMsg handleTextMsg(TextReqMsg msg) {
		String content = msg.getContent();
		log.info("收到消息：" + content);
		return new TextMsg("http://aijfc.iask.in/wx/index");
	}

	@RequestMapping("/testLogin/{memberId}")
	public String testLogin(@PathVariable Integer memberId, HttpSession session) {

		Member member = memberService.get(memberId);
		if (member != null) {
			session.setAttribute(Const.CUR_WX_MEMBER, member);
			return "ok";
		} else {
			return "no member";
		}

	}

	@RequestMapping("/saveMember")
	public void saveMember(String code, String state, HttpServletResponse response, HttpSession session) {
		OauthGetTokenResponse re = WeiXinApi.getOauthAPI().getToken(code);
		String openid = re.getOpenid();
		if (!StringUtil.strNullOrEmpty(openid)) {
			Member member = memberService.getOne("openid", openid);
			if (null == member) {
				member = memberService.saveWeixinMember(openid);
			}
			session.setAttribute(Const.CUR_WX_MEMBER, member);
		}
		try {
			response.sendRedirect(state);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping("/getUserInfo")
	public void getUserInfo(String code, String state, HttpServletResponse response, HttpSession session) {
		OauthGetTokenResponse re = WeiXinApi.getOauthAPI().getToken(code);
		String openid = re.getOpenid();
		GetUserInfoResponse response2 = WeiXinApi.getOauthAPI().getUserInfo(re.getAccessToken(), openid);
		Member member = memberService.getOne("openid", openid);
		if (member == null) {
			member = memberService.saveWeixinMember(response2);
		} else {
			member = memberService.updateWeixinMember(member, response2);
		}
		session.setAttribute(Const.CUR_WX_MEMBER, member);
		try {
			response.sendRedirect(state);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}