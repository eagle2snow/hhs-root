package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import javax.validation.constraints.NotNull;

import org.apache.http.Consts;
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
import com.gm.base.dao.IMemberDao;
import com.gm.base.dao.ITenReturnOneDao;
import com.gm.base.dto.SuperTree;
import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.base.model.Order;
import com.gm.base.model.OrderItem;
import com.gm.base.model.TenReturnOne;
import com.gm.service.IMemberService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.utils.AESCoder;
import com.gm.utils.QRCodeUtils;
import com.gm.utils.StringUtil;
import com.xiaoleilu.hutool.util.RandomUtil;

@Transactional
@Service("memberSercive")
public class MemberServiceImpl extends BaseServiceImpl<Member, Integer> implements IMemberService {

	private static final Logger logger = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Resource
	private IMemberDao dao;

	@Resource
	private IOrderItemService orderItemService;

	@Resource
	private IOrderService orderService;

	@Resource
	private ITenReturnOneDao tenReturnOneDao;

	@Autowired
	private SuperTree superTree;

	@Resource
	private IMemberService memberService;

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

	@Override
	public void payMemberSuccess(String openid) {
		Member member = getOne("openid", openid);

		if (member == null) {
			logger.info("payMemberSuccess", "member == null");
			return;
		}

		if (member.getSetMeal() != 1) {
			logger.info("微信多次回调啦");
			return;
		}

		member.setSetMeal(2);
		member.setLevel(3);
		update(member);
		if (StringUtils.isEmpty(member.getGeneralizeId())) {
			String randomNumbers = RandomUtil.randomNumbers(6);
			if (randomNumbers.charAt(0) != '0') {
				member.setGeneralizeId(RandomUtil.randomNumbers(6));
			} else {
				member.setGeneralizeId("1" + RandomUtil.randomNumbers(5));
			}
		}
		if (StringUtils.isEmpty(member.getLove()) || member.getLove() == 0) {
			member.setLove(1);
		} else {
			member.setLove(member.getLove() + 1);
		}
		if (StringUtils.isEmpty(member.getConsume()) || member.getConsume().equals(BigDecimal.ZERO)) {
			member.setConsume(Const.MEMBER_AMOUNT);
		} else {
			member.setConsume(member.getConsume().add(Const.MEMBER_AMOUNT));
		}

		threeMoney(member);
		logger.info("threeMoney", JSON.toJSON(member));

		returnFiveMoney(member);
		logger.info("returnFiveMoney", JSON.toJSON(member));

		// 返套餐
		returnMeal(member.getOpenid());
	}

	private void threeMoney(Member member) {
		// 购买套餐
		if (member.getSetMeal() != 2)
			return;

		Member m = member;
		for (int i = 1; i <= 3; ++i) {
			m = memberService.getParent(m, 1);
			if (m == null)
				break;
			if (i != 2) {
				m.setGeneralizeCost(m.getGeneralizeCost().add(BigDecimal.valueOf(50)));
				m.setBalance(m.getBalance().add(BigDecimal.valueOf(50)));
			} else {
				m.setGeneralizeCost(m.getGeneralizeCost().add(BigDecimal.valueOf(60)));
				m.setBalance(m.getBalance().add(BigDecimal.valueOf(60)));
			}
			logger.info(m.getNickname(), m.getGeneralizeCost());
			dao.update(m);
		}
	}

	/**
	 * 返 5 元/人
	 *
	 */
	public void returnFiveMoney(Member member) {
		Map<Integer, Integer> memento = new HashMap<>();
		Set<Integer> visited = new HashSet<>();
		Set<Integer> added = new HashSet<>();
		Set<Integer> visitedParents = new HashSet<>();
		boolean gt = false;
		for (Member current = getParent(member, 1); current != null
				&& !visitedParents.contains(current.getId()); current = getParent(current, 1)) {
			visitedParents.add(current.getId());
			if (!gt) {
				int childrenCount = memberService.getChildrenCount(current, memento, visited, added);
				if (childrenCount < Const.betweenMember)
					continue;
				gt = true;
			}
			if (current.getSetMeal() != 3)
				continue;

			current.setGeneralizeCost(current.getGeneralizeCost().add(BigDecimal.valueOf(5)));
			current.setBalance(current.getBalance().add(BigDecimal.valueOf(5)));
			if (current.getLevel() < 4)
				current.setLevel(4);
			logger.info(current.getNickname(), current.getGeneralizeCost());
			dao.update(current);
		}
	}

