package com.gm.service.impl;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IBaseDao;
import com.gm.base.dao.IPayBillDao;
import com.gm.base.model.PayBill;
import com.gm.service.IMemberService;
import com.gm.service.IOrderService;
import com.gm.service.IPayBillService;

@Transactional
@Service("payBillSercive")
public class PayBillServiceImpl extends BaseServiceImpl<PayBill, Integer> implements IPayBillService {

	private static final Logger logger = LoggerFactory.getLogger(PayBillServiceImpl.class);

	@Resource
	private IPayBillDao dao;

	@Resource
	private IMemberService memberService;
	@Resource
	private IOrderService orderService;

	@Override
	public IBaseDao<PayBill, Integer> getDao() {
		return dao;
	}

	@Override
	public void paySuccess(PayBill payBill)
	{
		if (payBill == null)
			return;
		if (payBill.getType() == 1) { // 购买套餐
			memberService.payMemberSuccess(payBill.getOpenid(), payBill);
			logger.info("paySuccess: ================套餐================");
		} else if (payBill.getType() == 2) {// 购买商品
			orderService.payOrderSuccess(payBill.getOrderNo(), payBill);
			logger.info("paySuccess: ================商品================");
		}
	}
}