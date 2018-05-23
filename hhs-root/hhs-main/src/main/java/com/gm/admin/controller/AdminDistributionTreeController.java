package com.gm.admin.controller;

import java.util.ArrayList;
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

import com.alibaba.fastjson.JSON;
import com.gm.base.model.DistributionTree;
import com.gm.base.model.Member;
import com.gm.base.query.Page;
import com.gm.base.tree.ZTree;
import com.gm.gencode.util.MultipleTree;
import com.gm.service.IDistributionTreeService;
import com.gm.service.IMemberService;
import com.gm.utils.StringUtil;

import javassist.expr.NewArray;

/**
 * 后台多叉树展示
 * 
 * @author Guet
 *
 */
@Controller
@RequestMapping("/admin/distributiontree/")
public class AdminDistributionTreeController extends BaseAdminController{

	private final static String path = "admin/distributiontree/";

	@Resource
	private IDistributionTreeService distributionTreeService;
	@Resource
	private IMemberService memberService;
	

	@RequestMapping("add.htm")
	@RequiresPermissions("admin:distributiontree:add")
	public String addView(ModelMap map) {
		
		map.put("path", path);
		
		return path + "add";
	}

	
	@RequiresPermissions("admin:distributiontree:add")
	@ResponseBody
	@RequestMapping("add.json")
	public Map<String, Object> addAction(DistributionTree model) {
		Map<String, Object> map = new HashMap<>();
		if (distributionTreeService.save(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:distributiontree:update")
	@RequestMapping("update/{id}.htm")
	public String updateView(@PathVariable Integer id, ModelMap map) {
		DistributionTree model = distributionTreeService.get(id);
		map.put("path", path);
		map.put("model", model);
		
		return path + "update";
	}

	
	@RequiresPermissions("admin:distributiontree:update")
	@RequestMapping("update.json")
	@ResponseBody
	public Map<String, Object> updateAction(DistributionTree model) {
		Map<String, Object> map = new HashMap<>();
		if (distributionTreeService.update(model)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:distributiontree:show")
	@RequestMapping("show/{id}.htm")
	public String showView(@PathVariable Integer id, ModelMap map) {
		DistributionTree model = distributionTreeService.get(id);
		map.put("model", model);
		map.put("path", path);
		return path + "show";
	}

	
	
	@RequiresPermissions("admin:distributiontree:show")
	@RequestMapping("list/{pageIndex}/{pageSize}.htm")
	public String manager(ModelMap map, @PathVariable Integer pageIndex, @PathVariable Integer pageSize,String k) {
		DetachedCriteria dc = DetachedCriteria.forClass(DistributionTree.class);
		if (!StringUtil.strNullOrEmpty(k)) {
			dc.add(Restrictions.ilike("name", k.trim(),MatchMode.ANYWHERE));
		}
		Page<DistributionTree> list = distributionTreeService.list(dc, pageIndex, pageSize);
		map.put("page", list);
		map.put("path", path);
		map.put("key", k);
		return path + "list";
	}

	
	@RequiresPermissions("admin:distributiontree:delete")
	@RequestMapping("deleteById/{id}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (distributionTreeService.deleteById(id, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}

	
	@RequiresPermissions("admin:distributiontree:delete")
	@RequestMapping("deleteByIds/{ids}.json")
	@ResponseBody
	public Map<String, Object> delete(@PathVariable String ids) {
		Map<String, Object> map = new HashMap<>();
		List<Integer> arrayId = StringUtil.splitToInt(ids, ",");
		if (distributionTreeService.deleteByIds(arrayId, false)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}
	
	@RequiresPermissions("admin:distributiontree:update")
	@RequestMapping("updatePVById/{p}/{v}/{id}.json")
	@ResponseBody
	public Map<String, Object> updatePVById(@PathVariable String p, @PathVariable Integer v, @PathVariable Integer id) {
		Map<String, Object> map = new HashMap<>();
		if (distributionTreeService.update(p, v, id)) {
			map.put("status", "ok");
		} else {
			map.put("status", "no");
		}
		return map;
	}
	
	@RequestMapping("tree")
	public  void Tree() {
		int i =1;
		String T = "1001";
		List dataList = new ArrayList();  
		DetachedCriteria dc = DetachedCriteria.forClass(Member.class); 
		DetachedCriteria dc1 = DetachedCriteria.forClass(Member.class); 
		if (!StringUtil.strNullOrEmpty(T)) {
			dc.add(Restrictions.ilike("referrerGeneralizeId", T,MatchMode.ANYWHERE));
			dc1.add(Restrictions.ilike("generalizeId", T,MatchMode.ANYWHERE));
		}
		Member m = memberService.getOne(dc1);
		HashMap hm = new HashMap();
			hm.put("id", m.getId().toString());  
	        hm.put("text", m.getNickname());  
	        hm.put("parentId", "");
	        dataList.add(hm);
	        
		List<Member> lmember = memberService.list(dc);
		List l = new ArrayList();
		for (Member member : lmember) {
			HashMap data = new HashMap();
			data.put("id",member.getId().toString());    
		    data.put("text", member.getNickname());  
		    data.put("parentId",m.getId().toString());
		    dataList.add(data);	
		    if(!StringUtil.isBlank(member.getGeneralizeId())) {
		    	l.add(member.getGeneralizeId());
		    }
		}
		
		if (l.size()>0) {
			dataList.add(this.Lists(l));
		}
		
		System.out.println(JSON.toJSON(l));
		System.out.println(JSON.toJSON(lmember));
		System.out.println(JSON.toJSON(dataList));

	      
	    MultipleTree.Tree(dataList);
	        
	}
	public List Lists(List list) {
		List ll = new ArrayList();
		List dataList = new ArrayList(); 
		for (Object object : list) {
			DetachedCriteria dc = DetachedCriteria.forClass(Member.class); 
			DetachedCriteria dc1 = DetachedCriteria.forClass(Member.class); 
			dc.add(Restrictions.ilike("referrerGeneralizeId",object.toString(),MatchMode.ANYWHERE));
			dc1.add(Restrictions.ilike("generalizeId", object.toString(),MatchMode.ANYWHERE));
			Member m = memberService.getOne(dc1);
			List<Member> lmember = memberService.list(dc);
			for (Member member : lmember) {
				HashMap data = new HashMap();
				data.put("id",member.getId().toString());    
			    data.put("text", member.getNickname());  
			    data.put("parentId",m.getId().toString());
			    dataList.add(data);	
			    if(!StringUtil.isBlank(member.getGeneralizeId())) {
			    	ll.add(member.getGeneralizeId());
			    }
			}
		}
		if(ll.size()>0) {
			this.Lists(ll);
		}
		return dataList;
	}
	
}
