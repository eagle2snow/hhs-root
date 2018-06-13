package com.gm.base.dao;

import com.gm.base.dao.IBaseDao;
import com.gm.base.model.TenReturnOne;


/**
 * 代码生成器生成代码<br/>
 * ITenReturnOneDao
 * @author guet
 *
 */
public interface ITenReturnOneDao extends IBaseDao<TenReturnOne, Integer> {

	/**
	 * 查询购买次数
	 * @param id
	 * @return
	 */
	TenReturnOne selectTime(Integer id);
	/**
	 * 查询返还次数
	 * @param id
	 * @return 
	 */
	TenReturnOne selectTenTime(Integer id);
	/**
	 * 查询十返一会员
	 * @param id
	 * @param tentime
	 * @return 
	 */
	TenReturnOne selectOneMember(Integer id, int tentime);

}