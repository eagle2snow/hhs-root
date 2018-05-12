package com.gm.base.model;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.alibaba.fastjson.annotation.JSONField;
import com.gm.gencode.annotation.FormField;
import com.gm.gencode.annotation.M;
import com.gm.gencode.util.FieldType;

@M("会员评价")
@SuppressWarnings("serial")
@Entity(name = "commodityAppraise")
@Table(name = "t_commodity_appraise")
public class CommodityAppraise extends Model {
	
	private CommodityEvaluation commodityEvaluation;
	
	private Order order;
	
	private Member member;
	
	
	@FormField(label = "订单id", type = FieldType.TEXTINPUT)
	private String orderNo;
	
	@FormField(label = "星级", type = FieldType.TEXTINPUT)
	private String starLevel;
	 
	@FormField(label = "管理员回复", type = FieldType.TEXTINPUT)
	private String replyDeails;
	
	@JSONField(format = "yyyy-MM-dd HH:mm:ss",label = "管理员回复")
	private LocalDateTime replyTime = LocalDateTime.now();// 管理员回复时间
	
	public String getReplyDeails() {
		return replyDeails;
	}
	public void setReplyDeails(String replyDeails) {
		this.replyDeails = replyDeails;
	}
	public LocalDateTime getReplyTime() {
		return replyTime;
	}
	public void setReplyTime(LocalDateTime replyTime) {
		this.replyTime = replyTime;
	}
	@ManyToOne
	public CommodityEvaluation getCommodityEvaluation() {
		return commodityEvaluation;
	}
	public void setCommodityEvaluation(CommodityEvaluation commodityEvaluation) {
		this.commodityEvaluation = commodityEvaluation;
	}
	@ManyToOne
	public Member getMember() {
		return member;
	}
	public void setMember(Member member) {
		this.member = member;
	}
	/**
	 * @return the orderItem
	 */
	@ManyToOne
	public Order getOrder() {
		return order;
	}
	/**
	 * @param orderItem the orderItem to set
	 */
	public void setOrder(Order order) {
		this.order = order;
	}

	/**
	 * @return the starLevel
	 */
	public String getStarLevel() {
		return starLevel;
	}
	/**
	 * @param starLevel the starLevel to set
	 */
	public void setStarLevel(String starLevel) {
		this.starLevel = starLevel;
	}
	/**
	 * @return the orderNo
	 */
	public String getOrderNo() {
		return orderNo;
	}
	/**
	 * @param orderNo the orderNo to set
	 */
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	

	

}