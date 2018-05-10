package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IMemberBuyDao;
import com.gm.base.model.MemberBuy;
import com.gm.service.IMemberBuyService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("memberBuySercive")
public class MemberBuyServiceImpl extends BaseServiceImpl<MemberBuy, Integer> implements IMemberBuyService {
	@Resource
	private IMemberBuyDao dao;

	@Override
	public IBaseDao<MemberBuy, Integer> getDao() {
		return dao;
	}
}