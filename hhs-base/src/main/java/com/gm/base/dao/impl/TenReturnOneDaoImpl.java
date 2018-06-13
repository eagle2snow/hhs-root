package com.gm.base.dao.impl;

import org.springframework.stereotype.Repository;

import com.gm.base.dao.ITenReturnOneDao;
import com.gm.base.model.TenReturnOne;
import com.gm.base.dao.impl.BaseDaoImpl;

/**
 * 代码生成器生成代码<br/>
 * TenReturnOneDaoImpl
 * @author guet
 *
 */

@Repository
public class TenReturnOneDaoImpl extends BaseDaoImpl<TenReturnOne, Integer> implements ITenReturnOneDao {

	@Override
	public TenReturnOne selectTime(Integer id) {
		return getOne("SELECT MAX(time) FROM t_ten_return_one WHERE this_time_commodity_id = "+id);
	}

	@Override
	public TenReturnOne selectTenTime(Integer id) {
		return getOne("SELECT MAX(ten_time) FROM t_ten_return_one WHERE this_time_commodity_id = "+id);
		
	}

	@Override
	public TenReturnOne selectOneMember(Integer id, int tentime) {
		int mun = tentime - 1;
		return getOne("SELECT id,this_time_member_id FROM t_ten_return_one WHERE this_time_commodity_id="+id+"  ORDER BY id ASC LIMIT "+mun+",1");
		
	}

}