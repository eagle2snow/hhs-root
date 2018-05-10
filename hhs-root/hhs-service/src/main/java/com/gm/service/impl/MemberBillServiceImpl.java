package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IMemberBillDao;
import com.gm.base.model.MemberBill;
import com.gm.service.IMemberBillService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("memberBillSercive")
public class MemberBillServiceImpl extends BaseServiceImpl<MemberBill, Integer> implements IMemberBillService {
	@Resource
	private IMemberBillDao dao;

	@Override
	public IBaseDao<MemberBill, Integer> getDao() {
		return dao;
	}
}