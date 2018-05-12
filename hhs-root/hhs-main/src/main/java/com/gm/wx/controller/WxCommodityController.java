package com.gm.wx.controller;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.base.model.Cart;
import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.service.ICartService;
import com.gm.service.ICommodityService;
import com.gm.service.IMemberService;
import com.gm.utils.DateUtil;

import net.bytebuddy.asm.Advice.This;

/**
 * 
 * <p>
 * Title: WxIndexController
 * </p>
 * 
 * <p>
 * Description: 微信商品
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年4月23日
 */
@Controller
@RequestMapping("/wx/commodity")
public class WxCommodityController extends WeixinBaseController {

	@Resource
	private ICommodityService commodityService;
	@Resource
	private ICartService cartService;
	@Resource
	private IMemberService memberService;

	private static final String PATH = "/wx/commodity/";

	/**
	 * 商品详情
	 * 
	 * <p>
	 * Title: index
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/commodityDetail/{id}")
	public String commodityDetail(ModelMap map, @PathVariable Integer id) {

		Commodity commodity = commodityService.get(id);
		logger.info("commodityDetail:The Commodity to json is {}", JSON.toJSON(commodity));
		if (!StringUtils.isEmpty(commodity.getBrowse())) {
			commodity.setBrowse(commodity.getBrowse() + 1);
		} else {
			commodity.setBrowse(1);
		}

		map.put("model", commodity);
		map.put("member", this.getCurMember());
		map.put("date", DateUtil.dateToStr(new Date(), 12));
		map.put("path", PATH);

		return PATH + "commodityDetail";
	}

	/**
	 * 
	 * 
	 * <p>
	 * Title: addToCart
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param cid
	 *            商品id
	 * @param memberId
	 *            会员 id
	 * @param count
	 *            购买数量
	 * @return
	 */
	@RequestMapping("/addToCart/{commodityId}/{count}")
	@ResponseBody
	public Map<String, Object> addToCart(@PathVariable Integer commodityId, @PathVariable Integer count) {
		Map<String, Object> map = new HashMap<>();

		Member member = getCurMember();

		Cart cart = cartService.checkCommodityInCart(member.getId(), commodityId);
		if (cart != null) {
			cart.setBuyCount(cart.getBuyCount() + 1);
			cartService.update(cart);
			map.put("s", "ok");
		} else {
			cart = new Cart();
			cart.setMember(member);
			cart.setBuyCount(count);
			cart.setCommodity(commodityService.get(commodityId));
			if (cartService.save(cart)) {
				map.put("s", "ok");
			} else {
				map.put("s", "no");
			}
		}
		return map;
	}

	/**
	 * 查看购物车
	 * 
	 * <p>
	 * Title: showCart
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param map
	 * @param memberId
	 *            会员id
	 * @return
	 */
	@RequestMapping("/showCart")
	public String showCart(ModelMap map) {

		List<Cart> carts = cartService.listEq("member.id", getCurMember().getId());
		/*
		 * BigDecimal total = carts.parallelStream().peek(p -> p.setHad(true)).map(p ->
		 * { return
		 * p.getCommodity().getShowPrice().multiply(BigDecimal.valueOf(p.getBuyCount()))
		 * ; }).reduce(BigDecimal.ZERO, BigDecimal::add); map.put("total", total);
		 */
		carts.parallelStream().forEach(p -> p.setHad(true));
		map.put("carts", JSON.toJSONString(carts));
		map.put("path", PATH);
		return PATH + "cart";
	}

	/**
	 * 更新购物车购买数量
	 * 
	 * <p>
	 * Title: updateCart
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param cartId
	 *            购物车id
	 * @param count
	 *            购买数量
	 * @return
	 */
	@RequestMapping("/updateCart/{cartId}/{count}")
	@ResponseBody
	public Map<String, Object> updateCart(@PathVariable Integer cartId, @PathVariable Integer count) {
		Map<String, Object> map = new HashMap<>();
		Cart cart = cartService.get(cartId);
		if (cart.getCommodity().getTotalStock() < count) {
			map.put("s", -1);
		} else {
			cart.setBuyCount(count);
			cartService.update(cart);
			map.put("s", 1);
		}
		return map;
	}

	/**
	 * 结算
	 * 
	 * <p>
	 * Title: sett
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/sett")
	public String sett(ModelMap map) {
		map.put("path", PATH);
		return PATH + "confirmOrder";
	}

	/**
	 * 支付成功
	 * 
	 * <p>
	 * Title: paySuccess
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/paySuccess")
	public String paySuccess(ModelMap map, Integer orderId, String amount) {
		map.put("orderId", orderId);
		map.put("amount", amount);
		map.put("path", PATH);
		return PATH + "paySuccess";
	}

	/**
	 * 支付失败
	 * 
	 * <p>
	 * Title: payFail
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/payFail")
	public String payFail(ModelMap map, Integer orderId) {
		map.put("orderId", orderId);
		map.put("path", PATH);
		return PATH + "payFail";
	}

}
