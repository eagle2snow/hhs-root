package com.gm.wx.controller;

import java.io.File;

import javax.annotation.Resource;

import com.gm.base.consts.Const;
import com.gm.base.controller.BaseController;
import com.gm.base.model.Member;
import com.gm.service.IMemberService;

/**
 * 
 * <p>
 * Title: WeixinBaseController
 * </p>
 * 
 * <p>
 * Description: 微信基类控制器
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年4月26日
 */
public class WeixinBaseController extends BaseController {
	@Resource
	private IMemberService memberService;

	/**
	 * 
	 * <p>
	 * Title: getCurMember
	 * </p>
	 * 
	 * <p>
	 * Description: 获取当前登录会员
	 * </p>
	 * 
	 * @return
	 */
	public Member getCurMember() {
		return (Member) getRequest().getSession().getAttribute(Const.CUR_WX_MEMBER);
	}

	/**
	 * 
	 * <p>
	 * Title: getRealMember
	 * </p>
	 * 
	 * <p>
	 * Description: 获取库里面的会员
	 * </p>
	 * 
	 * @return
	 */
	public Member getRealMember() {
		return memberService.get(getCurMember().getId());
	}

	public Integer getMid() {
		return getCurMember().getId();
	}

	/**
	 * 获取域名
	 * @Title: getDomain   
	 * @Description: 
	 * @return      
	 * @return: String      
	 * @throws
	 */
	public String getDomain() {
		String domain = getRequest().getScheme() + "://" + getRequest().getServerName();
		return domain;
	}

}
