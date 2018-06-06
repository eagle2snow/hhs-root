package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IMemberAccountBillDao;
import com.gm.base.model.MemberAccountBill;
import com.gm.service.IMemberAccountBillService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("memberAccountBillSercive")
public class MemberAccountBillServiceImpl extends BaseServiceImpl<MemberAccountBill, Integer> implements IMemberAccountBillService {
	@Resource
	private IMemberAccountBillDao dao;

	@Override
	public IBaseDao<MemberAccountBill, Integer> getDao() {
		return dao;
	}
}