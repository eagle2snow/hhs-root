package com.gm.service.impl;

import java.math.BigDecimal;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IPayBillDao;
import com.gm.base.model.PayBill;
import com.gm.service.IMemberService;
import com.gm.service.IOrderItemService;
import com.gm.service.IOrderService;
import com.gm.service.IPayBillService;
import com.gm.base.dao.IBaseDao;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
@Service("payBillSercive")
public class PayBillServiceImpl extends BaseServiceImpl<PayBill, Integer> implements IPayBillService {
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
	public void paySuccess(String orderId, Double amount, String time, String outTradeNo) {
		PayBill payBill = getOne("orderNo", orderId);
		if (null != payBill) {
			payBill.setPay(2);
			payBill.setPayTime(time);
			payBill.setReaFee(BigDecimal.valueOf(amount).divide(BigDecimal.valueOf(100)));
			payBill.setTransactionId(outTradeNo);
			update(payBill);
			if (payBill.getType() == 1) { // 购买套餐
				memberService.payMemberSuccess(payBill.getOpenid());
			} else if (payBill.getType() == 2) {// 购买商品
				orderService.payOrderSuccess(payBill.getOrderNo());
			}

		}
	}
}