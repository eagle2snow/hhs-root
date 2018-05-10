package com.gm.service.sys.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.sys.ILoginLogDao;
import com.gm.base.model.sys.LoginLog;
import com.gm.service.sys.ILoginLogService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("loginLogSercive")
public class LoginLogServiceImpl extends BaseServiceImpl<LoginLog, Integer> implements ILoginLogService {
	@Resource
	private ILoginLogDao dao;

	@Override
	public IBaseDao<LoginLog, Integer> getDao() {
		return dao;
	}
}