package com.gm.wx.controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
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
import com.gm.utils.LocalDateUtil;

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
	public String memberBill(@PathVariable Integer memberId, ModelMap modelAndView) {
		logger.info("memberBill:the args memberId = {}", memberId);

		List<MemberAccountBill> accountBills = billService.listEq("selfId", memberId);
		logger.info("memberBill:List<MemberAccountBill> accountBills = {}", JSON.toJSON(accountBills));

		if (accountBills.size() > 0) {
			modelAndView.put("accountBills", accountBills);
			BigDecimal outManoy = BigDecimal.ZERO;
			BigDecimal inManoy = BigDecimal.ZERO;
			for (MemberAccountBill memberAccountBill : accountBills) {
				//处理时间
				
				DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
				String localTime = df.format(memberAccountBill.getCreateTime());
				System.out.println("LocalDateTime转成String类型的时间："+localTime);
				modelAndView.put("date", localTime);
				
				// 支出 7|买商品,8|买套餐,9|提现
				if (memberAccountBill.getType() == 7 || memberAccountBill.getType() == 8
						|| memberAccountBill.getType() == 9) {
					outManoy = outManoy.add(memberAccountBill.getMoney());
					modelAndView.put("outManoy", outManoy);
					System.out.println(outManoy);
				
				} else { // 收入
					inManoy = inManoy.add(memberAccountBill.getMoney());
					modelAndView.put("inManoy", inManoy);
					System.out.println(inManoy);

				}

			}

		}

		return PATH + "memberBill";
	}
}
