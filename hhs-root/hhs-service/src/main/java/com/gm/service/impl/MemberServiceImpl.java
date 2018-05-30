package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.*;

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
	public void payMemberSuccess(String openid)
	{
		//TODO　增加拦截 防止微信多次回调
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
		logger.info("threeMoney", JSON.toJSON(member));

		returnFiveMoney(member);
		logger.info("returnFiveMoney", JSON.toJSON(member));

		update(member);
	}

	private void threeMoney(Member member)
	{
		if (member.getSetMeal() == 2) { //购买套餐
			Member m = member;
			for (int i = 1; i <= 4; ++i) {
				m = memberService.getParent(m, 1);
				if (m == null)
					break;
				if (i != 3)
					m.setGeneralizeCost(m.getGeneralizeCost().add(BigDecimal.valueOf(50)));
				else
					m.setGeneralizeCost(m.getGeneralizeCost().add(BigDecimal.valueOf(60)));
			}
		}
	}

	/**
	 * 返 5 元/人
	 *
	 */
	public void returnFiveMoney(Member member)
	{
		List<Member> list = null;

//		if (member.getSetMeal() == 3) { // 直推且购买过套餐大于等于十人
//			Member current = getParent(member, 1);
//			if (current == null)
//				return;
//			for (; current != null; current = getParent(current, 1)) {
//				int sum = 0;
//				for ( ; sum <= Const.betweenMember; ) {
//					List<Member> children = getChildren(current, 1);
//					sum += children.size();
//					for (Member c : children) {
//
//					}
//				}
//				member.setGeneralizeCost(member.getGeneralizeCost().add(BigDecimal.valueOf(5.0)));
//				if (member.getLevel() < 4)
//					member.setLevel(4);
//				dao.update(member);
//			}
//		}
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
		if (list != null && list.size() >= Const.directMember)
			member.setSetMeal(3);// 返套餐钱
		if (member.getSetMeal() == 3)
			balance.add(Const.MEMBER_AMOUNT);
		dao.update(member);
		return balance;
	}

	@Override
	public List<Member> getChildren(Member member, int level)
	{
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

	private void doGetChildren(Map<Integer, Member> results, Member member, int level)
	{
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

	private List<Member> doGetChildren(Member member)
	{
		if (StringUtils.isEmpty(member.getGeneralizeId()))
			return null;
		return dao.listEq("referrerGeneralizeId", member.getGeneralizeId());
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