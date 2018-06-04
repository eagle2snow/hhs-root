package com.gm.service;

import com.gm.base.model.PayBill;

/**
 * 代码生成器生成代码<br/>
 * IPayBillService
 * @author guet
 *
 */
public interface IPayBillService extends IBaseService<PayBill, Integer> {

	void paySuccess(PayBill payBill);

}