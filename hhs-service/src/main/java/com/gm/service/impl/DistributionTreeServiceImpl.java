package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IDistributionTreeDao;
import com.gm.base.model.DistributionTree;
import com.gm.service.IDistributionTreeService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("distributionTreeSercive")
public class DistributionTreeServiceImpl extends BaseServiceImpl<DistributionTree, Integer> implements IDistributionTreeService {
	@Resource
	private IDistributionTreeDao dao;

	@Override
	public IBaseDao<DistributionTree, Integer> getDao() {
		return dao;
	}
}