package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
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
		member.setGender(0);
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
		member.setGeneralizeId(StringUtil.get8UUID());
		member.setLove(member.getLove() + 1);
		member.setConsume(member.getConsume().add(Const.MEMBER_AMOUNT));
		genCodeAndQrCode(member);

		logger.info("payMemberSuccess:The Member member={}", JSON.toJSON(member));

		update(member);
	}

	@Override
	public Member getParent1(Member member) {// 获取张三的推荐人 50 三级代理 上家
		Member parent1 = getOne("generalizeId", member.getReferrerGeneralizeId());
		return parent1;
	}

	@Override
	public Member getParent2(Member member) {// 获取张三的推介人的推介人 60 二级代理 上上家
		Member parent1 = getParent1(member);
		if (parent1 != null) {
			Member parent2 = getOne("generalizeId", parent1.getReferrerGeneralizeId());
			return parent2;
		}
		return null;
	}

	@Override
	public Member getParent3(Member member) {// 获取张三推荐人的推荐人的推荐人 50 一级代理 上上上家

		Member parent2 = getParent2(member);
		if (parent2 != null) {
			Member parent3 = getOne("generalizeId", parent2.getReferrerGeneralizeId());
			return parent3;
		}
		return null;
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
			Member parent2 = getParent2(member);
			Member parent3 = getParent3(member);

			if (!StringUtils.isEmpty(parent2) || !StringUtils.isEmpty(parent3)) {
				list = new ArrayList<>();
				list.add(parent2);
				list.add(parent3);
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
			Member parent1 = getParent1(member);
			if (!StringUtils.isEmpty(parent1)) {
				list = new ArrayList<>();
				list.add(parent1);
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
		Member parent1 = getParent1(member);// 上一级
		Member parent2 = getParent2(member);// 上二级
		Member parent3 = getParent3(member);// 上三级

		// 三级分润
		if (parent1 != null) {
			parent1.setBalance(parent1.getBalance().add(BigDecimal.valueOf(50)));
			update(parent1);
		}
		if (parent2 != null) {
			parent2.setBalance(parent2.getBalance().add(BigDecimal.valueOf(60)));
			update(parent2);
		}
		if (parent3 != null) {
			parent3.setBalance(parent3.getBalance().add(BigDecimal.valueOf(50)));
			update(parent3);
		}
	}

	public static void main(String[] args) {
	}

	// 获取直系会员
	@Override
	public List<Member> getAllSons(Member member) {
		List<Member> members = new ArrayList<>();
		if (null == member.getGeneralizeId())
			return members;
		List<Member> first = dao.listEq("referrerGeneralizeId", member.getGeneralizeId());
		for (Member member1 : first) {
			if (member1.getGeneralizeId() == null)
				continue;
			List<Member> second = dao.listEq("referrerGeneralizeId", member1.getGeneralizeId());
			for (Member m : second)
				members.add(m);
		}
		return members;
	}

	// 获取直推会员
	@Override
	public List<Member> getSons1(Member member) {
		List<Member> members = listEq("referrerGeneralizeId", member.getGeneralizeId());
		return members;
	}

}