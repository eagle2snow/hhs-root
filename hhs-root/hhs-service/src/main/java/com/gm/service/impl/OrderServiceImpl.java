package com.gm.service.impl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.gm.base.consts.Const;
import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.IOrderDao;
import com.gm.base.dao.ITenReturnOneDao;
import com.gm.base.dto.CartDto;
import com.gm.base.dto.OrderItemDto;
import com.gm.base.model.Cart;
import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.base.model.Order;
import com.gm.base.model.OrderItem;
import com.gm.base.model.PayBill;
import com.gm.base.model.TenReturnOne;
import com.gm.service.ICartService;
import com.gm.service.ICommodityService;
import com.gm.service.IMemberBuyService;
import com.gm.service.IMemberService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.utils.DateUtil;
import com.gm.utils.StringUtil;
import com.xiaoleilu.hutool.util.RandomUtil;

@Transactional
@Service("orderSercive")
public class OrderServiceImpl extends BaseServiceImpl<Order, Integer> implements IOrderService {

	private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);

	@Resource
	private ITenReturnOneDao oneDao;

	@Resource
	private IOrderDao dao;

	@Resource
	private ICartService cartService;

	@Resource
	private IOrderService orderService;

	@Resource
	private PayBillServiceImpl payBillService;

	@Resource
	private IOrderItemService orderItemService;

	@Resource
	private ICommodityService commodityService;

	@Resource
	private IMemberBuyService memberBuyService;

	@Resource
	private IMemberService memberService;

	@Override
	public IBaseDao<Order, Integer> getDao() {
		return dao;
	}

	@Override
	public Map<String, Object> genOrder(Member member, List<CartDto> cartDtos) {

		Map<String, Object> map = new HashMap<>();

		if (cartDtos == null || cartDtos.size() == 0) {
			map.put("s", "noItem");
			return map;
		}

		List<Integer> ids = cartDtos.parallelStream().map(CartDto::getId).collect(Collectors.toList());
		List<Cart> carts = cartService.listIn("id", ids);

		List<Cart> carts2 = new ArrayList<>();

		for (CartDto cartDto : cartDtos) {
			for (Cart cart : carts) {
				if (cart.getId().equals(cartDto.getId())) {
					if (cartDto.getBuyCount().compareTo(cart.getCommodity().getTotalStock()) > 0) {
						carts2.add(cart);
					}
				}
			}
		}

		if (carts2.size() > 0) {
			List<CartDto> noCarts = carts2.stream().map(p -> {
				CartDto cartDto = new CartDto();
				cartDto.setId(p.getId());
				cartDto.setBuyCount(p.getCommodity().getTotalStock());
				return cartDto;
			}).collect(Collectors.toList());
			map.put("s", "no");// 库存不足的
			map.put("noCarts", noCarts);// 库存不足的
		} else {
			Order order = new Order();
			order.setOrderNo(genOrderNo());// 生成订单号
			order.setMember(member);
			order.setStatus("1");
			Integer orderId = dao.saveReturnId(order);
			order.setId(orderId);

			BigDecimal total = BigDecimal.ZERO;

			for (CartDto cartDto : cartDtos) {
				for (Cart cart : carts) {
					if (cart.getId().equals(cartDto.getId())) {
						Commodity commodity = cart.getCommodity();
						OrderItem item = new OrderItem(order, cartDto.getBuyCount(), commodity);
						orderItemService.save(item);

						total = total.add(commodity.getShowPrice().multiply(BigDecimal.valueOf(cartDto.getBuyCount())));

						// 更新库存
						commodity.setTotalStock(commodity.getTotalStock() - cartDto.getBuyCount());
						commodityService.update(commodity);

						// 删除购物车
						cartService.delete(cart, true);
						map.put("orderId", orderId);
					}
				}
			}
			update("totalMoney", total, orderId);// 更新总价
			map.put("s", "ok");
		}
		return map;
	}

	@Override
	public Map<String, Object> prePayOrder(Member member, Integer orderId, Integer addressId,
			List<OrderItemDto> orderItemDtos, String content) {

		Map<String, Object> map = new HashMap<>();

		Order order = get(orderId);

		if (order == null) {
			map.put("s", "null");
			return map;
		} else {
			order.setOrderRemarks(content);
		}

		if (!"1".equals(order.getStatus())) {
			map.put("s", "paid");
			return map;
		}

		updateByHql("update order o set o.memberAddress.id=" + addressId);

		if (orderItemDtos == null || orderItemDtos.size() == 0) {
			map.put("s", "noItem");
			return map;
		}

		List<Integer> itemIds = orderItemDtos.parallelStream().map(OrderItemDto::getOrderItemId)
				.collect(Collectors.toList());
		List<OrderItem> orderItems = orderItemService.listIn("id", itemIds);

		List<OrderItem> orderItems2 = new ArrayList<>();// 库存不足的项

		for (OrderItemDto orderItemDto : orderItemDtos) {
			for (OrderItem item : orderItems) {
				if (item.getId().equals(orderItemDto.getOrderItemId())
						&& orderItemDto.getBuyCount().compareTo(item.getCommodity().getTotalStock()) > 0) {
					orderItems2.add(item);
				}
			}
		}

		if (orderItems2.size() > 0) {
			List<OrderItemDto> noItems = orderItems2.stream().map(p -> {
				OrderItemDto orderItemDto = new OrderItemDto();
				orderItemDto.setOrderItemId(p.getId());
				orderItemDto.setOrderId(orderId);
				orderItemDto.setCommodityId(p.getCommodity().getId());
				orderItemDto.setBuyCount(p.getCommodity().getTotalStock());//
				return orderItemDto;
			}).collect(Collectors.toList());
			map.put("s", "no");// 库存不足
			map.put("noItems", noItems);// 库存不足的商品
		} else {

			BigDecimal total = BigDecimal.ZERO;

			for (OrderItemDto orderItemDto : orderItemDtos) {
				for (OrderItem orderItem : orderItems) {
					if (orderItem.getId().equals(orderItemDto.getOrderItemId())) {
						Commodity commodity = orderItem.getCommodity();
						// 更新库存
						commodity.setTotalStock(
								commodity.getTotalStock() + orderItem.getBuyCount() - orderItemDto.getBuyCount());
						commodityService.update(commodity);

						// 更新购买数量
						orderItem.setBuyCount(orderItemDto.getBuyCount());
						orderItemService.update(orderItem);
						// 计算总价
						total = total
								.add(commodity.getShowPrice().multiply(BigDecimal.valueOf(orderItemDto.getBuyCount())));
					}
				}
			}
			update("totalMoney", total, orderId);// 更新总价
			map.put("s", "ok");
		}
		return map;
	}

	public static String genOrderNo() {
		String s = DateUtil.format(LocalDateTime.now(), DateUtil.f10) + RandomUtil.randomNumbers(5);
		return s;
	}

	/**
	 * 支付成功之后的相关设置
	 */
	@Override
	public void payOrderSuccess(String orderNo) {

		PayBill payBill = payBillService.getOne("orderNo", orderNo);
		logger.info("payBill={}", JSON.toJSON(payBill.getOrderNo()));

		Order order = getOne("orderNo", orderNo);
		List<OrderItem> listEq = null;
		if (!StringUtils.isEmpty(order)) {
			listEq = orderItemService.listEq("order.id", order.getId());
		}

		for (OrderItem item : listEq) {
			Commodity commodity = item.getCommodity();
			// 商品的设置
			if (!StringUtils.isEmpty(commodity.getTotalStock())) {

				commodity.setTotalStock(commodity.getTotalStock() - 1);
			}
			if (!StringUtils.isEmpty(commodity.getSalesVolume())) {

				commodity.setSalesVolume(commodity.getSalesVolume() + 1);
			}
			logger.info("commodity={}", JSON.toJSON(commodity.getName()));
			commodityService.update(commodity);
		}

		// 订单的设置
		order.setStatus("2");
		order.setPostageMoney(BigDecimal.valueOf(0));// 包邮
		order.setPaymentTime(LocalDateTime.now());// 付款时间
		order.setPayPathway(1);// 支付方式
		update(order);

		// saveMemberBuy(order);
		// returnSingleItemPrice(order);
	}

	/**
	 * 确认收货之后的相关设置
	 */
	@Override
	public void confirmGoods(Integer orderId) {

		Order order = orderService.get(orderId);

		PayBill payBill = payBillService.getOne("orderNo", order.getOrderNo());

		List<OrderItem> listEq = orderItemService.listEq("order.id", orderId);
		for (OrderItem item : listEq) {
			logger.info("orderItem={}", JSON.toJSON(item));
			Commodity commodity = item.getCommodity();
			// 商品的设置
			commodity.setTotalStock(commodity.getTotalStock() - 1); // 库存
			commodity.setSalesVolume(commodity.getSalesVolume() + 1);// 销量
			commodityService.update(commodity);
		}

		// 设置订单相关属性
		if (payBill != null) {
			order.setTotalMoney(payBill.getReaFee()); // 订单总额
		}
		order.setStatus("4"); // 4|已收货
		order.setReceivingTime(LocalDateTime.now());// 确认收货时间
		update(order);

		// 规定七天后若是没有客户要求退货就执行订单完成方法
		this.finishGoods(orderId);

	}

	/**
	 * 订单完成
	 */
	private void finishGoods(Integer orderId) {
		try {
			Order order = orderService.get(orderId);
			order.setStatus("10");
			order.setFinishTime(LocalDateTime.now());
			orderService.update(order);

			Member member = order.getMember();

			BigDecimal balance = member.getBalance();

			memberService.tenReturnOne(orderId);
			balance.add(member.getTenReturnOne()); // 十件商品返一件

			memberService.returnFiveMoney(member.getOpenid()); // 返5元

			balance.add(memberService.returnMeal(member.getOpenid())); // 返套餐

			memberService.threeLevel(member.getId()); // 三级分润

			member.setBalance(balance); // 设置可提现余额

			List<OrderItem> listEq = orderItemService.listEq("order.id", orderId);
			List<Commodity> list = null;
			for (OrderItem item : listEq) {
				Commodity commodity = item.getCommodity();
				if (null != commodity) {
					list = new ArrayList<>();
					list.add(commodity);

				}
			}
			member.setLove(member.getLove() + list.size());// 爱心资助
			BigDecimal consume = member.getConsume();
			BigDecimal totalMoney = order.getTotalMoney();
			BigDecimal add = consume.add(totalMoney); // null 一个订单多个商品 会报：Error info is query did not return a unique
			member.setConsume(add);// 消费额 null?

			if (member.getLevel() == 1) {// 如果是访客，升级为普通会员
				member.setLevel(2);// 等级
			}
			// logger.info("member={}", JSON.toJSON(member));
			memberService.update(member);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
