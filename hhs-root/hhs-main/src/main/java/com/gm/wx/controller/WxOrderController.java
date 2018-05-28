package com.gm.wx.controller;

import java.math.BigDecimal;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.base.dto.CartDto;
import com.gm.base.dto.OrderItemDto;
import com.gm.base.model.Member;
import com.gm.base.model.MemberAddress;
import com.gm.base.model.Order;
import com.gm.base.model.OrderItem;
import com.gm.base.model.PayBill;
import com.gm.service.ICartService;
import com.gm.service.ICommodityService;
import com.gm.service.IMemberAddressService;
import com.gm.service.IMemberService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.service.IPayBillService;
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
@RequestMapping("wx/order")
public class WxOrderController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WxOrderController.class);

	@Resource
	private IPayBillService payBillService;
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
	
	// 查看订单
	@GetMapping("lookOrder/{orderId}")
	public String lookOrderView(@PathVariable Integer orderId, Model model) {
		Order order = orderService.get(orderId);
		if (order == null)
			return "error/404";
		
		BigDecimal sum = new BigDecimal(0);
		int itemSize = 0;
		List<OrderItem> items = orderItemService.listEq("order.id", order.getId());
		if (items == null)
			return "error/404";
		for (OrderItem item : items) {
			sum = sum.add(item.getOriginalPrice().multiply(new BigDecimal(item.getBuyCount())));
			itemSize +=item.getBuyCount();
		}

		
		List<PayBill> bills = payBillService.listEq("orderNo", order.getOrderNo());
		if (bills == null || bills.size() != 1) {
			model.addAttribute("transactionId", "");
			model.addAttribute("reaFee", "");
		} else {
			model.addAttribute("transactionId", bills.get(0).getTransactionId());
			model.addAttribute("reaFee", bills.get(0).getReaFee());
		}

		
		model.addAttribute("items", items);
		model.addAttribute("itemSize", itemSize);
		model.addAttribute("order", order);
		model.addAttribute("sum", sum);
		BigDecimal discount = sum.subtract(bills.get(0).getReaFee());
//		BigDecimal discount = sum.subtract(order.getTotalMoney());
		model.addAttribute("discount", discount.compareTo(new BigDecimal(0)) < 0 ? 0 : discount);
		
		if (order.getCreateTime() != null)
			model.addAttribute("createTime", order.getCreateTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		else
			model.addAttribute("createTime", "");
		
		if (order.getPaymentTime() != null)
			model.addAttribute("paymentTime", order.getPaymentTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
		else
			model.addAttribute("paymentTime", "");
		
		return PATH + "lookOrder";
	}

	// 给我加急
	@ResponseBody
	@RequestMapping("urgent/{orderId}")
	public Map<String, Object> urgent(@PathVariable Integer orderId) {
		logger.info("urgent:method starting ~~~");

		HashMap<String, Object> map = this.getMap();
		Order order = orderService.get(orderId);
		order.setStatus("11");// 加急
		orderService.update(order);
		map.put("status", 1);
		map.put("msg", "加急请求已送达，请耐心等候！");
		logger.info("urgent:Order order = {}", JSON.toJSON(order));

		return map;
	}

	/**
	 * @Title: confirmGoods    
	 * @Description: 确定收货
	 * @param orderId
	 * @return      
	 * @return: Map<String,Object>      
	 * @throws
	 */
	@ResponseBody
	@GetMapping("confirmGoods/{orderId}")
	public Map<String, Object> confirmGoods(@PathVariable Integer orderId) {

		HashMap<String, Object> map = this.getMap();

		try {
			Order order = orderService.get(orderId);
			order.setStatus("4");
			// 调用订单确认收货处理器
			orderService.confirmGoods(orderId);
			map.put("status", 1);
			map.put("msg", "确认收货成功");

		} catch (Exception e) {
			map.put("status", 2);
			map.put("msg", "系统正在维护");

			logger.error("confirmGoods:Error info is {}", e.getMessage());

		}
		logger.error("confirmGoods:The Map map = {}", JSON.toJSON(map));
		return map;
	}

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
	public Map<String, Object> exitGoods(@PathVariable Integer orderId) {
		HashMap<String, Object> map = this.getMap();

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
	@SuppressWarnings("all")
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

		List<MemberAddress> addressList = memberAddressService.go().pq("id").pq("name").pq("mobile").pq("pca").pq("address")
				.pq("defaultAddress").eq("member.id", member.getId()).pqList();
		map.put("addressList", JSON.toJSON(addressList));
		map.put("order", JSON.toJSON(order));
		List<OrderItem> items = orderItemService.listEq("order.id", orderId);
		map.put("items", JSON.toJSON(items));
		map.put("path", PATH);
		map.put("orderId", orderId);
		if (null != order.getMemberAddress()) {
			map.put("orderAddressId", order.getMemberAddress().getId());
		}
		logger.info("支付表内容:{}." + JSON.toJSONString(map));
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

		if (!StringUtil.isMobile(address.getMobile())) {
			map.put("addressId", 0);
			return map;
		}

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
		logger.info("paySuccess:The args orderId={},amount={}", orderId, amount);
		
		Order order = orderService.getOne("id",orderId);
		

		PayBill payBill = payBillService.getOne("orderNo", order.getOrderNo());
		map.put("orderId", orderId);
		map.put("amount", payBill.getReaFee());
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
	
	@RequestMapping("pushOrders")
	public String pushOrders(ModelMap map, Integer orderId) {
		map.put("orderId", orderId);
		map.put("path", PATH);
		return PATH + "pushOrders";
	}

}
