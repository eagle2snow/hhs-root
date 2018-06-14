package com.gm.wx.controller;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.gm.base.controller.BaseController;
import com.gm.base.model.MemberAccountBill;
import com.gm.service.IMemberAccountBillService;
import com.gm.service.IMemberService;

@Controller
@RequestMapping("wx/myCenter/")
public class WxMyCenterMemberBillController extends BaseController {

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
	public String memberBill(@PathVariable Integer memberId,ModelMap modelAndView) {
		logger.info("memberBill:the args memberId = {}", memberId);

		List<MemberAccountBill> accountBills = billService.listEq("selfId", memberId);
		logger.info("memberBill:List<MemberAccountBill> accountBills = {}", JSON.toJSON(accountBills));

		if (accountBills.size() > 0)
			modelAndView.put("accountBills", accountBills);

		return PATH + "memberBill";
	}
}
