package com.gm.service.sys.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.sys.IOptLogDao;
import com.gm.base.model.sys.OptLog;
import com.gm.service.sys.IOptLogService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("optLogSercive")
public class OptLogServiceImpl extends BaseServiceImpl<OptLog, Integer> implements IOptLogService {
	@Resource
	private IOptLogDao dao;

	@Override
	public IBaseDao<OptLog, Integer> getDao() {
		return dao;
	}
}