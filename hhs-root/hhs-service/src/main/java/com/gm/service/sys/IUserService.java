package com.gm.service.sys;

import com.gm.service.IBaseService;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.gm.base.model.sys.Res;
import com.gm.base.model.sys.User;

/**
 * 代码生成器生成代码<br/>
 * IUserService
 * 
 * @author guet
 *
 */
public interface IUserService extends IBaseService<User, Integer> {

	/**
	 * 获取菜单
	 * 
	 * @param id
	 * @return
	 */
	List<Res> getMenu(Integer id);

	/**
	 * 登录
	 * 
	 * @param username
	 * @param password
	 * @return
	 */
	User login(String username, String password);

}