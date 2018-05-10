package com.gm.service;

import com.gm.service.IBaseService;
import com.gm.base.model.Cart;

/**
 * 代码生成器生成代码<br/>
 * ICartService
 * 
 * @author guet
 *
 */
public interface ICartService extends IBaseService<Cart, Integer> {

	/**
	 * 判断购物车是否存在此商品
	 * 
	 * <p>
	 * Title: existCommodity
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param memberId
	 *            会员id
	 * @param commodityId
	 *            商品id
	 * @return
	 */
	boolean existCommodity(Integer memberId, Integer commodityId);

	/**
	 * 
	 * 判断购物车是否存在此商品 ，有的话返回此实体，否则返回null
	 * <p>
	 * Title: checkCommodityInCart
	 * </p>
	 * 
	 * <p>
	 * Description:
	 * </p>
	 * 
	 * @param memberId
	 * @param commodityId
	 * @return
	 */
	Cart checkCommodityInCart(Integer memberId, Integer commodityId);

}