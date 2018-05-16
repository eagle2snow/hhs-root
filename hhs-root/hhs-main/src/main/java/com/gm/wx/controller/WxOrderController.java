package com.gm.wx.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.gm.base.dto.CartDto;
import com.gm.base.dto.OrderItemDto;
import com.gm.base.model.Member;
import com.gm.base.model.MemberAddress;
import com.gm.base.model.Order;
import com.gm.base.model.OrderItem;
import com.gm.service.ICartService;
import com.gm.service.ICommodityService;
import com.gm.service.IMemberAddressService;
import com.gm.service.IMemberService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.utils.StringUtil;

/**
 * 
 * <p>
 * Title: WxIndexController
 * </p>
 * 
 * <p>
 * Description: 微信订单
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年4月23日
 */
@Controller
@RequestMapping("/wx/order")
public class WxOrderController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WxOrderController.class);

	@Resource
	private ICommodityService commodityService;
	@Resource
	private ICartService cartService;
	@Resource
	private IMemberService memberService;
	@Resource
	private IOrderService orderService;
	@Resource
	private IOrderItemService orderItemService;
	@Resource
	private IMemberAddressService memberAddressService;

	private static final String PATH = "/wx/order/";

	/**
	 * @Title: exitGoods   
	 * @Description:退货申请 
	 * @param orderId
	 * @return      
	 * @return: Map<String,Object>      
	 * @throws
	 */
	@ResponseBody
	@RequestMapping("exitGoods/{orderId}")
	public Map<String, Object> exitGoods(@PathVariable Integer orderId){
		HashMap<String,Object> map = this.getMap();
		
		
		return map;
	}

	/**
	 * @Title: cancelOrder   
	 * @Description: 取消订单 物理删除库中订单信息
	 * @param orderId
	 * @return      
	 * @return: Map<String,Object>      
	 * @throws
	 */
	@ResponseBody
	@GetMapping("cancelOrder/{orderId}")
	public Map<String, Object> cancelOrder(@PathVariable Integer orderId) {
		HashMap<String, Object> map = this.getMap();

		try {
			// 通过关联的实体删除实体
			orderItemService.deleteByParm("order.id", orderId, true);

			orderService.deleteById(orderId, true);

			map.put("status", 1);
			map.put("msg", "订单取消成功");

		} catch (Exception e) {
			map.put("status", 2);
			map.put("msg", "系统正在维护");

			logger.error("cancelOrder:Error info is {}", e.getMessage());

		}

		logger.error("cancelOrder:The Map map = {}", JSON.toJSON(map));
		return map;
	}

	/**
	 * <p>
	 * Title: addOrder
	 * </p>
	 * 
	 * <p>
	 * Description: 提交订单
	 * </p>
	 * 
	 * @param map
	 * @param id
	 * @return
	 */
	@RequestMapping("/addOrder")
	@ResponseBody
	public Map<String, Object> addOrder(String cartsStr) {
		List<CartDto> carts = JSON.parseArray(cartsStr, CartDto.class);
		Member member = getCurMember();
		Map<String, Object> map = orderService.genOrder(member, carts);
		return map;
	}

	/**
	 *
	 * 
	 * <p>
	 * Title: confirmOrder
	 * </p>
	 * 
	 * <p>
	 * Description: 确认订单
	 * </p>
	 * 
	 * @param orderId
	 *            订单id
	 * @param addressId
	 *            收货地址id
	 * @param map
	 * @return
	 */
	@RequestMapping("/confirmOrder/{orderId}")
	public String confirmOrder(@PathVariable Integer orderId, ModelMap map, String addressId) {
		Member member = getCurMember();
		Order order = orderService.get(orderId);

		if (!StringUtil.strNullOrEmpty(addressId)) {
			MemberAddress orderAddress = memberAddressService.get(Integer.parseInt(addressId));
			if (null != orderAddress) {
				order.setMemberAddress(orderAddress);
				orderService.update(order);
			}
		} else {
			if (null == order.getMemberAddress()) {
				MemberAddress orderAddress = memberAddressService.getOne("from memberAddress m where m.member.id="
						+ member.getId() + " and m.deleted=1 and m.enable=1 and m.defaultAddress=1");
				if (null == orderAddress) {
					List<MemberAddress> list = memberAddressService.listEq("member.id", member.getId());
					if (list.size() > 0) {
						orderAddress = list.get(list.size() - 1);
					}
				}
				order.setMemberAddress(orderAddress);
				orderService.update(order);
			}
		}

		List addressList = memberAddressService.go().pq("id").pq("name").pq("mobile").pq("pca").pq("address")
				.pq("defaultAddress").eq("member.id", member.getId()).pqList();
		map.put("addressList", JSON.toJSONString(addressList));
		map.put("order", JSON.toJSONString(order));
		List<OrderItem> items = orderItemService.listEq("order.id", orderId);
		map.put("items", JSON.toJSONString(items));
		map.put("path", PATH);
		map.put("orderId", orderId);
		if (null != order.getMemberAddress()) {
			map.put("orderAddressId", order.getMemberAddress().getId());
		}
		return PATH + "confirmOrder";
	}

	/**
	 * 
	 * 
	 * <p>
	 * Title: addAddress
	 * </p>
	 * 
	 * <p>
	 * Description:新增收货地址
	 * </p>
	 * 
	 * @param map
	 * @return
	 */
	@RequestMapping("/addAddress/{orderId}")
	public String addAddress(ModelMap map, @PathVariable Integer orderId) {
		map.put("path", PATH);
		map.put("orderId", orderId);
		return PATH + "addAddress";
	}

	@ResponseBody
	@RequestMapping("/addAddressAction")
	public Map<String, Object> addAddressAction(MemberAddress address, String defautlocal) {
		Map<String, Object> map = new HashMap<>();
		Member member = getCurMember();
		if ("on".equals(defautlocal)) {
			address.setDefaultAddress(1);
			memberAddressService
					.updateByHql("update memberAddress a set a.defaultAddress=2 where a.member.id=" + member.getId());
		} else {
			address.setDefaultAddress(2);
		}

		address.setMember(member);

		Integer addressId = memberAddressService.saveReturnId(address);
		if (addressId > 0) {
			map.put("addressId", addressId);
		} else {
			map.put("addressId", 0);
		}
		return map;
	}

	/**
	 * 
	 * 
	 * <p>
	 * Title: prePayOrder
	 * </p>
	 * 
	 * <p>
	 * Description: 支付前检查
	 * </p>
	 * 
	 * @param orderId
	 *            订单id
	 * @param addressId
	 *            订单地址
	 * @param cartsStr
	 *            下单商品及数量
	 * @param content
	 *            订单备注
	 * @return
	 */
	@RequestMapping("/prePayOrder")
	@ResponseBody
	public Map<String, Object> prePayOrder(Integer orderId, Integer addressId, String itemsStr, String content) {
		List<OrderItemDto> items = JSON.parseArray(itemsStr, OrderItemDto.class);
		Member member = getCurMember();
		Map<String, Object> map = orderService.prePayOrder(member, orderId, addressId, items, content);
		return map;
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
		logger.info("paySuccess:The args orderId={},amount={}",orderId,amount);
		
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