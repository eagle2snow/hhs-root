package com.gm.service.sys.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.sys.IResDao;
import com.gm.base.model.sys.Res;
import com.gm.service.sys.IResService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("resSercive")
public class ResServiceImpl extends BaseServiceImpl<Res, Integer> implements IResService {
	@Resource
	private IResDao dao;

	@Override
	public IBaseDao<Res, Integer> getDao() {
		return dao;
	}
}