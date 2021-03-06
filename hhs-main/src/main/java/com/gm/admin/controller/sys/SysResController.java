package com.gm.admin.controller.sys;

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

import com.gm.base.model.sys.Res;
import com.gm.service.sys.IResService;
import com.gm.admin.controller.BaseAdminController;
import com.gm.base.query.Page;
import com.gm.utils.StringUtil;

/**
 * 后台用户操作
 * 
 * @author Guet
 *
 */
@Controller
@RequestMapping("/admin/sys/res/")
public class SysResController extends BaseAdminController {

	private final static String path = "admin/sys/res/";

	@Resource
	private IResService resService;
	@Resource
	private IResService parentService;

	@RequestMapping("add.htm")
	// @RequiresPermissions("admin:sys:res:add")
	public String addView(ModelMap map) {

		map.put("path", path);
		map.put("parentList", parentService.list());
		return path + "add";
	}

	// @RequiresPermissions("admin:sys:res:add")
	@ResponseBody
	@RequestMapping("add.json")
	public Map<String, Object> addAction(Res model) {
		Map<String, Object> map = new HashMap<>();
		if (resService.save(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	// @RequiresPermissions("admin:sys:res:update")
	@RequestMapping("update/{id}.htm")
	public String updateView(@PathVariable Integer id, ModelMap map) {
		Res model = resService.get(id);
		map.put("path", path);
		map.put("model", model);
		map.put("parentList", parentService.list());
		return path + "update";
	}

	// @RequiresPermissions("admin:sys:res:update")
	@RequestMapping("update.json")
	@ResponseBody
	public Map<String, Object> updateAction(Res model) {
		Map<String, Object> map = new HashMap<>();
		if (resService.update(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	// @RequiresPermissions("admin:sys:res:show")
	@RequestMapping("show/{id}.htm")
	public String showView(@PathVariable Integer id, ModelMap map) {
		Res model = resService.get(id);
		map.put("model", model);
		map.put("path", path);
		return path + "show";
	}

	// @RequiresPermissions("admin:sys:res:show")
	@RequestMapping("list/{pageIndex}/{pageSize}.htm")
	public String manager(ModelMap map, @PathVariable Integer pageIndex, @PathVariable Integer pageSize, String k) {
		DetachedCriteria dc = DetachedCriteria.forClass(Res.class);
		if (!StringUtil.strNullOrEmpty(k)) {
			dc.add(Restrictions.ilike("name", k.trim(), MatchMode.ANYWHERE));
		}
		Page<Res> list = resService.list(dc, pageIndex, pageSize);
		map.put("page", list);
		map.put("path", path);
		map.put("key", k);
		return path + "list";
	}

	// @RequiresPermissions("admin:sys:res:delete")
	@RequestMapping("deleteById/{id}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (resService.deleteById(id, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	// @RequiresPermissions("admin:sys:res:delete")
	@RequestMapping("deleteByIds/{ids}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable String ids) {
		Map<String, Object> map = new HashMap<>();
		List<Integer> arrayId = StringUtil.splitToInt(ids, ",");
		if (resService.deleteByIds(arrayId, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	// @RequiresPermissions("admin:sys:res:update")
	@RequestMapping("updatePVById/{p}/{v}/{id}.json")
	@ResponseBody
	public Map<String, Object> updatePVById(@PathVariable String p, @PathVariable Integer v, @PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (resService.update(p, v, id)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

}
