package com.gm.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gm.base.model.MemberAccountBill;
import com.gm.base.query.Page;
import com.gm.service.IMemberAccountBillService;
import com.gm.service.IMemberService;
import com.gm.service.IOrderService;
import com.gm.utils.StringUtil;

/**
 * 后台用户操作
 * 
 * @author Guet
 *
 */
@Controller
@RequestMapping("/admin/memberaccountbill/")
public class AdminMemberAccountBillController extends BaseAdminController{

	private final static String path = "admin/memberaccountbill/";

	@Resource
	private IMemberAccountBillService memberAccountBillService;
	 @Resource private IOrderService orderService;  @Resource private IMemberService memberService; 

	@RequestMapping("add.htm")
	@RequiresPermissions("admin:memberaccountbill:add")
	public String addView(ModelMap map) {
		
		map.put("path", path);
		map.put("orderList",orderService.list());map.put("memberList",memberService.list());
		return path + "add";
	}

	
	@RequiresPermissions("admin:memberaccountbill:add")
	@ResponseBody
	@RequestMapping("add.json")
	public Map<String, Object> addAction(MemberAccountBill model) {
		Map<String, Object> map = new HashMap<>();
		if (memberAccountBillService.save(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:memberaccountbill:update")
	@RequestMapping("update/{id}.htm")
	public String updateView(@PathVariable Integer id, ModelMap map) {
		MemberAccountBill model = memberAccountBillService.get(id);
		map.put("path", path);
		map.put("model", model);
		map.put("orderList",orderService.list());map.put("memberList",memberService.list());
		return path + "update";
	}

	
	@RequiresPermissions("admin:memberaccountbill:update")
	@RequestMapping("update.json")
	@ResponseBody
	public Map<String, Object> updateAction(MemberAccountBill model) {
		Map<String, Object> map = new HashMap<>();
		if (memberAccountBillService.update(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:memberaccountbill:show")
	@RequestMapping("show/{id}.htm")
	public String showView(@PathVariable Integer id, ModelMap map) {
		MemberAccountBill model = memberAccountBillService.get(id);
		map.put("model", model);
		map.put("path", path);
		return path + "show";
	}

	
	
	@RequiresPermissions("admin:memberaccountbill:show")
	@RequestMapping("list/{pageIndex}/{pageSize}.htm")
	public String manager(ModelMap map, @PathVariable Integer pageIndex, @PathVariable Integer pageSize,String k) {
		DetachedCriteria dc = DetachedCriteria.forClass(MemberAccountBill.class);
		if (!StringUtil.strNullOrEmpty(k)) {
			dc.add(Restrictions.ilike("name", k.trim(),MatchMode.ANYWHERE));
		}
		Page<MemberAccountBill> list = memberAccountBillService.list(dc, pageIndex, pageSize);
		map.put("page", list);
		map.put("path", path);
		map.put("key", k);
		return path + "list";
	}

	
	@RequiresPermissions("admin:memberaccountbill:delete")
	@RequestMapping("deleteById/{id}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (memberAccountBillService.deleteById(id, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:memberaccountbill:delete")
	@RequestMapping("deleteByIds/{ids}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable String ids) {
		Map<String, Object> map = new HashMap<>();
		List<Integer> arrayId = StringUtil.splitToInt(ids, ",");
		if (memberAccountBillService.deleteByIds(arrayId, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}
	
	@RequiresPermissions("admin:memberaccountbill:update")
	@RequestMapping("updatePVById/{p}/{v}/{id}.json")
	@ResponseBody
	public Map<String, Object> updatePVById(@PathVariable String p, @PathVariable Integer v, @PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (memberAccountBillService.update(p, v, id)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}
	
}
