package com.gm.base.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.springframework.data.jpa.repository.JpaRepository;

import com.gm.base.query.QueryObj;

/**
 * 
 * 基类Dao层接口
 * 
 * @author Administrator
 *
 * @param <T>
 * @param <ID>
 */
public interface IBaseDao<T extends Serializable, ID extends Serializable> {

	boolean save(T entity);

	/**
	 * 存储实体到数据库，保存成功后返回刚保存实体Id<br>
	 * 功能和addReturnId(T entity)
	 * 
	 * @param entity
	 * @return Integer
	 * @see #addReturnId(Serializable)
	 */
	ID saveReturnId(T entity);

	/**
	 * 存储实体到数据库，存储实体到数据库，功能和save(T entity)一样
	 *
	 * @param entity
	 * @return boolean
	 * @see #save(Serializable)
	 */
	boolean add(T entity);

	/**
	 * 存储实体到数据库，保存成功后返回刚保存实体Id <br>
	 * 功能和saveReturnId(T entity)一样
	 *
	 * @param entity
	 * @return 添加实体的ID
	 * @see #saveReturnId(Serializable)
	 */
	ID addReturnId(T entity);

	/**
	 * 批量添加，循环实现
	 * 
	 * @param list
	 * @return boolean
	 */
	boolean addAll(Collection<T> list);

	/**
	 * 批量添加，循环实现
	 * 
	 * @param list
	 * @return ids
	 */
	List<ID> addAllReIds(Collection<T> list);

	/**
	 * 批量添加，循环实现
	 * 
	 * @param list
	 * @return boolean
	 */
	boolean saveAll(Collection<T> list);

	/**
	 * 根据给定ID数组删除实体
	 *
	 * @param ids
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return
	 */
	boolean deleteByIds(ID[] ids, boolean force);

	/**
	 * 删除指定的实体
	 *
	 * @param entity
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return boolean
	 */
	boolean delete(T entity, boolean force);

	/**
	 * 根据主键删除指定实体<br />
	 * 主键为Integer类型
	 *
	 * @param id
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return boolean
	 */
	boolean deleteById(ID id, boolean force);

	/**
	 * 根据属性值删除
	 * 
	 * @author hekin
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return boolean
	 **/
	boolean deleteByPV(String p, Object v, boolean force);

	/**
	 * 根据属性in删除
	 * 
	 * @param p
	 * @param arr
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return
	 */
	boolean deleteByIn(String p, Object[] arr, boolean force);

	/**
	 * 根据属性in删除
	 * 
	 * @param p
	 * @param arr
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return
	 */
	boolean deleteByIn(String p, List<Object> arr, boolean force);

	/**
	 * 根据集合删除
	 * 
	 * @param ids
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return
	 */
	boolean deleteByIds(List<ID> ids, boolean force);

	/**
	 * 删除集合中的全部实体
	 *
	 * @param entities
	 * @param force
	 *            若为true则强制删除 ，否则虚拟删除
	 * @return boolean
	 */
	boolean deleteAll(Collection<T> entities, boolean force);

	/**
	 * 通过sql删除
	 * 
	 * @param sql
	 * @return
	 */
	boolean deleteBySql(String sql);

	/**
	 * 通过hql删除
	 * 
	 * @param hql
	 * @return
	 */
	boolean deleteByHql(String hql);

	/**
	 * 更新实体，和renew(T entity)功能一样，名称不同而已
	 *
	 * @param entity
	 * @return boolean
	 * @see #renew(Serializable)
	 */
	boolean update(T entity);
	
	/**
	 * 根据sql更新返回更新条数
	 *
	 * @param entity
	 * @return boolean
	 * @see #renew(Serializable)
	 */
	Integer updateBySqlReSize(String sql);

	/**
	 * 根据hql更新，功能和renewByHql(String hql)一样，名称不同
	 * 
	 * @param hql
	 * @return boolean
	 * @see #renewByHql(String)
	 */
	boolean updateByHql(String hql);

	/**
	 * 根据sql更新，功能和renewBySql(String sql)一样，名称不同
	 * 
	 * @param sql
	 * @return boolean
	 * @see #renewBySql(String)
	 */
	boolean updateBySql(String sql);

