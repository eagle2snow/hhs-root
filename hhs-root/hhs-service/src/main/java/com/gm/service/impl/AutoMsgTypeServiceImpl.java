package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IAutoMsgTypeDao;
import com.gm.base.model.AutoMsgType;
import com.gm.service.IAutoMsgTypeService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("autoMsgTypeSercive")
public class AutoMsgTypeServiceImpl extends BaseServiceImpl<AutoMsgType, Integer> implements IAutoMsgTypeService {
	@Resource
	private IAutoMsgTypeDao dao;

	@Override
	public IBaseDao<AutoMsgType, Integer> getDao() {
		return dao;
	}
}