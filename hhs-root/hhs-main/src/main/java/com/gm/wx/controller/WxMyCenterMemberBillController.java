package com.gm.wx.controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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

		List<MemberAccountBill> accountBills = billService.listEq("selfId", memberId);
		logger.info("List<MemberAccountBill> accountBills selfId = {}",JSON.toJSON(accountBills.size()));
		List<MemberAccountBill> accountBillss = billService.listEq("upId", memberId);
		logger.info("List<MemberAccountBill> accountBillss upId = {}",JSON.toJSON(accountBillss.size()));
		List<List<MemberAccountBill>> bills = new ArrayList<>();
		bills.add(accountBillss);
		bills.add(accountBills);

		if (bills.size() > 0) {
			BigDecimal outManoy = BigDecimal.ZERO;
			BigDecimal inManoy = BigDecimal.ZERO;
			List<MemberAccountBill> billList = new ArrayList<>();
			for (List<MemberAccountBill> list : bills) {
				
				
				for (MemberAccountBill memberAccountBill : list) {
					Integer type = memberAccountBill.getType();
					if (type.equals(7) || type.equals(8) || type.equals(9)) {
						memberAccountBill.setUpId(null);
						memberAccountBill.setUpName(null);
						billService.update(memberAccountBill);
						
					}
					billList.add(memberAccountBill);
					
					// 处理时间
					DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
					String localTime = df.format(memberAccountBill.getCreateTime());
					modelAndView.put("date", localTime);

					// 支出 7|买商品,8|买套餐,9|提现
					if (memberAccountBill.getType() == 7 || memberAccountBill.getType() == 8
							|| memberAccountBill.getType() == 9) {
						outManoy = outManoy.add(memberAccountBill.getMoney());
						modelAndView.put("outManoy", outManoy);

					} else { // 收入
						inManoy = inManoy.add(memberAccountBill.getMoney());
						modelAndView.put("inManoy", inManoy);

					}

				}
			}
			modelAndView.put("bills", billList);
			logger.info("List<MemberAccountBill> accountBillss upId = {}",JSON.toJSON(billList.size()));
			
			
		}

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
