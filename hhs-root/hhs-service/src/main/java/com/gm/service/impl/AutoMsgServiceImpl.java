package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IAutoMsgDao;
import com.gm.base.model.AutoMsg;
import com.gm.service.IAutoMsgService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("autoMsgSercive")
public class AutoMsgServiceImpl extends BaseServiceImpl<AutoMsg, Integer> implements IAutoMsgService {
	@Resource
	private IAutoMsgDao dao;

	@Override
	public IBaseDao<AutoMsg, Integer> getDao() {
		return dao;
	}
}