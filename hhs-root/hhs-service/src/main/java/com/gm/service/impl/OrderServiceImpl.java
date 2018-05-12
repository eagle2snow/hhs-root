package com.gm.service.impl;

import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.IOrderDao;
import com.gm.base.dto.CartDto;
import com.gm.base.dto.OrderItemDto;
import com.gm.base.model.Cart;
import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.base.model.MemberBuy;
import com.gm.base.model.Order;
import com.gm.base.model.OrderItem;
import com.gm.service.ICartService;
import com.gm.service.ICommodityService;
import com.gm.service.IMemberBuyService;
import com.gm.service.IMemberService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.utils.DateUtil;
import com.xiaoleilu.hutool.util.RandomUtil;

@Transactional
@Service("orderSercive")
public class OrderServiceImpl extends BaseServiceImpl<Order, Integer> implements IOrderService {
	@Resource
	private IOrderDao dao;

	@Resource
	private ICartService cartService;

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
			order.setStatus(1);
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
		}

		if (order.getStatus() != 1) {
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

	@Override
	public void payOrderSuccess(String orderNo) {
		Order order = getOne("orderNo", orderNo);
		order.setStatus(2);
		update(order);

		// saveMemberBuy(order);
		// returnSingleItemPrice(order);
	}

	// 保存购买记录
	private void saveMemberBuy(Order order) {
		Member member = order.getMember();
		order.setStatus(2);// 设为已付款
		List<OrderItem> items = orderItemService.listEq("order.id", order.getId());
		for (OrderItem orderItem : items) {
			for (int i = 0; i < orderItem.getBuyCount(); i++) {
				MemberBuy memberBuy = new MemberBuy();
				memberBuy.setMember(member);
				memberBuy.setCommodity(orderItem.getCommodity());
				memberBuy.setIsReturn(1);
				memberBuy.setPrice(orderItem.getCommodity().getShowPrice());
				memberBuyService.save(memberBuy);
			}
		}
	}

	// 返单品分佣
	private void returnSingleItemPrice(Order order) {
		List<MemberBuy> memberBuys = memberBuyService.listEq("isReturn", 1);
		int n = memberBuys.size();
		for (int i = 0; i < n - 10; i++) {
			MemberBuy memberBuy = memberBuys.get(i);
			Member member = memberBuy.getMember();
			memberService.updateByHql(
					"update member m set m.balance=m.balance+" + memberBuy.getPrice() + " where id=" + member.getId());
			memberBuyService.update("isReturn", 2, memberBuy.getId());
		}
	}

}
