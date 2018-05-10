package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IMemberAddressDao;
import com.gm.base.model.MemberAddress;
import com.gm.service.IMemberAddressService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("memberAddressSercive")
public class MemberAddressServiceImpl extends BaseServiceImpl<MemberAddress, Integer> implements IMemberAddressService {
	@Resource
	private IMemberAddressDao dao;

	@Override
	public IBaseDao<MemberAddress, Integer> getDao() {
		return dao;
	}
}