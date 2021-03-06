package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.*;
import java.util.function.Consumer;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import com.gm.base.model.*;
import com.gm.service.IMemberAddressService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSON;
import com.github.sd4324530.fastweixin.api.response.GetUserInfoResponse;
import com.gm.api.wx.WeiXinApi;
import com.gm.base.consts.Const;
import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.IMemberAccountBillDao;
import com.gm.base.dao.IMemberDao;
import com.gm.base.dao.ITenReturnOneDao;
import com.gm.service.IMemberService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.utils.AESCoder;
import com.gm.utils.QRCodeUtils;

@Transactional
@Service("memberSercive")
public class MemberServiceImpl extends BaseServiceImpl<Member, Integer> implements IMemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Resource
	private IMemberDao dao;

	@Resource
	private IMemberAddressService memberAddressService;

	@Autowired
	private IMemberAccountBillDao accountBillDao;

	@Resource
	private IOrderItemService orderItemService;

	@Resource
	private IOrderService orderService;

	@Resource
	private ITenReturnOneDao tenReturnOneDao;

	@Override
	public IBaseDao<Member, Integer> getDao() {
		return dao;
	}

	@Override
	public Member saveWeixinMember(String openid) {
		Member member = new Member();
		member.setOpenid(openid);
		GetUserInfoResponse userInfo = WeiXinApi.getUserAPI().getUserInfo(openid);
		member.setCountry(userInfo.getCountry());
		member.setProvince(userInfo.getProvince());
		member.setCity(userInfo.getCity());
		member.setGender(userInfo.getSex());
		member.setNickname(userInfo.getNickname());
		member.setIocUrl(userInfo.getHeadimgurl());
		member.setName(userInfo.getNickname());
		Integer memberId = saveReturnId(member);
		member.setId(memberId);
		return member;
	}

	@Override
	public Member saveWeixinMember(GetUserInfoResponse response) {
		Member member = new Member();
		member.setOpenid(response.getOpenid());
		member.setCountry(response.getCountry());
		member.setProvince(response.getProvince());
		member.setCity(response.getCity());
		member.setGender(response.getSex());
		member.setNickname(response.getNickname());
		member.setName(response.getNickname());
		member.setIocUrl(response.getHeadimgurl());
		Integer memberId = saveReturnId(member);
		member.setId(memberId);
		return member;
	}

	@Override
	public Member updateWeixinMember(Member member, GetUserInfoResponse response) {
		member.setCountry(response.getCountry());
		member.setProvince(response.getProvince());
		member.setCity(response.getCity());
		member.setGender(response.getSex());
		member.setNickname(response.getNickname());
		member.setName(response.getNickname());
		member.setIocUrl(response.getHeadimgurl());
		update(member);
		return member;
	}

	@Override
	public Member genCodeAndQrCode(Member member, HttpServletRequest request) {
		logger.info("genCodeAndQrCode:Start");
		String path = request.getServletContext().getRealPath(File.separator) + File.separator;
		logger.info("path={}", path);
		String domain = request.getScheme() + "://" + request.getServerName();
		logger.info("domain={}", domain);

		String generalizeId = AESCoder.encryptResultStr(member.getGeneralizeId(), Const.PASSWORD_SECRET);
		logger.info("generalizeId={}", generalizeId);

		String createQrcode = QRCodeUtils.createQrcode(path + "static" + File.separator + "member" + File.separator
				+ "qrcode" + File.separator + generalizeId + ".png", domain + "/wx/index?generalizeId=" + generalizeId);
		logger.info("createQrcode={}", createQrcode);
		System.out.println("memberServiceImpl genCodeAndCode:generalizeId = " + generalizeId);

		if (StringUtils.isEmpty(member.getQrCode())) {
			member.setQrCode("/static/member/qrcode/" + generalizeId + ".png");
		}
		logger.info("genCodeAndQrCode:End");
		return member;
	}

	@Override
	public Member genCodeAndQrCode(Member member) {
		String base64 = QRCodeUtils.createQrcode("", member.getGeneralizeId());
		if (StringUtils.isEmpty(member.getQrCode())) {
			member.setQrCode(base64);
		}
		return member;
	}

	private String randNum(int len) {
		StringBuffer b = new StringBuffer();
		for (int i = 0; i < len; ++i)
			b.append(String.valueOf((int) Math.floor(Math.random() * 9 + 1)));
		return b.toString();
	}

	private String getGenId(Integer memberId) {
		if (memberId > 100000)
			return String.valueOf(memberId * 117 + 6379) + randNum(2);
		int b1 = 0b1;
		int b3 = 0b100;
		int b5 = 0b10000;
		int b18 = 0b100000000000000000;
		int id = memberId;
		if ((b1 & id) > 0)
			memberId -= b1;
		else
			memberId += b1;
		if ((b3 & id) > 0)
			memberId -= b3;
		else
			memberId += b3;
		if ((b5 & id) > 0)
			memberId -= b5;
		else
			memberId += b5;
		if ((b18 & id) > 0)
			memberId -= b18;
		else
			memberId += b18;
		int f = (int) Math.floor(Math.random() * 9 + 1);
		return String.valueOf(f) + memberId;
	}

	@Override
	public void payMemberSuccess(String openid, PayBill payBill) {
		logger.info("payMemberSuccess:The PayBill id is payBill.id = {} and payBill.reaFee",
				JSON.toJSON(payBill.getId()), JSON.toJSON(payBill.getReaFee()));
		
		Member member = getOne("openid", openid);

		if (member == null) {
			logger.info("payMemberSuccess member == null", "member == null");
			return;
		}

		if (member.getSetMeal() != 1) {
			logger.info("微信多次回调啦");
			return;
		}

		member.setSetMeal(2);
		member.setLevel(3);

//		MemberAccountBill accountBill = new MemberAccountBill();
//		accountBill.setSelfId(member.getId());
//		accountBill.setType(8); // 8|买套餐
//		accountBill.setMoney(Const.MEMBER_AMOUNT);
//		accountBill.setCreateTime(LocalDateTime.now());
//		accountBillDao.save(accountBill);

		if (StringUtils.isEmpty(member.getGeneralizeId())) {
			member.setGeneralizeId(getGenId(member.getId()));
		}
		if (StringUtils.isEmpty(member.getLove()) || member.getLove() == 0) {
			member.setLove(1);
		} else {
			member.setLove(member.getLove() + 1);
		}
//		if (StringUtils.isEmpty(member.getConsume()) || member.getConsume().equals(BigDecimal.ZERO)) {
//			member.setConsume(Const.MEMBER_AMOUNT);
//		} else {
//			member.setConsume(member.getConsume().add(Const.MEMBER_AMOUNT));
//		}
		update(member);
		threeMoney(member);
		logger.info("threeMoney", JSON.toJSON(member));

		returnFiveMoney(member);
		logger.info("returnFiveMoney", JSON.toJSON(member));

		// 返套餐
		returnMeal(member.getOpenid());

		try {
			Integer addressId = payBill.getAddressId();
			MemberAddress memberAddress = memberAddressService.get(addressId);
			Order order = new Order();
			order.setOrderNo(payBill.getOrderNo());
			order.setTotalMoney(payBill.getReaFee());
			order.setMember(member);
			order.setMemberAddress(memberAddress);
			order.setStatus("2");
			order.setPaymentTime(LocalDateTime.now());
			order.setPayPathway(1);
			order.setOrderRemarks("购买竹语套餐");
			orderService.save(order);
		} catch (Exception e) {
			logger.error("gen order error", e);
		}
	}

	private void threeMoney(Member member) {
		// 购买套餐
		if (member.getSetMeal() != 2)
			return;

		Member m = member;
		for (int i = 1; i <= 3; ++i) {
			m = getParent(m);

			if (m == null)
				break;
			if (i != 2) {
				MemberAccountBill accountBill = new MemberAccountBill();
				accountBill.setSelfId(member.getId());
				accountBill.setSelfName(member.getNickname());
				m.setGeneralizeCost(m.getGeneralizeCost().add(BigDecimal.valueOf(50)));
				m.setBalance(m.getBalance().add(BigDecimal.valueOf(50)));
				accountBill.setUpId(m.getId());
				accountBill.setUpName(m.getName());
				accountBill.setType(6); // 6|三级分润
				accountBill.setMoney(BigDecimal.valueOf(50));
				if (i == 1) 
					accountBill.setStatus(1);//直推
				if (i == 3) 
					accountBill.setStatus(2);//直系
				
				accountBillDao.save(accountBill);

			} else {
				MemberAccountBill accountBill = new MemberAccountBill();
				accountBill.setSelfId(member.getId());
				accountBill.setSelfName(member.getNickname());
				m.setGeneralizeCost(m.getGeneralizeCost().add(BigDecimal.valueOf(60)));
				m.setBalance(m.getBalance().add(BigDecimal.valueOf(60)));
				accountBill.setUpId(m.getId());
				accountBill.setUpName(m.getName());
				accountBill.setType(6); // 6|三级分润
				accountBill.setMoney(BigDecimal.valueOf(60));
				accountBill.setStatus(2);//直系
				accountBillDao.save(accountBill);

			}
			logger.info(m.getNickname(), m.getGeneralizeCost());
			dao.update(m);
		}
	}

	/**
	 * 返 5 元/人
	 *
	 */
	public void returnFiveMoney(Member member)
	{
		new Count().iterator(member, (current) -> {
			current.setGeneralizeCost(current.getGeneralizeCost().add(BigDecimal.valueOf(5)));
			current.setBalance(current.getBalance().add(BigDecimal.valueOf(5)));
			logger.info("finishGoods:return {} yuan", BigDecimal.valueOf(5));

			MemberAccountBill accountBill = new MemberAccountBill();
			accountBill.setSelfId(member.getId());
			accountBill.setSelfName(member.getNickname());
			accountBill.setUpId(current.getId());
			accountBill.setUpName(current.getNickname());
			accountBill.setType(3); // 3|5元/人
			accountBill.setMoney(BigDecimal.valueOf(5));
			accountBillDao.save(accountBill);

			if (current.getLevel() < 4)
				current.setLevel(4);
			logger.info(current.getNickname(), current.getGeneralizeCost());
			dao.update(current);
		});
	}

	@Override
	public Member getParent(Member member)
	{
		if (member == null || StringUtils.isEmpty(member.getReferrerGeneralizeId()))
			return null;
		Member parent = getOne("generalizeId", member.getReferrerGeneralizeId());
		if (parent == null || parent.getId().equals(member.getId()))
			return null;
		return parent;
	}

	@Override
	public void tenReturnOne(Integer orderId) {
		// ① 判断会员等级
		Order order = orderService.get(orderId);
		Member member = order.getMember();
		if (member == null) {
			logger.error("member == null");
			return;
		}
		List<OrderItem> listEq = orderItemService.listEq("order.id", orderId);
		try {
			for (OrderItem orderItem : listEq) {
				Commodity commodity = orderItem.getCommodity();
				List<TenReturnOne> list = tenReturnOneDao.listEq("thisTimeCommodity.id", commodity.getId());
				TenReturnOne tenReturnOne = new TenReturnOne();
				if (list.size() == 0) {
					tenReturnOne.setThisTimeCommodity(commodity);
					tenReturnOne.setThisTimeMember(member);
					tenReturnOne.setTime(orderItem.getBuyCount());
					tenReturnOne.setTenTime(1);
					tenReturnOneDao.add(tenReturnOne);
				} else {
					int time = tenReturnOneDao.selectTime(commodity.getId());
					int tentime = tenReturnOneDao.selectTenTime(commodity.getId());
					int num = time + orderItem.getBuyCount();
					tenReturnOne.setThisTimeCommodity(commodity);
					tenReturnOne.setThisTimeMember(member);
					tenReturnOne.setTime(num);
					if (num / Const.returnOne >= tentime) {
						Integer selectOneMember = tenReturnOneDao.selectOneMember(commodity.getId(), tentime);
						Member thisTimeMember = get(selectOneMember);
						if (thisTimeMember.getLevel() == 1 || thisTimeMember.getLevel() == 2) { // 未购买套餐 返原价
							thisTimeMember.setBalance(thisTimeMember.getBalance().add(commodity.getShowPrice()));
							thisTimeMember.setGeneralizeCost(
									thisTimeMember.getGeneralizeCost().add(commodity.getShowPrice()));
							MemberAccountBill accountBill = new MemberAccountBill();
							accountBill.setSelfId(thisTimeMember.getId());
							accountBill.setType(1); // 1|十返一
							accountBill.setMoney(commodity.getShowPrice());
							accountBillDao.save(accountBill);
							dao.update(thisTimeMember);
							tenReturnOne.setTenTime(++tentime);
							tenReturnOneDao.add(tenReturnOne);
						} else {// 返八折
							thisTimeMember.setBalance(
									thisTimeMember.getBalance().add(commodity.getShowPrice().multiply(Const.discount)));
							thisTimeMember.setGeneralizeCost(thisTimeMember.getGeneralizeCost()
									.add(commodity.getShowPrice().multiply(Const.discount)));
							MemberAccountBill accountBill = new MemberAccountBill();
							accountBill.setSelfId(thisTimeMember.getId());
							accountBill.setType(1); // 1|十返一
							accountBill.setMoney(commodity.getShowPrice().multiply(Const.discount));
							accountBillDao.save(accountBill);
							dao.update(thisTimeMember);
							tenReturnOne.setTenTime(++tentime);
							tenReturnOneDao.add(tenReturnOne);
						}

					} else {
						tenReturnOne.setTenTime(tentime);
						tenReturnOneDao.add(tenReturnOne);
					}

				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 返套餐金额 ①判断是否购买套餐 ②判断直推会员是否是十的倍数
	 */
	@Override
	public void returnMeal(String openid) {
		Member myself = dao.getOne("openid", openid);
		if (myself.getSetMeal() != 2) // 购买套餐了
			return;

		Member parent = getParent(myself);
		if (parent == null)
			return;
		List<Member> children = getChildren(parent, 1);
		if (children != null && children.size() >= Const.directMember) {
			if (parent.getSetMeal() != 3) {
				parent.setBalance(parent.getBalance().add(Const.MEMBER_AMOUNT));
				parent.setGeneralizeCost(parent.getGeneralizeCost().add(Const.MEMBER_AMOUNT));
				parent.setSetMeal(3);

				MemberAccountBill accountBill = new MemberAccountBill();
				accountBill.setSelfId(parent.getId());
				accountBill.setType(2); // 2|返套餐
				accountBill.setMoney(Const.MEMBER_AMOUNT);
				accountBillDao.save(accountBill);

				dao.update(parent);
			}
		}
	}

	public List<Member> getIndirectChildren(Member member) {
		List<Member> list = getChildren(member, 2);
		if (list == null)
			return new LinkedList<>();

		Set<Integer> visited = new HashSet<>();
		Queue<Member> queue = new LinkedList<>();
		queue.addAll(list);
		list.clear();
		while (!queue.isEmpty()) {
			Member poll = queue.poll();
			if (visited.contains(poll.getId()))
				continue;
			list.add(poll);
			visited.add(poll.getId());
			List<Member> childs = getChildren(poll, 1);
			if (childs != null)
				queue.addAll(childs);
		}
		return list;
	}

	@Override
	public List<Member> getChildren(Member member, int level) {
		List<Member> members = new LinkedList<>();
		if (member == null || member.getId() == null)
			return members;

		Map<Integer, Member> results = new HashMap<>();
		doGetChildren(results, member, level);
		if (results.containsKey(member.getId()))
			results.remove(member.getId());

		for (Map.Entry<Integer, Member> r : results.entrySet())
			members.add(r.getValue());
		return members;
	}

	private void doGetChildren(Map<Integer, Member> results, Member member, int level) {
		if (level <= 1) {
			List<Member> children = doGetChildren(member);
			if (children != null) {
				for (Member c : children) {
					if (c == null || c.getId() == null)
						continue;
					if (results.containsKey(c.getId()))
						continue;
					results.put(c.getId(), c);
				}
			}
			return;
		}
		List<Member> children = doGetChildren(member);
		if (children == null)
			return;
		for (Member c : children) {
			if (c == null || c.getId() == null)
				continue;
			doGetChildren(results, c, level - 1);
		}
	}

	private List<Member> doGetChildren(Member member) {
		if (StringUtils.isEmpty(member.getGeneralizeId()))
			return null;
		return dao.listEq("referrerGeneralizeId", member.getGeneralizeId());
	}

	@Override
	public Member saveWeixinMember(String openid, String referrerGeneralizeId) {
		Member member = new Member();
		Member membezzrNickName = getOne("generalizeId", referrerGeneralizeId);
		boolean b = membezzrNickName == null;
		logger.info("Member memberNickName = {}", b);

		member.setOpenid(openid);
		GetUserInfoResponse userInfo = WeiXinApi.getUserAPI().getUserInfo(openid);
		member.setCountry(userInfo.getCountry());
		member.setProvince(userInfo.getProvince());
		member.setCity(userInfo.getCity());
		member.setGender(userInfo.getSex());
		member.setNickname(userInfo.getNickname());
		member.setName(userInfo.getNickname());
		member.setIocUrl(userInfo.getHeadimgurl());

		if (!b && membezzrNickName.getNickname() != null) {
			member.setReferrerNickname(membezzrNickName.getNickname());
		}

		Integer memberId = saveReturnId(member);
		member.setReferrerGeneralizeId(referrerGeneralizeId);
		member.setId(memberId);
		return member;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.gm.service.IMemberService#updateGeneralizeCost(java.lang.String,
	 * java.math.BigDecimal)
	 */
	@Override
	public void updateGeneralizeCost(String referrerGeneralizeId, BigDecimal multiply) {
		Member one = dao.getOne("generalizeId", referrerGeneralizeId);
		if (one != null) {
			one.setGeneralizeCost(one.getGeneralizeCost().add(multiply));
			one.setBalance(one.getBalance().add(multiply));
			dao.update(one);
		} else {
			logger.info("MemberServiceImpl NULL pointer");
		}

		logger.info("MemberServiceImpl -> updateGeneralizeCost:" + referrerGeneralizeId + "," + multiply);

	}

	public class Count {
		private Set<Integer> visited = new HashSet<>();
		private Map<Integer, Integer> childrenCount = new HashMap<>();
		private Map<Integer, Integer> direct = new HashMap<>();
		private Set<Integer> detached = new HashSet<>();
		public final int directCond = Const.directMember;
		public final int childrenCond = Const.betweenMember;

		public Set<Integer> getDetached()
		{
			return detached;
		}

		public void iterator(Member member, Consumer<Member> yourCodeHere)
		{
			if (member == null)
				return;
			List<Integer> chains = new ArrayList<>();
			Member root = getRoot(member, chains);
			if (root == null)
				return;
			visit(root);
			for (Integer id : chains) {
				if (childrenCount.getOrDefault(id, 0) >= childrenCond && direct.getOrDefault(id, 0) >= directCond) {
					Member current = get(id);
					if (current == null) {
						logger.error("iterator current == null");
						return;
					}
					yourCodeHere.accept(current);
					return;
				}
			}
		}

		public int visit(Member root)
		{
			if (visited.contains(root.getId()))
				return 0;
			visited.add(root.getId());

			List<Member> children = getChildren(root, 1);
			if (children.isEmpty()) {
				childrenCount.put(root.getId(), 0);
				return 0;
			}
			int sum = 0;
			int directCount = 0;
			for (Member child : children) {
				int count = visit(child);
				if (detached.contains(child.getId()))
					sum += 1;
				else {
					sum += (count + 1);
					++directCount;
				}
			}
			if (directCount >= directCond && sum >= childrenCond)
				detached.add(root.getId());
			direct.put(root.getId(), directCount);
			childrenCount.put(root.getId(), sum);
			return sum;
		}

		private Member getRoot(Member member, List<Integer> chains)
		{
			Set<Integer> visited = new HashSet<>();
			Member root = getParent(member);
			if (root != null)
				chains.add(root.getId());
			for (Member current = getParent(root); current != null
					&& !visited.contains(current.getId()); current = getParent(current)) {
				visited.add(current.getId());
				root = current;
				chains.add(root.getId());
			}
			return root;
		}
	}
}