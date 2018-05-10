package com.gm.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.ICartDao;
import com.gm.base.model.Cart;
import com.gm.service.ICartService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("cartSercive")
public class CartServiceImpl extends BaseServiceImpl<Cart, Integer> implements ICartService {
	@Resource
	private ICartDao dao;

	@Override
	public IBaseDao<Cart, Integer> getDao() {
		return dao;
	}

	@Override
	public boolean existCommodity(Integer memberId, Integer commodityId) {
		Long n = getDao()
				.countByHQL(" from cart c where c.member.id=" + memberId + " and c.commodity.id=" + commodityId);
		return n > 0;
	}

	@Override
	public Cart checkCommodityInCart(Integer memberId, Integer commodityId) {
		Cart cart = getDao()
				.getOne(" from cart c where c.member.id=" + memberId + " and c.commodity.id=" + commodityId);
		return cart;
	}
}