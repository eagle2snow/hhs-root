package com.gm.service.impl;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.dao.IBaseDao;
import com.gm.base.enums.QueryObjEnum;
import com.gm.base.query.ConObj;
import com.gm.base.query.Page;
import com.gm.base.query.QueryObj;
import com.gm.service.IBaseService;

@Transactional
public abstract class BaseServiceImpl<T extends Serializable, PK extends Serializable> implements IBaseService<T, PK> {

	@Autowired
	private QueryObj queryObj;

	@Autowired
	private ConObj conObj;

	private boolean query = false;

	public abstract IBaseDao<T, PK> getDao();

	// 链式调用
	@Override
	public BaseServiceImpl<T, PK> eq(String p, Object v) {
		// this.eqMap.put(p, v);
		queryObj.setEqMap(p, v);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> ne(String p, Object v) {
		queryObj.setNeMap(p, v);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> lt(String p, Object v) {
		queryObj.setLtMap(p, v);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> le(String p, Object v) {
		queryObj.setLeMap(p, v);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> gt(String p, Object v) {
		queryObj.setGtMap(p, v);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> ge(String p, Object v) {
		queryObj.setGeMap(p, v);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> bt(String p, Object start, Object end) {
		conObj.setStart(start);
		conObj.setEnd(end);
		queryObj.setBtMap(p, conObj);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> lk(String p, Object v) {
		queryObj.setLkMap(p, v);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> pq(String s) {
		queryObj.setReList(s);
		return this;
	}

	@Override
	public BaseServiceImpl<T, PK> sort(String p,QueryObjEnum v) {
		queryObj.setSortMap(p, v);
		return this;
	}

	@Override
	public boolean add(T t) {
		if (t == null) {
			return false;
		}
		return getDao().add(t);
	}

	@Override
	public boolean save(T t) {
		if (null == t) {
			return false;
		}
		return getDao().save(t);
	}
	
	public List<PK> addAllReIds(Collection<T> list){
		return getDao().addAllReIds(list);
	}

	@Override
	public PK saveReturnId(T t) {
		if (null == t) {
			return null;
		}
		return getDao().saveReturnId(t);
	}

	@Override
	public boolean delete(T t, boolean force) {
		return getDao().delete(t, force);
	}

	@Override
	public boolean deleteById(PK id, boolean force) {
		return getDao().deleteById(id, force);
	}

	@Override
	public boolean deleteByIds(PK[] ids, boolean force) {
		return getDao().deleteByIds(ids, force);
	}

	@Override
	public boolean deleteByParm(String p, Object v, boolean force) {
		return getDao().deleteByPV(p, v, force);
	}

	@Override
	public boolean update(T t) {
		return getDao().update(t);
	}

	@Override
	public boolean deleteByIds(List<PK> ids, boolean force) {
		if (ids == null || ids.size() <= 0) {
			return false;
		}
		return getDao().deleteByIds(ids, force);

	}

	@Override
	public T get(PK id) {
		return getDao().get(id);
	}

	@Override
	public T getOne(String hql) {
		return getDao().getOne(hql);
	}

	@Override
	public T getOne(DetachedCriteria dc) {
		return getDao().getOne(dc);
	}

	@Override
	public T getOne(String p, Object v) {
		return getDao().getOne(p, v);
	}

	@Override
	public List<T> list(DetachedCriteria dc) {
		return getDao().list(dc);
	}

	@Override
	public List<T> list()
	{
		return getDao().list();
	}

	@Override
	public List<Map<String, Object>> pqList(QueryObj queryObj)
	{
		List<String> selectedFields = queryObj.getReList();
		if (selectedFields.size() == 1)
			return pqListQueryObjReSizeEqOne(queryObj, selectedFields);
		List<Object[]> list = getDao().list(queryObj);
		List<Map<String, Object>> listMap = new ArrayList<>();
		list.forEach(os -> {
			Map<String, Object> map = new HashMap<>();
			for (int i = 0; i < selectedFields.size(); i++)
				map.put(selectedFields.get(i).replace(".", "_"), os[i]);
			listMap.add(map);
		});
		return listMap;
	}

	private List<Map<String, Object>> pqListQueryObjReSizeEqOne(QueryObj queryObj, List<String> selectedFields)
	{
		List<Map<String, Object>> results = new ArrayList<>();
		List<Object> list = getDao().list(queryObj);
		list.forEach(one -> {
			Map<String, Object> map = new HashMap<>();
			for (int i = 0; i < selectedFields.size(); ++i)
				map.put(selectedFields.get(i).replace(".", "_"), one);
			results.add(map);
		});
		return results;
	}

	@Override
	public List<T> listAll() {
		return getDao().listAll();
	}

	@Override
	public List<T> list(Integer n) {
		if (query) {
			List<T> list = getDao().list(queryObj, n);
			query = false;
			return list;
		}
		return getDao().list(n);
	}

	@Override
	public List<T> listEq(String p, Object v) {
		return getDao().listEq(p, v);
	}
	
	@Override
	public List<T> listEqDc(String p, Object v,Object c,String s) {
		return getDao().listEqDc(p, v, c, s);
	}

	@Override
	public List<T> listEq(String p, Object v, int n) {
		return getDao().listEq(p, v, n);
	}

	@Override
	public List<T> list(String hql) {
		return getDao().listByHQL(hql);
	}

	@Override
	public List<T> list(String hql, int n) {
		return getDao().listByHQL(hql, n);
	}

	@Override
	public Page<T> list(DetachedCriteria dc, Integer pageIndex, Integer pageSize) {
		Integer count = getDao().count(dc);
		if (count > 0) {
			List<T> list = getDao().list(dc, pageIndex, pageSize);
			return new Page<T>(pageIndex, pageSize, count, list);
		}
		return new Page<T>(pageIndex, pageSize, count, null);
	}

	@Override
	public Long count() {
		return getDao().count();
	}

	@Override
	public boolean exist(String p, Object v) {
		return getDao().exist(p, v);
	}

	@Override
	public List<T> listNotEq(String p, Object v) {
		return getDao().listNotEq(p, v);
	}

	@Override
	public List<T> listLike(String p, String v, MatchMode matchMode, boolean ignoreCase) {
		return getDao().listLike(p, v, matchMode, ignoreCase);
	}

	@Override
	public List<T> listNotLike(String p, String v, MatchMode matchMode, boolean ignoreCase) {
		return getDao().listNoLike(p, v, matchMode, ignoreCase);
	}

	@Override
	public List<T> listIn(String p, Object[] arr) {
		return getDao().listIn(p, arr);
	}

	@Override
	public List<T> listNotIn(String p, Object[] arr) {
		return getDao().listNotIn(p, arr);
	}

	@Override
	public List<T> listRam(int n) {
		return getDao().listRam(n);
	}

	@Override
	public List<T> listEq(String p, Object v, Integer pageIndex, Integer pageSize) {
		return getDao().listEq(p, v, pageIndex, pageSize);
	}

	@Override
	public Long count(String p, Object v) {
		return getDao().count(p, v);
	}

	@Override
	public Long count(String hql) {
		return getDao().countByHQL(hql);
	}

	@Override
	public List<T> listToday(String p, int n) {
		return getDao().listToday(p, n);
	}
	
	@Override
	public void update(String p, Object v,List<PK> list) {
		getDao().update(p, v, list);
	}

	@Override
	public boolean update(List<T> list) {
		return getDao().update(list);
	}
	
	@Override
	public boolean update(String p, Object v, PK id) {
		return getDao().updatePropById(p, v, id);
	}

	@Override
	public boolean add(List<T> list) {
		return getDao().addAll(list);
	}

	@Override
	public boolean updateBySql(String sql) {
		return getDao().updateBySql(sql);
	}

	@Override
	public boolean updateByHql(String hql) {
		return getDao().updateByHql(hql);
	}

	@Override
	public HttpSession getSession() {
		return null;
	}

	@Override
	public boolean deleteBySql(String hql) {
		return getDao().deleteBySql(hql);
	}

	@Override
	public boolean deleteByHql(String hql) {
		return getDao().deleteByHql(hql);
	}

	@Override
	public List<PK> listIdsBySQL(String sql) {
		return getDao().listIdsBySQL(sql);
	}

	@Override
	public List<T> listIsNull(String p) {
		return getDao().listIsNull(p);
	}

	@Override
	public List<T> listNotNull(String p) {
		return getDao().listIsNotNull(p);
	}

	@Override
	public List<T> listIn(String p, List<PK> list) {
		if (null == list || list.size() == 0) {
			return new ArrayList<T>();
		}
		return getDao().listIn(p, list);
	}

	@Override
	public T getAndLock(PK id) {
		return getDao().getAndLock(id);
	}

	@Override
	public List<T> listNotEq(String p, Object v, Integer n) {
		return getDao().listNotEq(p, v, n);
	}

	@Override
	public List<T> listNotIn(String p, List<Object> list) {
		return getDao().listNotIn(p, list);
	}

	@Override
	public List<T> listAsc(String p, int n) {
		return getDao().listAsc(p, n);
	}

	@Override
	public List<T> listDesc(String p, int n) {
		return getDao().listDesc(p, n);
	}

	@Override
	public List<T> listToday(String p) {
		return getDao().listToday(p);
	}

	@Override
	public List<T> listIn(String p, String inString) {
		return getDao().listIn(p, inString);
	}

	@Override
	public <C> List<C> listFieldBySQL(String sql) {

		return getDao().listFieldBySQL(sql);
	}

	@Override
	public List<T> listLike(String p, String v, MatchMode matchMode, boolean ignoreCase, Integer size) {
		return getDao().listLike(p, v, matchMode, ignoreCase, size);
	}

	@Override
	public List<T> list(DetachedCriteria dc, Integer size) {
		return getDao().list(dc, size);
	}

	@Override
	public List listBySql(String sql) {
		return getDao().listBySQL(sql);
	}

	@Override
	public Page<T> list(String hql, Integer pageIndex, Integer pageSize) {
		List<T> list = getDao().list(hql, pageIndex, pageSize);
		return new Page<T>(pageIndex, pageSize, list.size(), list);
	}

	@Override
	public boolean exist(String p, String v, Integer storeId) {
		return getDao().exist(p, v, storeId);
	}

}