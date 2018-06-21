package com.gm.service.impl;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import com.gm.base.dao.IMemberAccountBillDao;
import com.gm.base.model.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSON;
import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.IOrderDao;
import com.gm.base.dto.CartDto;
import com.gm.base.dto.OrderItemDto;
import com.gm.service.ICartService;
import com.gm.service.ICommodityService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.utils.DateUtil;
import com.xiaoleilu.hutool.util.RandomUtil;

@Transactional
@Service("orderSercive")
public class OrderServiceImpl extends BaseServiceImpl<Order, Integer> implements IOrderService {

	private static final Logger logger = LoggerFactory.getLogger(OrderServiceImpl.class);

	@Resource
	MemberServiceImpl memberService;

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
	private IMemberAccountBillDao accountBillDao;

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

		updateByHql(String.format("update order o set o.memberAddress.id = %d where o.id = %d", addressId, orderId));

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
				if (item.getId().equals(orderItemDto.getOrderItemId()) && (item.getBuyCount()
						- orderItemDto.getBuyCount() - item.getCommodity().getTotalStock()) > 0) {
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
	public void payOrderSuccess(String orderNo, PayBill payBill) {
		Order order = getOne("orderNo", orderNo);
		if (order == null) {
			logger.error("order == null");
			return;
		}

		// 防止购买成功后多次回调
		if (!order.getStatus().trim().equals("1")) {
			logger.error("微信多次回掉");
			return;
		}

		List<OrderItem> items = orderItemService.listEq("order.id", order.getId());
		for (OrderItem item : items) {
			Commodity commodity = item.getCommodity();
			// 商品的设置
			if (commodity.getSalesVolume() != null)
				commodity.setSalesVolume(commodity.getSalesVolume() + item.getBuyCount());
			commodityService.update(commodity);
		}

		// 订单的设置
		order.setStatus("2");
		order.setPostageMoney(BigDecimal.valueOf(0));// 包邮
		order.setPaymentTime(LocalDateTime.now());// 付款时间
		order.setPayPathway(1);// 支付方式
		order.setTotalMoney(payBill.getReaFee());
		update(order);
	}

	/**
	 * 确认收货之后的相关设置
	 */
	@Override
	public void confirmGoods(Integer orderId) {
		Order order = orderService.get(orderId);
		// 防止客户端多次确认
		String status = order.getStatus();
		if (!status.trim().equals("3")) {
			logger.error("客户端多次确认啦");
			return;
		}

		List<OrderItem> listEq = orderItemService.listEq("order.id", orderId);
		for (OrderItem item : listEq) {
			logger.info("orderItem={}", JSON.toJSON(item.getId()));
			Commodity commodity = item.getCommodity();
			// 商品的设置
			if (commodity.getSalesVolume() != null)
				commodity.setSalesVolume(commodity.getSalesVolume() + item.getBuyCount());
			else
				commodity.setSalesVolume(1);
			commodityService.update(commodity);
		}

		PayBill payBill = payBillService.getOne("orderNo", order.getOrderNo());
		// 设置订单相关属性
		if (payBill != null)
			order.setTotalMoney(payBill.getReaFee()); // 订单总额

		order.setReceivingTime(LocalDateTime.now());
		order.setFinishTime(LocalDateTime.now());
		order.setStatus("10");
		Member member = order.getMember();
		update(order);
		finishGoods(member, order);
	}

	/**
	 * 订单完成
	 */
	private void finishGoods(Member member, Order order) {
		try {
			// 十件商品返一件
			// 设置可提现余额
			memberService.tenReturnOne(order.getId());

			List<OrderItem> listEq = orderItemService.listEq("order.id", order.getId());
			int size = 0;
			BigDecimal extract = BigDecimal.ZERO;
			BigDecimal extract1 = BigDecimal.ZERO;
			BigDecimal extract2momey = BigDecimal.valueOf(2);
			if (listEq != null) {
				for (OrderItem item : listEq) {
					extract = extract
							.add(item.getCommodity().getExtract().multiply(BigDecimal.valueOf(item.getBuyCount())));
					extract1 = extract1.add(extract2momey.multiply(BigDecimal.valueOf(item.getBuyCount())));
					size += item.getBuyCount();
				}
			}
			member.setLove(member.getLove() + size);// 爱心资助
			BigDecimal consume = member.getConsume();
			BigDecimal totalMoney = order.getTotalMoney();
			BigDecimal add = consume.add(totalMoney);
			member.setConsume(add);// 消费额 null?

			MemberAccountBill accountBill = new MemberAccountBill();
			accountBill.setSelfId(member.getId());
			accountBill.setCreateTime(LocalDateTime.now());
			accountBill.setType(7); // 7|买商品
			accountBill.setMoney(order.getTotalMoney());
			accountBill.setOrderNo(order.getOrderNo());
			accountBillDao.save(accountBill);

			if (member.getLevel() == 1) // 如果是访客，升级为普通会员
				member.setLevel(2);// 等级

			// 返订单总额0.01%给上家
			// memberService.updateGeneralizeCost(member.getReferrerGeneralizeId(),
			// (order.getTotalMoney().multiply(Const.pushMoney)));
			// 返提成给上，上上，上上上家
			Member m = member;
			for (int i = 1; i <= 3; ++i) {
				m = memberService.getParent(m, 1);

				if (m == null)
					break;
				accountBill = new MemberAccountBill();
				m.setBalance(m.getBalance().add(extract));
				m.setGeneralizeCost(m.getGeneralizeCost().add(extract));
				accountBill.setUpId(m.getId().intValue());
				accountBill.setUpName(m.getNickname());
				accountBill.setType(4); // 4|提成
				accountBill.setMoney(extract);
				accountBill.setSelfId(member.getId());
				accountBill.setSelfName(member.getNickname());
				accountBillDao.save(accountBill);
				memberService.update(m);

			}

			BigDecimal ex = extract1;
			MemberServiceImpl.Count count = memberService.new Count();
			count.iterator(member, (current) -> {
				MemberAccountBill bill = new MemberAccountBill();
				current.setBalance(current.getBalance().add(ex));
				current.setGeneralizeCost(current.getGeneralizeCost().add(ex));
				bill.setUpId(current.getId());
				bill.setUpName(current.getNickname());
				bill.setType(4); // 4|提成
				bill.setMoney(ex);
				bill.setSelfId(member.getId());
				bill.setSelfName(member.getNickname());
				accountBillDao.save(bill);
				memberService.update(current);
			});

			memberService.update(member);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
