package com.gm.service.sys.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.sys.IUserResDao;
import com.gm.base.model.sys.UserRes;
import com.gm.service.sys.IUserResService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("userResSercive")
public class UserResServiceImpl extends BaseServiceImpl<UserRes, Integer> implements IUserResService {
	@Resource
	private IUserResDao dao;

	@Override
	public IBaseDao<UserRes, Integer> getDao() {
		return dao;
	}
}