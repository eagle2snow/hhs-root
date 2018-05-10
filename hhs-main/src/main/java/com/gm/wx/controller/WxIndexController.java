package com.gm.wx.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
		map.put("page", getCommodityData(1));
		map.put("path", PATH);
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
	 * @param pageIndex
	 * @return
	 */
	@RequestMapping("/getCommodityData/{pageIndex}")
	@ResponseBody
	public Page<Commodity> getCommodityData(@PathVariable Integer pageIndex) {
		DetachedCriteria dc = DetachedCriteria.forClass(Commodity.class);
		dc.addOrder(Order.desc("sort"));
		return commodityService.list(dc, pageIndex, 10);
	}

	/**
	 * @Title: setMealView
	 * @Description: 去购买套餐页面
	 * @param memberId
	 * @param model
	 * @return String
	 */
	@RequestMapping("setMeal/{memberId}")
	public String setMealView(@PathVariable String memberId, ModelMap model) {

		model.put("member", this.getCurMember());
		model.put("path", PATH);

		return PATH + "setMeal";

	}

	/**
	 * @Title: setMealView
	 * @Description: 确定购买套餐
	 * @param memberId
	 *            会员ID
	 * @param model
	 *            页面封装信息
	 * @return String 购买套餐页面
	 */
	@ResponseBody
	@RequestMapping("setMealAction/{memberId}")
	public Map<String, Object> setMealAction(@PathVariable String memberId) {

		Member curMember = this.getCurMember();
		HashMap<String, Object> map = this.getMap();

		if (curMember.getSetMeal() == 1) { // 未购买套餐
			map.put("msg", "no");
			curMember.setSetMeal(2);
			curMember.setLevel(3);

		} else if (curMember.getSetMeal() == 2) {
			curMember.setLevel(3);
			map.put("msg", "ok");

		} else {
			map.put("msg", "error");

		}

		logger.info("shippingAddressView: the ModelMap to json is {}.", JSON.toJSONString(map));

		map.put("path", PATH);

		return map;

	}

}
