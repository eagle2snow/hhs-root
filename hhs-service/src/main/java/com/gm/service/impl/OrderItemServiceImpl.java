package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IOrderItemDao;
import com.gm.base.model.OrderItem;
import com.gm.service.IOrderItemService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("orderItemSercive")
public class OrderItemServiceImpl extends BaseServiceImpl<OrderItem, Integer> implements IOrderItemService {
	@Resource
	private IOrderItemDao dao;

	@Override
	public IBaseDao<OrderItem, Integer> getDao() {
		return dao;
	}
}