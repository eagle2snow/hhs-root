package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.ICommodityDao;
import com.gm.base.model.Commodity;
import com.gm.service.ICommodityService;

@Transactional
@Service("commoditySercive")
public class CommodityServiceImpl extends BaseServiceImpl<Commodity, Integer> implements ICommodityService {
	@Resource
	private ICommodityDao dao;

	@Override
	public IBaseDao<Commodity, Integer> getDao() {
		return dao;
	}
}