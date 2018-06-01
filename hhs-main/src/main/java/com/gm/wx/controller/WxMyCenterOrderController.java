package com.gm.wx.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.sd4324530.fastweixin.api.response.GetSignatureResponse;
import com.gm.api.wx.WeiXinApi;
import com.gm.base.consts.Const;
import com.gm.base.model.Member;
import com.gm.base.model.Order;
import com.gm.base.model.OrderItem;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.service.impl.MemberServiceImpl;
import com.gm.utils.PathUtil;

/**
 * 
 * <p>
 * Description: 个人中心订单
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年5月3日
 */
@Controller
@RequestMapping("/wx/myCenter/order/")
public class WxMyCenterOrderController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WxMyCenterOrderController.class);
	private static final String PATH = "wx/myCenter/order/";

	@Autowired
	private MemberServiceImpl memberService;

	@Resource
	private IOrderService orderService;

	@Resource
	private IOrderItemService orderItemService;

	/**
	 * 
	 * <p>
	 * Title: myOrders
	 * </p>
	 * 
	 * <p>
	 * Description: 我的订单
	 * </p>
	 * 
	 * @param map
	 * @param type
	 *            1
	 * @return
	 */
	@RequestMapping("myOrders/{status}")
	public String myOrders(ModelMap map, @PathVariable Integer status)
	{
		Member member = getCurMember();
		String hql = "from order o where o.member.id=" + member.getId() + " and o.deleted=1";
		if (status != 0)
			hql += " and o.status=" + status;
		List<Order> orders = orderService.list(hql);
		if (orders.size() > 0) {
			List<Integer> orderIds = orders.parallelStream().map(Order::getId).collect(Collectors.toList());
			List<OrderItem> items = orderItemService.listIn("order.id", orderIds);
			orders.forEach(p -> p.setItems(
					items.stream().filter(q -> q.getOrder().getId().equals(p.getId())).collect(Collectors.toList())));
		}
		map.put("orders", orders);
		map.put("path", PATH);
		return PATH + "myOrders";
	}

	/**
	 * 
	 * <p>
	 * 描述:去退货
	 * </p>
	 * 
	 * @author 灰灰
	 * 
	 * @date 2018年5月3日
	 * 
	 * @version 1.0
	 */
	@RequestMapping("toBackOrder/{orderId}")
	public String toBackOrder(ModelMap map, @PathVariable Integer orderId)
	{
		String httpUrl = PathUtil.getHttpUrl(getRequest());
		System.out.println(httpUrl);
		GetSignatureResponse res = WeiXinApi.getJsAPI().getSignature(httpUrl);
		map.put("appId", Const.APPID);
		map.put("res", res);
		map.put("order", orderService.get(orderId));
		map.put("path", PATH);
		return PATH + "backOrder";
	}

	/**
	 * 
	 *<p>Title:pushOrders</p>
	 *<p>Description:提成订单</p>
	 *
	 * @param map
	 * @param type 1:未确认 2:已确认
	 * @return
	 */
	@RequestMapping("pushOrders/{type}")
	public String pushOrders(ModelMap map, @PathVariable Integer type) {
		String generalizeId = this.getCurMember().getGeneralizeId();
		List<Member> list = memberService.listEq("referrerGeneralizeId", generalizeId);
		List<Order> listEq = new ArrayList<>();
		for (Member order : list) {
			listEq.addAll(orderService.listEq("member.id", order.getId()));
		}
		map.put("order", listEq);
		map.put("path", PATH);
		return PATH + "pushOrders";
	}

	/**
	 * 
	 *<p>Title:lookExpressage</p>
	 *<p>Description:查看快递</p>
	 *
	 * @param orderId 
	 * @return name：快递名称 ：快递单号
	 */
	@ResponseBody
	@RequestMapping("lookExpressage/{orderId}")
	public HashMap<String, Object> lookExpressage(@PathVariable Integer orderId) {
		HashMap<String, Object> map = this.getMap();
		Order order = orderService.get(orderId);
		String name = "";
		name = order.getExpressName() + ":" + order.getExpressNo();
		map.put("name", name);
		return map;
	}
}
