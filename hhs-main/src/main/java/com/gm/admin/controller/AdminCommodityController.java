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

import com.gm.base.model.Commodity;
import com.gm.base.model.Member;
import com.gm.base.query.Page;
import com.gm.service.ICommodityClassService;
import com.gm.service.ICommodityService;
import com.gm.utils.StringUtil;

/**
 * 后台用户操作
 * 
 * @author Guet
 *
 */
@Controller
@RequestMapping("/admin/commodity/")
public class AdminCommodityController extends BaseAdminController{

	private final static String path = "admin/commodity/";

	@Resource
	private ICommodityService commodityService;
	 @Resource private ICommodityClassService commodityClassService; 

	@RequestMapping("add.htm")
	@RequiresPermissions("admin:commodity:add")
	public String addView(ModelMap map) {
		
		map.put("path", path);
		map.put("commodityClassList",commodityClassService.list());
		return path + "add";
	}

	
	@RequiresPermissions("admin:commodity:add")
	@ResponseBody
	@RequestMapping("add.json")
	public Map<String, Object> addAction(Commodity model) {
		Map<String, Object> map = new HashMap<>();
		if (commodityService.save(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	

    @RequiresPermissions("admin:commodity:update")
	@RequestMapping("update/{id}.htm")
	public String updateView(@PathVariable Integer id, ModelMap map) {
		Commodity model = commodityService.get(id);
		map.put("path", path);
		map.put("model", model);
		map.put("commodityClassList",commodityClassService.list());
		return path + "update";
	}
	
	@RequiresPermissions("admin:commodity:update")
	@RequestMapping("update.json")
	@ResponseBody
	public Map<String, Object> updateAction(Commodity model) {
		Map<String, Object> map = new HashMap<>();
		if (commodityService.update(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:commodity:show")
	@RequestMapping("show/{id}.htm")
	public String showView(@PathVariable Integer id, ModelMap map) {
		Commodity model = commodityService.get(id);
		map.put("model", model);
		map.put("path", path);
		return path + "show";
	}

	
	
	@RequiresPermissions("admin:commodity:show")
	@RequestMapping("list/{pageIndex}/{pageSize}.htm")
	public String manager(ModelMap map, @PathVariable Integer pageIndex, @PathVariable Integer pageSize,String k) {
		DetachedCriteria dc = DetachedCriteria.forClass(Commodity.class);
		if (!StringUtil.strNullOrEmpty(k)) {
			dc.add(Restrictions.ilike("name", k.trim(),MatchMode.ANYWHERE));
		}
		Page<Commodity> list = commodityService.list(dc, pageIndex, pageSize);
		map.put("page", list);
		map.put("path", path);
		map.put("key", k);
		return path + "list";
	}

	
	@RequiresPermissions("admin:commodity:delete")
	@RequestMapping("deleteById/{id}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (commodityService.deleteById(id, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:commodity:delete")
	@RequestMapping("deleteByIds/{ids}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable String ids) {
		Map<String, Object> map = new HashMap<>();
		List<Integer> arrayId = StringUtil.splitToInt(ids, ",");
		if (commodityService.deleteByIds(arrayId, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}
	
	@RequiresPermissions("admin:commodity:update")
	@RequestMapping("updatePVById/{p}/{v}/{id}.json")
	@ResponseBody
	public Map<String, Object> updatePVById(@PathVariable String p, @PathVariable Integer v, @PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (commodityService.update(p, v, id)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}
	@RequiresPermissions("admin:commodity:details")
	@RequestMapping("details/{id}.htm")
	public String detailsView(@PathVariable Integer id, ModelMap map) {
		Commodity model = commodityService.get(id);
		map.put("path", path);
		map.put("model", model);

		return path + "details";
	}
	
}
