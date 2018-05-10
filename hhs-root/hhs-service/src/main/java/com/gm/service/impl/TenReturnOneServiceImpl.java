package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.ITenReturnOneDao;
import com.gm.base.model.TenReturnOne;
import com.gm.service.ITenReturnOneService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("tenReturnOneSercive")
public class TenReturnOneServiceImpl extends BaseServiceImpl<TenReturnOne, Integer> implements ITenReturnOneService {
	@Resource
	private ITenReturnOneDao dao;

	@Override
	public IBaseDao<TenReturnOne, Integer> getDao() {
		return dao;
	}
}