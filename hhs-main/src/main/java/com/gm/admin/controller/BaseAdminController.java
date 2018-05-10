package com.gm.admin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;

import com.gm.base.consts.Const;
import com.gm.base.controller.BaseController;
import com.gm.base.model.sys.User;
import com.gm.utils.DateUtil;

public class BaseAdminController extends BaseController {

	@InitBinder
	void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat(DateUtil.f2);
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
	}

	/**
	 * 获取当前登录会员
	 * 
	 * @return
	 */
	public User getCurUser() {
		return (User) getRequest().getSession().getAttribute(Const.CUR_USER);
	}

}
