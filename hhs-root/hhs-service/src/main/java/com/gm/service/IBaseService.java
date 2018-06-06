package com.gm.service;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.gm.base.query.QueryObj;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.springframework.transaction.annotation.Transactional;

import com.gm.base.enums.QueryObjEnum;
import com.gm.base.query.Page;
import com.gm.service.impl.BaseServiceImpl;

@Transactional
public interface IBaseService<T extends Serializable, PK extends Serializable> {
	/**
	 * 新增
	 * 
	 * @param t
	 * @return
	 */
	boolean add(T t);

	/**
	 * 新增，功能和add(T t)一样。
	 * 
	 * @param t
	 * @return {@linkplain #add(Serializable)}
	 */
	boolean save(T t);

	/**
	 * 新增并返回刚新增数据的Id，功能和addReturnId(T t)一样
	 * 
	 * @param t
	 */
	PK saveReturnId(T t);

	/**
	 * 批量插入，循环实现
	 * 
	 * @param list
	 * @return
	 */
	boolean add(List<T> list);
	
	List<PK> addAllReIds(Collection<T> list);

	/**
	 * 批量更新，循环实现
	 * 
	 * @param list
	 * @return
	 */
	void update(String p, Object v,List<PK> list);
	
	/**
	 * 批量更新，循环实现
	 * 
	 * @param list
	 * @return
	 */
	boolean update(List<T> list);
	
	/**
	 * 删除一个实体
	 * 
	 * @param t
	 * @param force
	 *            true：物理删除；false:逻辑删除
	 * @return
	 */
	boolean delete(T t, boolean force);

	/**
	 * 通过Id删除实体
	 * 
	 * @param id
	 * @param force
	 *            true：物理删除；false:逻辑删除
	 * @return
	 */
	boolean deleteById(PK id, boolean force);

	/**
	 * 通过id数组删除实体
	 * 
	 * @param ids
	 * @param force
	 *            true：物理删除；false:逻辑删除
	 * @return
	 */
	boolean deleteByIds(PK[] ids, boolean force);

	/**
	 * 通过id集合删除实体
	 * 
	 * @param ids
	 * @param force
	 *            true：物理删除；false:逻辑删除
	 * @return
	 */
	boolean deleteByIds(List<PK> ids, boolean force);

	/**
	 * 通过属性和属性值删除实体
	 * 
	 * @param p
	 * @param v
	 * @param force
	 *            true：物理删除；false:逻辑删除
	 * @return
	 */
	boolean deleteByParm(String p, Object v, boolean force);

	/**
	 * 通过hql删除 <br>
	 * 要写完整的hql语句，如：delete from 实体名 where ...
	 * 
	 * @param hql
	 * @return
	 */
	boolean deleteByHql(String hql);

	/**
	 * 通过hql删除 <br>
	 * 要写完整的hql语句，如：delete from 表名 where ...
	 * 
	 * @param hql
	 * @return
	 */
	boolean deleteBySql(String sql);

	/**
	 * 更新实体<br>
	 * 注意：此方法会更新所有属性（禁止更新的属性除外）
	 * 
	 * @param t
	 * @return
	 */
	boolean update(T t);

	/**
	 * 通过hql更新<br>
	 * 注意：要写完整的hql语句，如：update 实体名 set..where..
	 * 
	 * @param hql
	 * @return
	 */
	boolean updateByHql(String hql);

	/**
	 * 通过sql更新<br>
	 * 注意：要写完整的sql语句，如：update 表名 set..where..
	 * 
	 * @param sql
	 * @return
	 */
	boolean updateBySql(String sql);

	/**
	 * 通过id更新指定属性的值
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param id
	 *            将要更新实体的id
	 * @return
	 */
	boolean update(String p, Object v, PK id);

	/**
	 * 根据id获取一个实体
	 * 
	 * @param id
	 * @return
	 */
	T get(PK id);

	/**
	 * 根据id获取一个实体，并加锁
	 * 
	 * @param id
	 * @return
	 */
	T getAndLock(PK id);

	/**
	 * 通过hql获取唯一实体<br>
	 * 注：确保数符合此查询条件的数据唯一（即只有一条或null），如果符合条件的数据大于1条将会报异常。
	 * 
	 * @param hql
	 * @return
	 */
	T getOne(String hql);

	T getOne(DetachedCriteria dc);

