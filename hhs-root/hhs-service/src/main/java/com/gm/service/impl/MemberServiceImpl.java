package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Predicate;
import java.util.stream.Collectors;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.sse.Sse;

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
import com.gm.base.dto.Node;
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
		member.setSetMeal(2);
		member.setLevel(3);
		if (StringUtils.isEmpty(member.getGeneralizeId())) {
			member.setGeneralizeId(RandomUtil.randomNumbers(6));
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

		logger.info("payMemberSuccess:The Member member={}", JSON.toJSON(member));

		update(member);
	}

	@Override
	public List<Member> getParent1(Member member) {// 获取张三的推荐人 50 三级代理 上家
		List<Member> list = new ArrayList<>();
		Member parent1 = getOne("generalizeId", member.getReferrerGeneralizeId());
		if (!StringUtils.isEmpty(parent1)) {
			list.add(parent1);
		}
		return list;
	}

	@Override
	public List<Member> getParent2(Member member) {// 获取张三的推介人的推介人 60 二级代理 上上家

		List<Member> parent1 = getParent1(member);
		List<Member> list = new ArrayList<>();
		for (Member parent : parent1) {
			if (!StringUtils.isEmpty(parent)) {
				Member parent2 = getOne("generalizeId", parent.getReferrerGeneralizeId());
				list.add(parent2);
			}
		}
		return list;
	}

	@Override
	public List<Member> getParent3(Member member) {// 获取张三推荐人的推荐人的推荐人 50 一级代理 上上上家

		List<Member> parent2 = getParent2(member);
		List<Member> list = new ArrayList<>();
		for (Member member2 : parent2) {
			if (StringUtils.isEmpty(member2)) {
				Member parent3 = getOne("generalizeId", member2.getReferrerGeneralizeId());
				list.add(parent3);
			}
		}
		return list;
	}

	@Override
	public void tenReturnOne(Integer orderId) {
		// ① 判断会员等级
		Order order = orderService.get(orderId);
		Member member = order.getMember();
		List<OrderItem> listEq = orderItemService.listEq("order.id", orderId);

		if (!StringUtils.isEmpty(member) && member.getLevel() != 1) { // 判断等级 除了 游客外
			try {
				for (OrderItem orderItem : listEq) {
					Commodity commodity = orderItem.getCommodity();
					TenReturnOne tenReturnOne = tenReturnOneDao.getOne("thisTimeCommodity.id", commodity.getId());
					if (StringUtils.isEmpty(tenReturnOne)) {
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

						Integer time = tenReturnOne.getTime();
						if (time % 10 == 0 && time >= 10) { // 次数是十的倍数
							// 通过次数获取会员
							TenReturnOne one = tenReturnOneDao.getOne("time", time);
							Member thisTimeMember = one.getThisTimeMember();
							// 设置会员的十返一字段 空：设置， 非空：取出来再加
							if (StringUtils.isEmpty(thisTimeMember.getTenReturnOne())) {
								thisTimeMember.setTenReturnOne(one.getThisTimeCommodity().getShowPrice());
							} else {
								thisTimeMember.setTenReturnOne(thisTimeMember.getTenReturnOne()
										.add(one.getThisTimeCommodity().getShowPrice()));
							}
						}
						dao.update(member);
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
	}

	/**
	 * 返 5 元/人
	 * 
	 */
	@Override
	public void returnFiveMoney(String openid) {

		Member member = dao.getOne("openid", openid);
		List<Member> list = null;

		if (member.getSetMeal() == 3) { // 直推十人
			
			List<Member> parent2 = getParent2(member);
			List<Member> parent3 = getParent3(member);
			
			for (Member member2 : parent2) {
				if (!StringUtils.isEmpty(member2) ) {
					list = new ArrayList<>();
					list.add(member2);
				}
			}
			
			for (Member member3 : parent3) {
				if (!StringUtils.isEmpty(member3) ) {
					list = new ArrayList<>();
					list.add(member3);
				}
			}

		}

		if (!StringUtils.isEmpty(list)) {
			if (list.size() > Const.betweenMember) {
				member.setGeneralizeCost(member.getGeneralizeCost().add(BigDecimal.valueOf(5.0)));
				member.setLevel(4); // 城市经理
			} else {
				member.setGeneralizeCost(BigDecimal.valueOf(5.0));
				member.setLevel(4); // 城市经理
			}

			dao.update(member);
		}

	}

	/**
	 * 返套餐金额 ①判断是否购买套餐 ②判断直推会员是否是十的倍数
	 */
	@Override
	public BigDecimal returnMeal(String openid) {
		Member member = dao.getOne("openid", openid);
		BigDecimal balance = member.getBalance();
		List<Member> list = null;

		if (member.getSetMeal() == 2) { // 购买套餐了
			List<Member> parent1 = getParent1(member);
			for (Member member2 : parent1) {
				if (!StringUtils.isEmpty(parent1)) {
					list = new ArrayList<>();
					list.add(member2);
				}
			}
		}
		if (!StringUtils.isEmpty(list)) {
			if (list.size() >= Const.directMember) {
				member.setSetMeal(3);// 返套餐钱
			}
		}
		if (member.getSetMeal() == 3) {
			balance.add(Const.MEMBER_AMOUNT);
		}
		dao.update(member);
		return balance;

	}

	@Override
	public void threeLevel(Integer memberId) {

		Member member = dao.getOne("id", memberId);
		List<Member> parent1 = getParent1(member);// 上一级
		List<Member> parent2 = getParent2(member);// 上二级
		List<Member> parent3 = getParent3(member);// 上三级
		
		for (Member member1 : parent1) {
			if (StringUtils.isEmpty(member1)) {
				member1.setBalance(member1.getBalance().add(BigDecimal.valueOf(50)));
				update(member1);
				
			}
		}
		
		for (Member member2 : parent2) {
			if (StringUtils.isEmpty(member2)) {
				member2.setBalance(member2.getBalance().add(BigDecimal.valueOf(50)));
				update(member2);
				
			}
		}
		
		for (Member member3 : parent3) {
			if (StringUtils.isEmpty(member3)) {
				member3.setBalance(member3.getBalance().add(BigDecimal.valueOf(50)));
				update(member3);
				
			}
		}
		
	}

	// 获取直系会员
	@Override
	public List<Member> getAllSons(Member member) {
		Map<Integer, Member> members = new HashMap<>();
		members.put(member.getId(), member);
		if (StringUtil.strNullOrEmpty(member.getGeneralizeId()) || member.getId() == null)
			return new ArrayList<>();

		List<Member> direct = dao.listEq("referrerGeneralizeId", member.getGeneralizeId());
		for (Member d : direct) {
			if (StringUtil.strNullOrEmpty(d.getGeneralizeId()))
				continue;
			List<Member> inDirect = dao.listEq("referrerGeneralizeId", d.getGeneralizeId());
			for (Member d2 : inDirect) {
				if (members.containsKey(d2.getId()))
					continue;
				members.put(d2.getId(), d2);
			}
		}
		List<Member> all = new ArrayList<>();
		members.remove(member.getId());
		for (Map.Entry<Integer, Member> entry : members.entrySet())
			all.add(entry.getValue());
		return all;
	}

	// 获取直推会员
	@Override
	public List<Member> getSons1(Member member) {
		if (StringUtil.strNullOrEmpty(member.getGeneralizeId()))
			return new ArrayList<>();
		return listEq("referrerGeneralizeId", member.getGeneralizeId());
	}

	@Override
	public Member saveWeixinMember(String openid, String referrerGeneralizeId) {
		Member member = new Member();
		Member memberNickName = getOne("generalizeId", referrerGeneralizeId);

		member.setOpenid(openid);
		GetUserInfoResponse userInfo = WeiXinApi.getUserAPI().getUserInfo(openid);
		member.setCountry(userInfo.getCountry());
		member.setProvince(userInfo.getProvince());
		member.setCity(userInfo.getCity());
		member.setGender(userInfo.getSex());
		member.setNickname(userInfo.getNickname());
		member.setName(userInfo.getNickname());
		member.setIocUrl(userInfo.getHeadimgurl());
		member.setReferrerNickname(memberNickName.getNickname());
		Integer memberId = saveReturnId(member);
		member.setReferrerGeneralizeId(referrerGeneralizeId);
		member.setId(memberId);
		return member;
	}

	public static void main(String[] args) {
	}

}