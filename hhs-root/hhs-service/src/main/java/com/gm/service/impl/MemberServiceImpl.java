package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.gm.base.dao.IMemberDao;
import com.gm.base.dao.ITenReturnOneDao;
import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.base.model.Order;
import com.gm.base.model.TenReturnOne;
import com.gm.service.IMemberService;
import com.github.sd4324530.fastweixin.api.response.GetUserInfoResponse;
import com.gm.base.consts.Const;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;
import com.gm.utils.AESCoder;
import com.gm.utils.QRCodeUtils;

@Transactional
@Service("memberSercive")
public class MemberServiceImpl extends BaseServiceImpl<Member, Integer> implements IMemberService {

	@Resource
	private IMemberDao dao;

	private ITenReturnOneDao tenReturnOneDao;

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
		String path = request.getServletContext().getRealPath(File.separator) + File.separator;
		String domain = request.getScheme() + "://" + request.getServerName();
		String generalizeId = AESCoder.encryptResultStr(member.getGeneralizeId(), Const.PASSWORD_SECRET);
		QRCodeUtils.createQrcode(path + "static" + File.separator + "member" + File.separator + "qrcode"
				+ File.separator + generalizeId + ".png", domain + "/wx/index?generalizeId=" + generalizeId);
		member.setQrCode("/static/member/qrcode/" + generalizeId + ".png");
		return member;
	}

	@Override
	public Member genCodeAndQrCode(Member member) {
		String base64 = QRCodeUtils.createQrcode("", member.getGeneralizeId());
		member.setQrCode(base64);
		return member;
	}

	@Override
	public void payMemberSuccess(String openid) {
		Member member =getOne("openid", openid);
		Member parent1 = getParent1(member);// 上一级
		Member parent2 = getParent2(member);// 上二级
		Member parent3 = getParent3(member);// 上三级

		// 三级分润
		if (parent1 != null) {
			parent1.setBalance(parent1.getBalance().add(BigDecimal.valueOf(50)));
		}
		if (parent2 != null) {
			parent2.setBalance(parent2.getBalance().add(BigDecimal.valueOf(60)));
		}
		if (parent3 != null) {
			parent3.setBalance(parent3.getBalance().add(BigDecimal.valueOf(50)));
		}

	}

	@Override
	public Member getParent1(Member member) {
		Member parent1 = getOne("generalizeId", member.getReferrerGeneralizeId());
		return parent1;
	}

	@Override
	public Member getParent2(Member member) {
		Member parent1 = getParent1(member);
		if (parent1 != null) {
			Member parent2 = getOne("generalizeId", parent1.getReferrerGeneralizeId());
			return parent2;
		}
		return null;
	}

	@Override
	public Member getParent3(Member member) {

		Member parent2 = getParent2(member);
		if (parent2 != null) {
			Member parent3 = getOne("generalizeId", parent2.getReferrerGeneralizeId());
			return parent3;
		}
		return null;
	}

	@Override
	public Commodity tenReturnOne(Integer memberId) {
		TenReturnOne returnOne = tenReturnOneDao.getOne("member.id", memberId);
		if (!StringUtils.isEmpty(returnOne)) {
			Integer time = returnOne.getTime();
			if (time % 10 == 0) { //10 -> 1 | 20 -> 2 | 30 -> 3 | ...
				
			}
		}
		return null;
	}

	@Override
	public BigDecimal returnFiveMoney(Integer mealMemberNumber) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public BigDecimal returnMeal(Integer mealMemberNumber) {
		// TODO Auto-generated method stub
		return null;
	}

}