	/**
	 * 根据id更新实体的指定属性
	 * 
	 * @param id
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @return boolean
	 * @see #renewPropById(String, Object,Serializable)
	 */
	boolean updatePropById(String p, Object v, ID id);

	/**
	 * 更新实体，和update(T entity)功能一样，名称不同而已
	 * 
	 * @param t
	 * @return
	 * @see IBaseDao#update(Serializable)
	 * 
	 */
	boolean renew(T t);

	/**
	 * 通过Hql更新
	 * 
	 * @param hql
	 * @return boolean
	 * @see
	 */
	boolean renewByHql(String hql);

	/**
	 * 通过Hql更新实体
	 * 
	 * @param sql
	 * @return boolean
	 * @see #updateBySql(String)
	 */
	boolean renewBySql(String sql);

	/**
	 * 根据id更新某一属性的值
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param id
	 * @return boolean
	 * 
	 *         {@linkplain #updatePropById(String, Object,Serializable)}
	 */
	boolean renewPropById(String p, Object v, ID id);

	/**
	 * 根据id集合批量更新
	 * 
	 * @param p
	 *            要更新的属性
	 * @param v
	 *            要更新的属性值
	 * @param ids
	 *            集合
	 */
	void update(String p, Object v, List<ID> ids);
	
	/**
	 * 批量更新
	 * @param list
	 * @return
	 */
	boolean update(List<T> list);

	/**
	 * 将属性pp的值在ppv范围内的所有对象的属性的值p更新为v
	 * 
	 * @param p
	 *            将要更新的属性
	 * @param v
	 *            将要更新的属性值
	 * @param pp
	 *            限定属性
	 * @param arr
	 *            限定属性值
	 */
	void updateByIn(String p, Object v, String pp, Object[] arr);

	/**
	 * 将属性pp的值在list范围内的所有对象的属性的值p更新为v
	 * 
	 * @param p
	 *            将要更新的属性
	 * @param v
	 *            将要更新的属性值
	 * @param pp
	 *            限定属性
	 * @param list
	 *            限定属性值
	 */
	void updateByIn(String p, int v, String pp, List<Object> list);

	/**
	 * 根据主键获取实体。如果没有相应的实体，返回 null。
	 *
	 * @param id
	 * @return T
	 */
	T get(ID id);

	/**
	 * 根据主键获取实体。如果没有相应的实体，抛出异常。
	 *
	 * @param id
	 * @return T
	 */
	T load(ID id);

	/**
	 * 根据hql取出一个实体，不存在返回null
	 * 
	 * @param hql
	 * @return
	 */
	T getOne(String hql);

	/**
	 * * 根据属性p和属性值v取出一个实体，不存在返回null
	 * 
	 * @param p
	 * @param v
	 * @return
	 */
	T getOne(String p, Object v);

	/**
	 * 根据id取出一个实体并加锁，不存在返回null
	 * 
	 * @param id
	 * @return
	 */
	T getAndLock(ID id);

	/**
	 * 获取n个实体，默认按id倒序排序
	 *
	 * @return List<T>
	 */
	List<T> list(Integer size);

	/**
	 * 获取全部实体（包括删除的），默认按id倒序排序
	 *
	 * @return List<T>
	 */
	List<T> listAll();

	/**
	 * 获取全部实体，并按指定属性正序排序
	 * 
	 * @param 属性名
	 * @return List<T>
	 */
	List<T> listAllAsc(String p);

	/**
	 * 获取全部实体，并按指定属性倒序排序
	 * 
	 * @param 属性名
	 * @return List<T>
	 */
	List<T> listAllDesc(String p);

	/**
	 * 使用HQL语句查询数据
	 *
	 * @param HQL
	 * @return List<T>
	 */
	List<T> listByHQL(String hql);

	/**
	 * 使用HQL语句查询n条数据
	 *
	 * @param HQL
	 * @return List<T>
	 */
	List<T> listByHQL(String hql, Integer size);

	/**
	 * 使用带参数的HQL语句查询数据
	 *
	 * @param HQL
	 * @param values
	 * @return List<T>
	 */
	List<T> listByHQL(String hql, Object[] values);

