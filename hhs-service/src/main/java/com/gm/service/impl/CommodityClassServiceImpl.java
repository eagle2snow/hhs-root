package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.ICommodityClassDao;
import com.gm.base.model.CommodityClass;
import com.gm.service.ICommodityClassService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("commodityClassSercive")
public class CommodityClassServiceImpl extends BaseServiceImpl<CommodityClass, Integer> implements ICommodityClassService {
	@Resource
	private ICommodityClassDao dao;

	@Override
	public IBaseDao<CommodityClass, Integer> getDao() {
		return dao;
	}
}