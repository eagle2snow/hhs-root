package com.gm.base.dao.impl;

import java.util.List;

import org.hibernate.query.NativeQuery;
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
	public Integer selectTime(Integer id) {
		NativeQuery<Integer> createNativeQuery = getSession().createNativeQuery("SELECT MAX(time) FROM t_ten_return_one WHERE this_time_commodity_id = "+id);
		List<Integer> resultList = createNativeQuery.getResultList();
		return resultList .get(0);
		/*return getOne("SELECT MAX(time) FROM t_ten_return_one WHERE this_time_commodity_id = "+id);*/
	}

	@Override
	public Integer selectTenTime(Integer id) {
		NativeQuery<Integer> createNativeQuery = getSession().createNativeQuery("SELECT MAX(ten_time) FROM t_ten_return_one WHERE this_time_commodity_id = "+id);
		List<Integer> resultList = createNativeQuery.getResultList();
		return resultList .get(0);
		/*return getOne("SELECT MAX(ten_time) FROM t_ten_return_one WHERE this_time_commodity_id = "+id);*/
	}

	@Override
	public Integer selectOneMember(Integer id, int tentime) {
		int mun = tentime - 1;
		NativeQuery<Integer> createNativeQuery = getSession().createNativeQuery("SELECT this_time_member_id FROM t_ten_return_one WHERE this_time_commodity_id="+id+"  ORDER BY id ASC LIMIT "+mun+",1");
		List<Integer> resultList = createNativeQuery.getResultList();
		return resultList .get(0);
		/*return getOne("SELECT this_time_member_id FROM t_ten_return_one WHERE this_time_commodity_id="+id+"  ORDER BY id ASC LIMIT "+mun+",1");*/
	}

}