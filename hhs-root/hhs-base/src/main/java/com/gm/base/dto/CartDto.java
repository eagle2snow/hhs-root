package com.gm.base.dto;

/**
 * 
 * <p>
 * Title: CartDto
 * </p>
 * 
 * <p>
 * Description: 购物车结算对象
 * </p>
 * 
 * @author 灰灰
 * 
 * @date 2018年4月24日
 */
public class CartDto {
	private Integer id;
	private Integer buyCount;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getBuyCount() {
		return buyCount;
	}

	public void setBuyCount(Integer buyCount) {
		this.buyCount = buyCount;
	}

}
