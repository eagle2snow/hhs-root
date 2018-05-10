package com.gm.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;

import com.gm.base.consts.Const;
import com.gm.base.dto.ShotMessageDate;
import com.gm.base.dto.ShotMessageParameter;
import com.gm.service.IShotMessageService;
import com.gm.utils.DateUtil;
import com.gm.utils.Md5Util;

/**
 * @author:     Ealge 
 * @date:       2018年5月8日 下午2:12:28 
 * @ClassName:  ShotMessageServiceImpl 
 * @Description:短信处理器   
 *     
 * @Copyright: 2018 www.gxhhskj.com Inc. All rights reserved. 
 * 注意：本内容仅限于广西恒河沙科技有限公司内部传阅，禁止外泄以及用于其他的商业目
 */
public class ShotMessageServiceImpl implements IShotMessageService {

	@Override
	public ShotMessageDate sendShotMessage(String mobile) {

		ShotMessageParameter messageParameter = new ShotMessageParameter();

		messageParameter.setUserid(Const.userId);

		String sign = Const.userName + Const.password + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		String md5 = Md5Util.getMD5(sign);
		
		messageParameter.setSign(sign);

		return null;
	}

	public static void main(String[] args) {
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
		String format = simpleDateFormat.format(new Date());
		System.out.println(format);
		System.out.println(DateUtil.dateToStr(new Date(), "yyyyMMddHHmmss"));

	}

}
