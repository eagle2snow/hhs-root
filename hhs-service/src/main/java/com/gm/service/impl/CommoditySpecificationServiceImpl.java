package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.ICommoditySpecificationDao;
import com.gm.base.model.CommoditySpecification;
import com.gm.service.ICommoditySpecificationService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("commoditySpecificationSercive")
public class CommoditySpecificationServiceImpl extends BaseServiceImpl<CommoditySpecification, Integer> implements ICommoditySpecificationService {
	@Resource
	private ICommoditySpecificationDao dao;

	@Override
	public IBaseDao<CommoditySpecification, Integer> getDao() {
		return dao;
	}
}