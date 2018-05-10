package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.ICommodityAppraiseDao;
import com.gm.base.model.CommodityAppraise;
import com.gm.service.ICommodityAppraiseService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("commodityAppraiseSercive")
public class CommodityAppraiseServiceImpl extends BaseServiceImpl<CommodityAppraise, Integer> implements ICommodityAppraiseService {
	@Resource
	private ICommodityAppraiseDao dao;

	@Override
	public IBaseDao<CommodityAppraise, Integer> getDao() {
		return dao;
	}
}