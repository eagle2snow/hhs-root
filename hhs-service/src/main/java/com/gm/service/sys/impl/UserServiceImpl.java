package com.gm.service.sys.impl;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.sys.IUserDao;
import com.gm.base.model.sys.Res;
import com.gm.base.model.sys.User;
import com.gm.service.impl.BaseServiceImpl;
import com.gm.service.sys.IUserService;

@Transactional
@Service("userSercive")
public class UserServiceImpl extends BaseServiceImpl<User, Integer> implements IUserService {

	Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);

	@Resource
	private IUserDao dao;

	@Override
	public IBaseDao<User, Integer> getDao() {
		return dao;
	}

	@Override
	public User login(String username, String password) {

		User u = getOne(
				"from user u where u.deleted=1 and u.username='" + username + " 'and u.password='" + password + "'");
		return u;
	}

	@Override
	public List<Res> getMenu(Integer id) {
		return null;
	}

}