	/**
	 * 根据给定属性与属性值查询实体
	 *
	 * @param p
	 * @param v
	 * @return List<T>
	 */
	List<T> listEq(String p, Object v);
	
	
	/**
	 * 根据给定属性与属性值查询N条数据
	 * 
	 * @param p
	 * @param v
	 * @param n
	 * @return List<T>
	 */
	List<T> listEq(String p, Object v, Integer n);

	/**
	 * 根据给定属性与属性值和token查询实体
	 * 
	 * @param p
	 * @return List<T>
	 */
	List<T> listEq(String p, Object v, String token);

	/**
	 * 根据给定属性与属性值和token查询N条数据
	 * 
	 * @param p
	 * @param v
	 * @param n
	 * @param token
	 * @return List<T>
	 */
	List<T> listEq(String p, Object v, Integer n, String token);

	/**
	 * 根据给定属性与属性值和查询N条数据
	 * 
	 * @param p
	 * @param v
	 * @param n
	 * @param token
	 * @return List<T>
	 */
	List<T> listEq(String p, Object v, Integer pageIndex, Integer pageSize);

	/**
	 * 根据给定属性与属性值和token查询N条数据
	 * 
	 * @param p
	 * @param v
	 * @param n
	 * @param token
	 * @return List<T>
	 */
	List<T> listEq(String p, Object v, Integer pageIndex, Integer pageSize, String token);

	/**
	 * 根据给定属性与属性值 进行Like 查询数据
	 *
	 * @param p
	 * @param v
	 * @param matchMode
	 * @param ignoreCase
	 * @return List<T>
	 */
	List<T> listLike(String p, String v, MatchMode matchMode, boolean ignoreCase);

	/**
	 * 根据给定属性与属性值 进行Like 查询数据
	 * 
	 * @param p
	 * @param v
	 * @param ignoreCase
	 * @param token
	 * @return
	 */
	List<T> listLike(String p, String v, MatchMode matchMode, boolean ignoreCase, String token);

	/**
	 * 根据给定属性与属性值 进行非Like 查询数据
	 * 
	 * @param p
	 * @param v
	 * @param matchMode
	 * @param ignoreCase
	 * @return
	 */
	List<T> listNoLike(String p, String v, MatchMode matchMode, boolean ignoreCase);

	/**
	 * 根据给定属性与属性值 进行非Like 查询数据，带token
	 * 
	 * @param p
	 * @param v
	 * @param matchMode
	 * @param ignoreCase
	 * @param token
	 * @return
	 */
	List<T> listNoLike(String p, String v, MatchMode matchMode, boolean ignoreCase, String token);

	/**
	 * 根据给定属性与属性值 Like 查询N条数据
	 * 
	 * @param p
	 * @param v
	 * @param n
	 * @return List<T>
	 */
	List<T> listLike(String p, String v, Integer n);

	/**
	 * 根据给定属性与属性值 和token 进行Like 查询数据
	 * 
	 * @param p
	 * @param v
	 * @param n
	 * @param token
	 * @return List<T>
	 */
	List<T> listLike(String p, String v, Integer n, String token);

	/**
	 * 根据属性名正序排序，再取出N条记录
	 * 
	 * @param p
	 *            属性名
	 * @param size
	 *            数目
	 * @return List<T>
	 */
	List<T> listAsc(String p, Integer size);

	/**
	 * 根据属性名正序排序，再取出N条记录
	 * 
	 * @param p
	 *            属性名
	 * @param size
	 *            数目
	 * @return List<T>
	 */
	List<T> listDesc(String p, Integer size);

	/**
	 * 根据属性名正序排序，再根据token取出N条记录
	 * 
	 * @param p
	 * @param size
	 * @param token
	 * @return List<T>
	 */
	List<T> listAsc(String p, Integer size, String token);

	/**
	 * 根据属性名倒序排序，再根据token取出N条记录
	 * 
	 * @param p
	 * @param size
	 * @param token
	 * @return List<T>
	 */
	List<T> listDesc(String p, Integer size, String token);

	/**
	 * 离线查询
	 * 
	 * @param dc
	 * @return
	 */
	List<T> list(DetachedCriteria dc);

	/**
	 * 离线查询，带token
	 * 
	 * @param dc
	 * @param token
	 * @return
	 */
	List<T> list(DetachedCriteria dc, String token);