	/**
	 * 根据属性和属性值获取唯一实体<br>
	 * 注：确保数符合此查询条件的数据唯一（即只有一条或null），如果符合条件的数据大于1条将会报异常。
	 * 
	 * @param hql
	 * @return
	 */
	T getOne(String p, Object v);

	/**
	 * 获取全部实体（不包括删除的）
	 * 
	 * @return
	 */
	List<T> list();

	List<T> list(QueryObj queryObj);

	/**
	 * 投影查询专用获取全部实体（不包括删除的）
	 * 
	 * @return
	 * @param queryObj
	 */
	List<Map<String, Object>> pqList(QueryObj queryObj);

	/**
	 * 获取全部实体（包括删除的）
	 * 
	 * @return
	 */
	List<T> listAll();

	/**
	 * 根据属性和属性值查询
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @return
	 */
	List<T> listEq(String p, Object v);

	/**
	 * 根据属性和属性值分页查询
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param pageIndex
	 *            当前页
	 * @param pageSize
	 *            每页条数
	 * @return
	 */
	List<T> listEq(String p, Object v, Integer pageIndex, Integer pageSize);

	/**
	 * 根据 hql 分页查询
	 * 
	 * @param hql
	 * @param pageIndex
	 * @param pageSize
	 * @return
	 */
	Page<T> list(String hql, Integer pageIndex, Integer pageSize);

	/**
	 * 根据属性和属性值查询n条数据
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param n
	 *            限定数量
	 * @return
	 */
	List<T> listEq(String p, Object v, int n);

	/**
	 * 根据属性值不等查询
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @return
	 */
	List<T> listNotEq(String p, Object v);

	/**
	 * 根据属性值不等查询n条数据
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param n
	 *            限定数量
	 * @return
	 */
	List<T> listNotEq(String p, Object v, Integer n);

	/**
	 * 根据属性和属性值模糊查询
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param matchMode
	 *            匹配模式，可取值如下：<br>
	 *            MatchMode.START：字符串在最前面的位置，相当于 like'key%'<br>
	 *            MatchMode.END：字符串在最后面的位置，相当于 like'%key'<br>
	 *            MatchMode.ANYWHERE：字符串在中间匹配，相当于 like '%key%'<br>
	 *            MatchMode.EXACT：字符串精确匹配，相当于like 'key'<br>
	 * @param ignoreCase是否忽略大小写
	 * @return
	 */
	List<T> listLike(String p, String v, MatchMode matchMode, boolean ignoreCase);

	/**
	 * 根据属性和属性值模糊查询
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param matchMode
	 *            匹配模式，可取值如下：<br>
	 *            MatchMode.START：字符串在最前面的位置，相当于 like'key%'<br>
	 *            MatchMode.END：字符串在最后面的位置，相当于 like'%key'<br>
	 *            MatchMode.ANYWHERE：字符串在中间匹配，相当于 like '%key%'<br>
	 *            MatchMode.EXACT：字符串精确匹配，相当于like 'key'<br>
	 * @param ignoreCase是否忽略大小写
	 * @param size
	 *            条数
	 * @return
	 */
	List<T> listLike(String p, String v, MatchMode matchMode, boolean ignoreCase, Integer size);

	/**
	 * 根据属性和属性值模糊非查询
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param matchMode
	 *            匹配模式，可取值如下：<br>
	 *            MatchMode.START：字符串在最前面的位置，相当于 like'key%'<br>
	 *            MatchMode.END：字符串在最后面的位置，相当于 like'%key'<br>
	 *            MatchMode.ANYWHERE：字符串在中间匹配，相当于 like '%key%'<br>
	 *            MatchMode.EXACT：字符串精确匹配，相当于like 'key'<br>
	 * @param ignoreCase是否忽略大小写
	 * @return
	 */
	List<T> listNotLike(String p, String v, MatchMode matchMode, boolean ignoreCase);

	/**
	 * 查询属性的值在指定字串内所有实体
	 * 
	 * @param p
	 *            属性名
	 * @param inString
	 *            格式：1,2,3
	 * @return
	 */
	List<T> listIn(String p, String inString);

	/**
	 * 查询属性的值在指定数组的内所有实体
	 * 
	 * @param p
	 *            属性名
	 * @param arr
	 *            属性值数组
	 * @return
	 */
	List<T> listIn(String p, Object[] arr);

	/**
	 * 查询属性的值在指定集合的内所有实体
	 * 
	 * @param p
	 *            属性名
	 * @param list
	 *            属性值集合
	 * @return
	 */
	List<T> listIn(String p, List<PK> list);