	@Override
	public Member getParent(Member member, int level) {
		if (member == null)
			return null;
		if (level <= 1)
			return doGetParent(member);
		Member parent = doGetParent(member);
		if (parent == null)
			return null;
		return getParent(parent, --level);
	}

	private Member doGetParent(Member member) {
		if (StringUtils.isEmpty(member.getReferrerGeneralizeId()))
			return null;
		Member parent = getOne("generalizeId", member.getReferrerGeneralizeId());
		if (parent != null && parent.getId() == member.getId())
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
				TenReturnOne tenReturnOne = tenReturnOneDao.getOne("thisTimeCommodity.id", commodity.getId());
				logger.info("TenReturnOne tenReturnOne = {}", JSON.toJSON(tenReturnOne));
				if (tenReturnOne == null) {
					tenReturnOne = new TenReturnOne();
					tenReturnOne.setThisTimeCommodity(commodity);
					tenReturnOne.setThisTimeMember(member);
					tenReturnOne.setTime(1);
					tenReturnOneDao.add(tenReturnOne);
				} else {
					tenReturnOne.setThisTimeCommodity(commodity);
					tenReturnOne.setThisTimeMember(member);
					tenReturnOne.setTime(tenReturnOne.getTime() + 1);
					tenReturnOneDao.add(tenReturnOne);

				}

				Integer time = tenReturnOne.getTime();
				if (time % Const.returnOne == 0 && time >= Const.returnOne) { // 次数是十的倍数
					// 通过次数获取会员
					TenReturnOne one = tenReturnOneDao.getOne("time", time);
					Member thisTimeMember = one.getThisTimeMember();
					// 设置会员的十返一字段 空：设置， 非空：取出来再加
					if (thisTimeMember.getTenReturnOne() == null) {
						thisTimeMember.setTenReturnOne(one.getThisTimeCommodity().getShowPrice());
					} else {
						thisTimeMember.setTenReturnOne(
								thisTimeMember.getTenReturnOne().add(one.getThisTimeCommodity().getShowPrice()));
					}
					dao.update(member);
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

		Member parent = getParent(myself, 1);
		if (parent == null)
			return;
		List<Member> children = getChildren(parent, 1);
		if (children != null && children.size() >= Const.directMember) {
			if (parent.getSetMeal() != 3) {
				parent.setBalance(parent.getBalance().add(Const.MEMBER_AMOUNT));
				parent.setSetMeal(3);
				dao.update(parent);
			}
		}
	}

	@Override
	public int getChildrenCount(Member member, Map<Integer, Integer> memento, Set<Integer> visited,
			Set<Integer> added) {
		if (member == null || member.getId() == null)
			return 0;
		if (memento.containsKey(member.getId()))
			return memento.get(member.getId());
		if (added.contains(member.getId()))
			return 0;
		added.add(member.getId());
		List<Member> members = doGetChildren(member);
		if (members == null)
			return 0;
		int sum = members.size();
		for (Member m : members) {
			if (!visited.contains(m.getId())) {
				visited.add(m.getId());
				sum += getChildrenCount(m, memento, visited, added);
			}
		}
		memento.put(member.getId(), sum);
		return sum;
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
		logger.info("Member memberNickName = {}", JSON.toJSON(membezzrNickName));

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

	/* (non-Javadoc)
	 * @see com.gm.service.IMemberService#updateGeneralizeCost(java.lang.String, java.math.BigDecimal)
	 */
	@Override
	public void updateGeneralizeCost(String referrerGeneralizeId, BigDecimal multiply) {
		Member one = dao.getOne("generalizeId", referrerGeneralizeId);
		if (one != null) {
			one.setGeneralizeCost(one.getGeneralizeCost().add(multiply));
			one.setBalance(one.getBalance().add(multiply));
			dao.update(one);
		} else {
			System.out.println("MemberServiceImpl NULL pointer");
		}

		System.out.println("MemberServiceImpl -> updateGeneralizeCost:" + referrerGeneralizeId + "," + multiply);

	}

}