	/**
	 * 离线分页查询
	 * 
	 * @param dc
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	List<T> list(DetachedCriteria dc, Integer pageIndex, Integer pageSize);

	/**
	 * 离线查询，带token
	 * 
	 * @param cr
	 * @return
	 */
	List<T> list(DetachedCriteria dc, Integer pageIndex, Integer pageSize, String token);

	/**
	 * 随机取出n条
	 * 
	 * @param n
	 * @return
	 */
	List<T> listRam(Integer n);

	/**
	 * 获取某个时间属性在今天范围内所有数据
	 * 
	 * @param p
	 * @param n
	 * @return
	 */
	List<T> listToday(String p);

	/**
	 * 获取某个时间属性在今天范围内的前n条数据
	 * 
	 * @param p
	 * @param n
	 * @return
	 */
	List<T> listToday(String p, Integer n);

	/**
	 * 获取某个时间属性在今天范围内所有数据，带token
	 * 
	 * @param p
	 * @param token
	 * @return
	 */
	List<T> listToday(String p, String token);

	/**
	 * 获取某个时间属性在今天范围内n条数据，带token
	 * 
	 * @param p
	 * @param token
	 * @return
	 */
	List<T> listToday(String p, Integer n, String token);

	/**
	 * 
	 * @param p
	 * @param v
	 * @param token
	 * @return
	 */
	List<T> listNoLike(String p, String v);

	/**
	 * 根据token 取出 属性p不等于v的实体
	 * 
	 * @param p
	 * @param v
	 * @param token
	 * @return
	 */
	List<T> listNotEq(String p, Object v);

	/**
	 * 根据token 取出 属性p不等于v的n个实体
	 * 
	 * @param p
	 * @param v
	 * @param n
	 * @return
	 */
	List<T> listNotEq(String p, Object v, Integer n);

	/**
	 * 根据token 取出 属性p不等于v的实体，带token
	 * 
	 * @param p
	 * @param v
	 * @param token
	 * @return
	 */
	List<T> listNotEq(String p, Object v, String token);

	/**
	 * 查询所有属性p的值包含在集合list的所有数据
	 * 
	 * @param p
	 * @param list
	 * @return
	 */
	List<T> listIn(String p, List<ID> list);

	/**
	 * 查询所有属性p的值包含在value的所有数据
	 * 
	 * @param p
	 * @param value
	 *            格式：1,2,3,4
	 * @return
	 */
	List<T> listIn(String p, String value);

	/**
	 * 查询所有属性p的值包含在集合list的所有数据，带token
	 * 
	 * @param p
	 * @param list
	 * @param token
	 * @return
	 */
	List<T> listIn(String p, List<ID> list, String token);

	/**
	 * 查询所有属性p的值包含在数组 arr的所有数据
	 * 
	 * @param p
	 * @param arr
	 * @param token
	 * @return
	 */
	List<T> listIn(String p, Object[] arr);

	/**
	 * 查询所有属性p的值包含在数组 arr的所有数据
	 * 
	 * @param p
	 * @param arr
	 * @param token
	 * @return
	 */
	List<T> listIn(String p, Object[] arr, String token);

	/**
	 * 查询所有属性p的值不包含在集合list的所有数据
	 * 
	 * @param p
	 * @param arr
	 * @param token
	 * @return
	 */
	List<T> listNotIn(String p, List<Object> list);

	/**
	 * 查询所有属性p的值不包含在集合list的所有数据，带token
	 * 
	 * @param p
	 * @param arr
	 * @param token
	 * @return
	 */
	List<T> listNotIn(String p, List<Object> list, String token);

	/**
	 * 根据token取出 p的值不在数组arr的实体
	 * 
	 * @param p
	 * @param arr
	 * @param token
	 * @return
	 */
	List<T> listNotIn(String p, Object[] arr);

	/**
	 * 分页查询属性p的值不包含在集合list的所有数据，带token
	 * 
	 * @param p
	 * @param list
	 * @param pageIndex
	 * @param pageSize
	 * @param token
	 * @return
	 */
	List<T> listNotIn(String p, List<Object> list, Integer pageIndex, Integer pageSize, String token);

	/**
	 * 根据token取出 p的值不在数组arr的实体，带token
	 * 
	 * @param p
	 * @param arr
	 * @param token
	 * @return
	 */
	List<T> listNotIn(String p, Object[] arr, String token);