	/**
	 * 查询属性的值不在指定数组的内所有实体
	 * 
	 * @param p
	 *            属性名
	 * @param arr
	 *            属性值数组
	 * @return
	 */
	List<T> listNotIn(String p, Object[] arr);

	/**
	 * 离线查询
	 * 
	 * @param dc
	 * @return
	 */

	List<T> list(DetachedCriteria dc);

	/**
	 * 查询属性的值不在指定集合的内所有实体
	 * 
	 * @param p
	 *            属性名
	 * @param arr
	 *            属性值数组
	 * @return
	 */
	List<T> listNotIn(String p, List<Object> list);

	/**
	 * 根据hql查询数据<br>
	 * 
	 * @param hql
	 * @return
	 */
	List<T> list(String hql);

	/**
	 * 根据hql查询n条数据
	 * 
	 * @param hql
	 * @param n
	 *            限定数量
	 * @return
	 */
	List<T> list(String hql, int n);

	/**
	 * 离线查询
	 * 
	 * @param dc
	 * @param size
	 *            条数
	 * @return
	 */

	List<T> list(DetachedCriteria dc, Integer size);

	/**
	 * 离线分页查询
	 * 
	 * @param dc
	 * @param pageIndex
	 *            当前页
	 * @param pageSize
	 *            每页条数
	 * @return
	 */

	Page<T> list(DetachedCriteria dc, Integer pageIndex, Integer pageSize);

	/**
	 * 随机取出n条数据
	 * 
	 * @param n
	 * @return
	 */
	List<T> listRam(int n);

	/**
	 * 根据指定属性正序取出n条数据
	 * 
	 * @param p
	 *            要排序的属性名
	 * @param n
	 *            限定数量
	 * @return
	 */
	List<T> listAsc(String p, int n);

	/**
	 * 根据指定属性倒序取出n条数据
	 * 
	 * @param p
	 *            要排序的属性名
	 * @param n
	 *            限定数量
	 * @return
	 */

	List<T> listDesc(String p, int n);

	/**
	 * 取出指定属性为空的数据
	 * 
	 * @param p
	 *            属性名
	 * @return
	 */
	List<T> listIsNull(String p);

	/**
	 * 取出指定属性不为空的数据
	 * 
	 * @param p
	 *            属性名
	 * @return
	 */
	List<T> listNotNull(String p);

	/**
	 * 根据sql查询数据
	 * 
	 * @param sql
	 * @return
	 */
	List listBySql(String sql);

	/**
	 * 统计所有
	 * 
	 * @return
	 */
	Long count();

	/**
	 * 根据属性和属性值统计
	 * 
	 * @param p
	 *            属性
	 * @param v
	 *            属性值
	 * @return
	 */
	Long count(String p, Object v);

	Long count(String hql);

	/**
	 * 根据属性属性值判断数据是否存在
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @return
	 */
	boolean exist(String p, Object v);

	/**
	 * 获取属性值在今天范围内的数据，此属性须为Date类型
	 * 
	 * @param p
	 *            属性名
	 * @return
	 */
	List<T> listToday(String p);

	/**
	 * 获取属性值在今天范围内的n条数据，此属性须为Date类型
	 * 
	 * @param p
	 *            属性名
	 * @param n
	 *            限定条数
	 * @return
	 */
	List<T> listToday(String p, int n);

	/**
	 * 通过sql获取id集合
	 * 
	 * @param sql
	 * @return
	 */
	List<PK> listIdsBySQL(String sql);

	/**
	 * 获取Session
	 * 
	 * @return
	 */
	HttpSession getSession();

	/**
	 * 只取某个字段，sql里面只能包含一个字段
	 * 
	 * @param sql
	 * @return
	 */
	<C> List<C> listFieldBySQL(String sql);

	/**
	 * 检查是否存在
	 * 
	 * @param p
	 *            属性名
	 * @param v
	 *            属性值
	 * @param storeId
	 *            店铺id
	 * @return
	 */
	boolean exist(String p, String v, Integer storeId);

	/**
	 * 根据属性和属性值查询,并根据条件排序
	 * @param p 属性名
	 * @param v 属性值
	 * @param c 条件
	 * @param s 升降序
	 * @return List<T>
	 */
	List<T> listEqDc(String p, Object v, Object c, String s);

}
