package com.gm.wx.controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.gm.base.model.Member;
import com.gm.base.model.MemberAccountBill;
import com.gm.service.IMemberAccountBillService;
import com.gm.service.IMemberService;
import com.gm.utils.DateUtil;

@Controller
@RequestMapping("wx/myCenter/")
public class WxMyCenterMemberBillController extends WeixinBaseController {

	private static final Logger logger = LoggerFactory.getLogger(WxMyCenterMemberBillController.class);
	private static final String PATH = "wx/myCenter/";

	@Resource
	private IMemberService memberService;

	@Resource
	private IMemberAccountBillService billService;

	/**
	 * 推广费详情
	 * 
	 * @param memberId
	 * @return
	 */
	@RequestMapping("memberBill/{memberId}")
	public String memberBill(@PathVariable Integer memberId, ModelMap modelAndView) {
		logger.info("memberBill:the args memberId = {}", memberId);
		if (memberId == null) {
			return null;
		}

		 Member member = memberService.getOne("id", memberId);

		List<MemberAccountBill> billsList = billService.listEq("upId", memberId);
		logger.info("List<MemberAccountBill> accountBillss upId = {}", JSON.toJSON(billsList.size()));

		List<MemberAccountBill> selfIdBill = billService.listEq("selfId", memberId);
		logger.info("List<MemberAccountBill> accountBillss selfIdBill = {}", JSON.toJSON(selfIdBill.size()));

		if (selfIdBill.size() > 0) {
			for (MemberAccountBill memberAccountBill : selfIdBill) {
				if (StringUtils.isEmpty(memberAccountBill.getSelfName())) {
					billsList.add(memberAccountBill);
				}
			}
		}

		if (billsList.size() > 0) {
			BigDecimal outManoy = BigDecimal.ZERO;
			BigDecimal inManoy = BigDecimal.ZERO;
			Iterator<MemberAccountBill> it = billsList.iterator();
			while (it.hasNext()) {
				MemberAccountBill memberAccountBill = it.next();
			
				logger.info("for:Bill = {}",JSON.toJSON(memberAccountBill.getMoney()));
				if (memberAccountBill.getMoney().compareTo(BigDecimal.valueOf(0.000001))<0) {
					it.remove();
					logger.info("remove:Bill = {}",JSON.toJSON(memberAccountBill));
//					continue;//满足条件跳出当次循环
				
				}
			}
			
			for (MemberAccountBill memberAccountBill : billsList) {
				Integer type = memberAccountBill.getType();
				if (type.equals(7) || type.equals(8) || type.equals(9)) { // 支出 7|买商品,8|买套餐,9|提现
					memberAccountBill.setUpId(null);
					memberAccountBill.setUpName(null);
					billService.update(memberAccountBill);
					outManoy = outManoy.add(memberAccountBill.getMoney());
					logger.info("out:money = {}",JSON.toJSON(memberAccountBill.getMoney()));
					
					modelAndView.put("outManoy", outManoy);
				} else {
					inManoy = inManoy.add(memberAccountBill.getMoney());
					if (inManoy.equals(member.getGeneralizeCost())) {
						modelAndView.put("inManoy", inManoy);
					}else {
						inManoy = member.getGeneralizeCost();
						modelAndView.put("inManoy", inManoy);
					}
				}
			}
		}
		modelAndView.put("bills", billsList);

		return PATH + "memberBill";
	}

	// 查本月账单
	@ResponseBody
	@RequestMapping("thisMonth")
	public Map<String, Object> thisMonth() {
		Map<String, Object> map = new HashMap<>();
		Member member = WXHelper.getMember(getRealMember());

		List<MemberAccountBill> accountBills = billService.listEq("selfId", member.getId());

		List<MemberAccountBill> list = null;
		if (accountBills.size() > 0) {
			map.put("stats", 1);
			map.put("msg", "ok");
			for (MemberAccountBill bill : accountBills) {
				LocalDateTime createTime = bill.getCreateTime();
				boolean includeTime = DateUtil.includeTime(createTime,
						DateUtil.stringDateToLocalDateTime(DateUtil.firstDayOfMonty()), LocalDateTime.now());
				if (includeTime) { // 创建时间在本月
					list = new ArrayList<>();
					list.add(bill);
				}

			}
		} else {
			map.put("stats", 2);
			map.put("msg", "no");

		}

		if (list.size() > 0) {
			map.put("bills", list);
		}

		return map;
	}

	public static void main(String[] args) {
	}

}
