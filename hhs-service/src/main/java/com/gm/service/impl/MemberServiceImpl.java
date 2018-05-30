package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

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
		
		threeMoney(member);

		logger.info("payMemberSuccess:The Member member={}", JSON.toJSON(member));
		
		

		update(member);
	}
	private void threeMoney(Member member) {
		if (member.getSetMeal() == 2) { //购买套餐
			Member member2 = memberService.getOne("generalizeId", member.getReferrerGeneralizeId()); //上家
			if (null!=member2) {
				member2.setGeneralizeCost(member2.getGeneralizeCost().add(BigDecimal.valueOf(50)));
			}
			Member member3 = memberService.getOne("generalizeId", member2.getReferrerGeneralizeId()); //上上家
			if (null!=member3) {
				member3.setGeneralizeCost(member3.getGeneralizeCost().add(BigDecimal.valueOf(60)));
			}
			Member member4 = memberService.getOne("generalizeId", member3.getReferrerGeneralizeId()); //上上上家
			if (null!=member4) {
				member4.setGeneralizeCost(member4.getGeneralizeCost().add(BigDecimal.valueOf(50)));
			}
		}
	}

	@Override
	public Member getParent(Member member, int level)
	{
		if (level == 1)
			return doGetParent(member);
		Member parent = doGetParent(member);
		if (parent == null)
			return null;
		return getParent(parent, --level);
	}

	private Member doGetParent(Member member)
	{
		Member parent = getOne("generalizeId", member.getReferrerGeneralizeId());
		return parent;
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
			
			;

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
			Member parent1 = getParent(member, 1);
			if (parent1 != null)
				list.add(parent1);
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
		Member parent1 = getParent(member, 1);
		Member parent2 = getParent(member, 2);
		Member parent3 = getParent(member, 3);

		if (parent1 != null) {
			parent1.setBalance(parent1.getBalance().add(BigDecimal.valueOf(50)));
			logger.info("threeLevel:Member member1 = {}",JSON.toJSON(parent1.getId()));
			logger.info("threeLevel:Member member1 = {}",JSON.toJSON(parent1.getNickname()));
			update(parent1);
		}

		if (parent2 != null) {
			parent2.setBalance(parent2.getBalance().add(BigDecimal.valueOf(60)));
			logger.info("threeLevel:Member member1 = {}",JSON.toJSON(parent2.getId()));
			logger.info("threeLevel:Member member1 = {}",JSON.toJSON(parent2.getNickname()));
			update(parent2);

		}

		if (parent3 != null) {
			parent3.setBalance(parent3.getBalance().add(BigDecimal.valueOf(50)));
			logger.info("threeLevel:Member member1 = {}",JSON.toJSON(parent3.getId()));
			logger.info("threeLevel:Member member1 = {}",JSON.toJSON(parent3.getNickname()));
			update(parent3);

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