package com.gm.wx.controller;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gm.base.consts.Const;
import com.gm.base.dao.IMemberAccountBillDao;
import com.gm.base.model.Draw;
import com.gm.base.model.Member;
import com.gm.base.model.MemberAccountBill;
import com.gm.service.IDrawService;
import com.gm.service.IMemberService;

/**
 * 
 * <p>
 * Title: WxIndexController
 * </p>
 * 
 * <p>
 * Description: 提现
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年4月23日
 */
@Controller
@RequestMapping("/wx/myCenter/draw")
public class WxMyDrawController extends WeixinBaseController {

	@Resource
	private IDrawService drawService;

	@Resource
	private IMemberService memberService;
	
	@Autowired
	private IMemberAccountBillDao accountBillDao;

	private static final String PATH = "/wx/myCenter/draw/";

	/**
	 * 
	 * <p>
	 * Title: toDraw
	 * </p>
	 * 
	 * <p>
	 * Description: 去提现
	 * </p>
	 * 
	 * @return
	 */
	@RequestMapping("/toDraw")
	public String toDraw(ModelMap map) {
		map.put("path", PATH);
		Member member = WXHelper.getMember(getRealMember());
		map.put("member", member);
		return PATH + "toDraw";
	}

	/**
	 * 
	 * <p>
	 * Title: addDraw
	 * </p>
	 * 
	 * <p>
	 * Description: 提现提交
	 * </p>
	 * 
	 * @param draw
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/addDraw")
	public Map<String, Object> addDraw(Draw draw, HttpSession session) {
		Map<String, Object> map = getMap();
		Member member = memberService.get(getCurMember().getId());
		draw.setMember(member);
		draw.setStatus(1);
		BigDecimal subtractAmount = draw.getAmount().subtract(draw.getAmount().multiply(Const.serviceCharge));
		draw.setAmount(subtractAmount); //服务费 0.47
		
		if (draw.getAmount().compareTo(member.getBalance()) == 1) {
			map.put("balance", member.getBalance());
			map.put("s", -1);// 余额不足
		} else if (drawService.save(draw)) {
			member.setBalance(member.getBalance().subtract(draw.getAmount()));
			
			MemberAccountBill accountBill = new MemberAccountBill();
			accountBill.setSelfId(member.getId());
			accountBill.setCreateTime(LocalDateTime.now());
			accountBill.setType(9); //9|提现
			accountBill.setMoney(draw.getAmount());
			accountBillDao.save(accountBill);
			
			
			memberService.update(member);
			map.put("s", 1);
		} else {
			map.put("s", 0);
		}
		session.setAttribute(Const.CUR_WX_MEMBER, member);
		return map;
	}

	/**
	 * 
	 * <p>
	 * Title: drawLog
	 * </p>
	 * 
	 * <p>
	 * Description: 提现记录
	 * </p>
	 * 
	 * @return
	 */
	@RequestMapping("/drawLog")
	public String drawLog(ModelMap map) {
		map.put("list", drawService.listEq("member.id", getCurMember().getId()));
		map.put("path", PATH);
		return PATH + "drawLog";
	}

	/**
	 * 
	 * <p>
	 * Title: cancelDraw
	 * </p>
	 * 
	 * <p>
	 * Description: 取消提现
	 * </p>
	 * 
	 * @param id
	 * @param session
	 * @return
	 */
	@RequestMapping("cancelDraw/{id}")
	@ResponseBody
	public Map<String, Object> cancelDraw(@PathVariable Integer id, HttpSession session) {
		Map<String, Object> map = getMap();
		Draw draw = drawService.get(id);
		if (draw.getStatus() == 1 ||draw.getStatus() == 2) {
			draw.setStatus(5);
			drawService.update(draw);
			memberService.updateByHql(
					"update member m set m.balance=m.balance+" + draw.getAmount() + " where m.id=" + getMid());
			Member member = getRealMember();
			member.setBalance(member.getBalance().add(draw.getAmount()));
			session.setAttribute(Const.CUR_WX_MEMBER, member);
			map.put("s", 1);
		} else {
			map.put("s", 2);
		}
		return map;
	}

}
