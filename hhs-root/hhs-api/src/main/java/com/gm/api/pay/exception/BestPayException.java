package com.gm.api.pay.exception;

import com.gm.api.pay.emums.BestPayResultEnum;

/**
 * Created by null on 2017/2/23.
 */
public class BestPayException extends RuntimeException {

	private Integer code;

	public BestPayException(BestPayResultEnum payTypeError) {
		super(payTypeError.getMsg());
		code = payTypeError.getCode();
	}

	public Integer getCode() {
		return code;
	}
}
