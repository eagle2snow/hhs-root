package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IDrawDao;
import com.gm.base.model.Draw;
import com.gm.service.IDrawService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("drawSercive")
public class DrawServiceImpl extends BaseServiceImpl<Draw, Integer> implements IDrawService {
	@Resource
	private IDrawDao dao;

	@Override
	public IBaseDao<Draw, Integer> getDao() {
		return dao;
	}
}