	/**
	 * 根据sql查询id集合
	 * 
	 * @param sql
	 * @return
	 */
	List<ID> listIdsBySQL(String sql);

	/**
	 * 根据hql查询
	 * 
	 * @param hql
	 * @param token
	 * @return
	 */
	List<T> listByHQL(String hql, String token);

	/**
	 * 根据hql查询n条
	 * 
	 * @param hql
	 * @param n
	 * @param token
	 * @return
	 */
	List<T> listByHQL(String hql, Integer n, String token);

	/**
	 * 随机取出N条
	 * 
	 * @param n
	 * @param token
	 * @return
	 */
	List<T> listRam(Integer n, String token);

	/**
	 * 取出属性p为null查询
	 * 
	 * @param p
	 * @return
	 */
	List<T> listIsNull(String p);

	/**
	 * 取出 属性p为nul的实体，带token
	 * 
	 * @param p
	 * @param token
	 * @return
	 */
	List<T> listIsNull(String p, String token);

	/**
	 * 取出属性p不为null实体
	 * 
	 * @param p
	 * @return
	 */
	List<T> listIsNotNull(String p);

	/**
	 * 取出 p的值不为null的实体，带token
	 * 
	 * @param p
	 * @param token
	 * @return
	 */
	List<T> listIsNotNull(String p, String token);

	List<T> list(QueryObj queryObj);

	List<T> list(QueryObj qeuryObj, Integer n);

	/**
	 * 根据属性和属性值判断实体是否存在
	 * 
	 * @param p
	 * @param v
	 * @return
	 */
	boolean exist(String p, Object v);

	/**
	 * 根据属性和属性值判断实体是否存在，带token
	 * 
	 * @param p
	 * @param v
	 * @param token
	 * @return
	 */
	boolean exist(String p, Object v, String token);

	/**
	 * 根据属性和属性值统计实体的数量
	 *
	 * @param p
	 * @param v
	 * @return Integer
	 */
	Long count(String p, Object v);


	/**
	 * 统计（模糊查询）
	 *
	 * @param p
	 * @param v
	 * @return
	 */
	Integer countByLike(String p, String v);


	/**
	 * 根据hql统计
	 * 
	 * @param hql
	 * @param token
	 * @return
	 */
	Long countByHQL(String hql);

	
	/**
	 * 根据hql统计
	 * 
	 * @param sql
	 * @param token
	 * @return
	 */
	Long countBySQL(String sql);

	/**
	 * 离线统计
	 * 
	 * @param dc
	 * @return
	 */
	Integer count(DetachedCriteria dc);


	void clear();

	/**
	 * 强制初始化指定的实体
	 *
	 * @param proxy
	 */
	void initialize(Object proxy);

	/**
	 * 强制立即更新缓冲数据到数据库（否则仅在事务提交时才更新）
	 */
	void flush();

	/**
	 * 全部取出（不包括删除的）
	 * 
	 * @return
	 */
	List<T> list();

	/**
	 * 根据SQL获取某个字段列表
	 * 
	 * @param sql
	 * @return
	 */
	<C> List<C> listFieldBySQL(String sql);

	List<T> listLike(String p, String v, MatchMode matchMode, boolean ignoreCase, Integer size);

	List<T> list(DetachedCriteria dc, Integer size);

	List listBySQL(String sql);

	List<T> list(String hql, Integer pageIndex, Integer pageSize);

	boolean exist(String p, String v, Integer storeId);

	/**
	 * 获取指定数据集
	 * 
	 * @param p
	 *            (p1,p2....pN)
	 * @return
	 */
	List<T> relist(String p);

	/**
	 * 根据条件返回指定数据集
	 * 
	 * @param p
	 *            (p1,p2.id,...,pN)
	 * @return
	 */
	List<T> reAndCtlist(String p, DetachedCriteria detachedCriteria);

	long count();

	T getOne(DetachedCriteria dc);

	/**
	 * 根据给定属性与属性值查询实体,并根据条件排序
	 * @param p 属性名
	 * @param v 属性值
	 * @param c 条件
	 * @param s 升降序
	 * @return List<T>
	 */
	List<T> listEqDc(String p, Object v, Object c,String s);

}