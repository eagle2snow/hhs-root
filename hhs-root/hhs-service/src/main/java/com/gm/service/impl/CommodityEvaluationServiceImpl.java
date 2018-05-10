package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.ICommodityEvaluationDao;
import com.gm.base.model.CommodityEvaluation;
import com.gm.service.ICommodityEvaluationService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("commodityEvaluationSercive")
public class CommodityEvaluationServiceImpl extends BaseServiceImpl<CommodityEvaluation, Integer> implements ICommodityEvaluationService {
	@Resource
	private ICommodityEvaluationDao dao;

	@Override
	public IBaseDao<CommodityEvaluation, Integer> getDao() {
		return dao;
	}
}