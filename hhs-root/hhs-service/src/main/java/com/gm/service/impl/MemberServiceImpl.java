package com.gm.service.impl;

import java.io.File;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
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
				TenReturnOne tenReturnOne = null;
				// TenReturnOne tenReturnOne = tenReturnOneDao.getOne("thisTimeCommodity",
				// member);
				if (StringUtils.isEmpty(tenReturnOne)) {
					for (OrderItem item : listEq) {
						tenReturnOne = new TenReturnOne();
						Commodity commodity = item.getCommodity();
						tenReturnOne.setThisTimeCommodity(commodity);
						tenReturnOne.setThisTimeMember(member);

						List<TenReturnOne> listEq2 = tenReturnOneDao.listEq("thisTimeCommodity.id", commodity.getId());
						List<Integer> list = null;
						if (!StringUtils.isEmpty(listEq2)) {
							for (TenReturnOne tenReturnOne2 : listEq2) {
								list = new ArrayList<>();
								list.add(tenReturnOne2.getTime());
							}
						}
						if (StringUtils.isEmpty(list) || list.size() == 0) {

							tenReturnOne.setTime(1);
						} else {
							tenReturnOne.setTime(list.size() + 1);
						}

						tenReturnOneDao.add(tenReturnOne);
					}
				}
				Integer time = tenReturnOne.getTime();
				if (time % 10 == 0 && time >= 10) { // 次数是十的倍数
					// 通过次数获取会员
					TenReturnOne one = tenReturnOneDao.getOne("time", time);
					Member thisTimeMember = one.getThisTimeMember();
					// 设置会员的十返一字段 空：设置， 非空：取出来再加
					if (StringUtils.isEmpty(thisTimeMember.getTenReturnOne())) {
						thisTimeMember.setTenReturnOne(one.getThisTimeCommodity().getShowPrice());
					} else {
						thisTimeMember.setTenReturnOne(
								thisTimeMember.getTenReturnOne().add(one.getThisTimeCommodity().getShowPrice()));
					}
				}
				dao.update(member);
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

		List<Node> nodeList = new ArrayList<Node>();

		Node node1 = new Node("100001", "0");
		Node node2 = new Node("100002", "100001");
		Node node3 = new Node("100003", "100001");
		Node node4 = new Node("100004", "100001");
		Node node5 = new Node("100005", "100002");
		Node node6 = new Node("100006", "100002");
		Node node7 = new Node("100007", "100002");
		Node node8 = new Node("100008", "100002");
		Node node9 = new Node("100009", "100003");
		Node node10 = new Node("100010", "100003");
		Node node11 = new Node("100011", "100003");
		Node node12 = new Node("100012", "100004");
		Node node13 = new Node("100013", "100005");
		Node node14 = new Node("100014", "100005");
		Node node15 = new Node("100015", "100005");
		Node node16 = new Node("100016", "100014");
		Node node17 = new Node("100017", "100014");
		Node node18 = new Node("100018", "100017");

		nodeList.add(node1);
		nodeList.add(node2);
		nodeList.add(node3);
		nodeList.add(node4);
		nodeList.add(node5);
		nodeList.add(node6);
		nodeList.add(node7);
		nodeList.add(node8);
		nodeList.add(node9);
		nodeList.add(node10);
		nodeList.add(node11);
		nodeList.add(node12);
		nodeList.add(node13);
		nodeList.add(node14);
		nodeList.add(node15);
		nodeList.add(node16);
		nodeList.add(node17);
		nodeList.add(node18);

		List<Member> members = list();

		List<Node> nodes = new ArrayList<>();
		for (Member member2 : members) {
			Node node = new Node(member2.getGeneralizeId(), member2.getReferrerGeneralizeId());
			nodes.add(node);
		}

		// members.stream().map(m -> new Node(m)).collect(Collectors.toList());

		for (Node node : nodes) {
			System.out.println(node.getId() + "@" + node.getParentId());
		}

		SuperTree superTree = new SuperTree();

		List<String> ids = superTree.getChildNodes(nodes, "100001");

		System.out.println(ids.size() + "!!");

		if (ids.size() > 0) {
			return listIn("generalizeId", ids.toArray(new String[ids.size()]));
		}
		return null;
	}

	// 获取直推会员
	@Override
	public List<Member> getSons1(Member member) {
		List<Member> members = listEq("referrerGeneralizeId", member.getGeneralizeId());
		return members;
	}

}