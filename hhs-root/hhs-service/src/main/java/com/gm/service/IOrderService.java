package com.gm.service;

import java.util.List;
import java.util.Map;

import com.gm.base.dto.CartDto;
import com.gm.base.dto.OrderItemDto;
import com.gm.base.model.Member;
import com.gm.base.model.Order;
import com.gm.base.model.PayBill;

/**
 * 代码生成器生成代码<br/>
 * IOrderService
 * 
 * @author guet
 *
 */
public interface IOrderService extends IBaseService<Order, Integer> {

	/**
	 * 生成订单
	 * 
	 * <p>
	 * Title: genOrder
	 * </p>
	 * 
	 * <p>
	 * Description:生成订单。如果所有的商品库存都充足，则成功生成，否则生成失败，并且返回库存不足购物车项id和此商品的现有库存
	 * </p>
	 * 
	 * @param member
	 * @param carts
	 * @return
	 */
	Map<String, Object> genOrder(Member member, List<CartDto> carts);

	Map<String, Object> prePayOrder(Member member, Integer orderId, Integer addressId, List<OrderItemDto> items,
			String content);

	/**
	
	* <p>描述: </p>  
	
	* @author 灰灰  
	
	* @date 2018年5月4日  
	
	* @version 1.0
	 */
	void payOrderSuccess(String orderNo, PayBill payBill);

	/**
	 * @Title: confirmGoods   
	 * @Description: 确认收货      
	 * @return: void      
	 * @throws
	 */
	void confirmGoods(Integer orderId);

}