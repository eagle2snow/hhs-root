package com.gm.wx.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.base.consts.Const;
import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.base.query.Page;
import com.gm.service.ICommodityService;
import com.gm.service.IMemberService;
import com.gm.utils.AESCoder;
import com.gm.utils.StringUtil;

/**
 * 
 * <p>
 * Title: WxIndexController
 * </p>
 * 
 * <p>
 * Description: 微信入口
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年4月23日
 */
@Controller
@RequestMapping("/wx")
public class WxIndexController extends WeixinBaseController {

	@Resource
	private ICommodityService commodityService;

	@Resource
	private IMemberService memberService;

	private static final String PATH = "wx/";

	/**
	 * 
	 * 
	 * <p>
	 * 描述:首页入口
	 * </p>
	 * 
	 * @author 灰灰
	 * 
	 * @param generalizeId
	 *            推荐人id
	 * 
	 * @date 2018年4月28日
	 * 
	 * @version 1.0
	 */
	@RequestMapping("/index/{id}")
	public String index(ModelMap map, String generalizeId, HttpSession session, @PathVariable Integer id) {
		if (!StringUtil.strNullOrEmpty(generalizeId)) {
			Member member = getRealMember();
			if (StringUtil.strNullOrEmpty(member.getReferrerGeneralizeId())) {
				member.setReferrerGeneralizeId(AESCoder.decryptResultStr(generalizeId, Const.PASSWORD_SECRET));
				memberService.update(member);
				session.setAttribute(Const.CUR_WX_MEMBER, member);
			}
		}
		session.setAttribute("iid", id);
		map.put("page", getCommodityData(id));
		map.put("path", PATH);

		return PATH + "/index";
	}

	/**
	 * 
	 * 
	 * <p>
	 * 描述:首页入口
	 * </p>
	 * 
	 * @author 灰灰
	 * 
	 * @param generalizeId
	 *            推荐人id
	 * 
	 * @date 2018年4月28日
	 * 
	 * @version 1.0
	 */
	@RequestMapping("/index")
	public String index(ModelMap map, String generalizeId, HttpSession session) {
		if (!StringUtil.strNullOrEmpty(generalizeId)) {
			Member member = getRealMember();
			if (StringUtil.strNullOrEmpty(member.getReferrerGeneralizeId())) {
				member.setReferrerGeneralizeId(AESCoder.decryptResultStr(generalizeId, Const.PASSWORD_SECRET));
				memberService.update(member);
				session.setAttribute(Const.CUR_WX_MEMBER, member);
			}
		}
		int id = 1;
		if (!(session.getAttribute("iid") == null)) {
			id = (int) session.getAttribute("iid");
		}
		map.put("page", getCommodityData(id));
		map.put("path", PATH);
		logger.info("Map map = {}", JSON.toJSON(map));
		return PATH + "/index";
	}

	/**
	 * 分页获取商品数据
	 * 
	 * <p>
	 * Title: getCommodityData
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param id
	 *            1.酒 2.纸
	 * @return
	 */
	@RequestMapping("/getCommodityData/{id}")
	@ResponseBody
	public Page<Commodity> getCommodityData(@PathVariable Integer id) {
		DetachedCriteria dc = DetachedCriteria.forClass(Commodity.class);
		dc.addOrder(Order.desc("sort"));
		if (id == 1) {
			dc.add(Restrictions.like("code", "1", MatchMode.ANYWHERE));
		} else {
			dc.add(Restrictions.like("code", "2", MatchMode.ANYWHERE));
		}

		return commodityService.list(dc, 1, 10);
	}

	/**
	 * @Description: 去公司简介页面
	 * @param model
	 * @return String
	 */
	@RequestMapping("profile")
	public String setProfileView(ModelMap model) {
		model.put("member", this.getCurMember());
		model.put("path", PATH);
		return PATH + "profile";
	}

	/**
	 * @Title: setMealView
	 * @Description: 去购买套餐页面
	 * @param model
	 * @return String
	 */
	@RequestMapping("/setMeal")
	public String setMealView(ModelMap model) {
		model.put("member", this.getCurMember());
		model.put("path", PATH);
		return PATH + "setMeal";
	}

	/**
	 * @Title: payMemberSuccess @Description: 购买会员套餐成功 @param model @return @return:
	 *         String @throws
	 */
	@RequestMapping("/payMemberSuccess")
	public String payMemberSuccess(ModelMap model) {
		Member curMember = this.getCurMember();
		model.put("path", PATH);
		model.put("member", curMember);

		System.out.println("购买套餐成功");
		
		if (StringUtils.isEmpty(curMember.getConsume())) {
			curMember.setConsume(Const.MEMBER_AMOUNT);
		} else {
			curMember.setConsume(curMember.getConsume().add(Const.MEMBER_AMOUNT));
		}
		if (StringUtils.isEmpty(curMember.getLove())) {
			curMember.setLove(1);
		} else {
			curMember.setLove(curMember.getLove() + 1);
		}

		return PATH + "payMemberSuccess";
	}

	/**
	 * 
	 * @Title: payMemberFail @Description: 购买会员套餐失败 @param model @return @return:
	 *         String @throws
	 */
	@RequestMapping("/payMemberFail")
	public String payMemberFail(ModelMap model) {
		model.put("member", this.getCurMember());
		model.put("path", PATH);
		return PATH + "payMemberFail";
	}

}
