package com.gm.service;

import com.gm.base.dto.ShotMessageDate;

/**
 * @author      eagle
 * @date        2018年5月7日
 * @description 处理短信接口
 */
public interface IShotMessageService {
	
	//发送接口
	ShotMessageDate sendShotMessage(String mobile);
	
}
