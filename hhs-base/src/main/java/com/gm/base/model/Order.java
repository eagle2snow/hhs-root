package com.gm.base.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import com.alibaba.fastjson.annotation.JSONField;
import com.gm.gencode.annotation.FormField;
import com.gm.gencode.annotation.M;
import com.gm.gencode.util.FieldType;

@M("订单表")
@Entity(name = "order")
@Table(name = "t_order")
@SuppressWarnings("serial")
public class Order extends Model {

	@FormField(type = FieldType.TEXTINPUT, label = "openid")
	private Member member;// 关联会员id

	private MemberAddress memberAddress;// 会员收货地址

	@FormField(type = FieldType.NUMBER, label = "订单总额")
	private BigDecimal totalMoney;// 订单总额

	@FormField(type = FieldType.NUMBER, label = "邮费")
	private BigDecimal postageMoney;// 订单邮费

	@FormField(type = FieldType.NUMBER, label = "订单状态", data = "1|待付款,2|待发货,3|待收货,4|已收货,5|退换货申请中,6|退换货申请通过待买家发货,7|退换货申请通过买家已发货,8|退换货申请不通过,9|订单已退款,10|订单已完成,11|加急")
	private Integer status;// 订单状态

	@FormField(type = FieldType.TEXTINPUT, label = "订单备注")
	private String orderRemarks;// 订单所留备注

	@FormField(type = FieldType.TIME, label = "付款时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime paymentTime;// 订单付款时间

	@FormField(type = FieldType.TIME, label = "发货时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime shipmentsTime;// 订单发货时间

	@FormField(type = FieldType.TIME, label = "收货时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime receivingTime;// 订单收货时间

	@FormField(type = FieldType.TIME, label = "退货申请时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime applyForTime;// 订单退货申请时间

	@FormField(type = FieldType.TIME, label = "退货审核时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime checkTime;// 订单退换货审核时间

	@FormField(type = FieldType.TIME, label = "退货发货时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime buyerDshipmentsTime;// 订单退换货买家发货时间

	@FormField(type = FieldType.TIME, label = "退款时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime refundTime;// 订单退款时间

	@FormField(type = FieldType.TIME, label = "订单完成时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private LocalDateTime finishTime;// 订单完成时间

	@FormField(type = FieldType.TEXTINPUT, label = "发货快递")
	private String expressName;// 快递名称

	@FormField(type = FieldType.NUMBER, label = "退款金额")
	private BigDecimal orderRefundTime;// 退款金额

	@FormField(type = FieldType.TEXTINPUT, label = "发货快递单号")
	private String expressNo;// 快递单号

	@FormField(type = FieldType.TEXTINPUT, label = "退款理由")
	private String refundReason;// 退款理由

	@FormField(type = FieldType.TEXTINPUT, label = "退货上传图片")
	private String imageUrl;// 退货上传图片

	@FormField(type = FieldType.TEXTINPUT, label = "拒绝退款")
	private String rejectReason;// 拒绝退款理由

	@FormField(type = FieldType.TEXTINPUT, label = "退货快递")
	private String refundExpressName;// 退货快递名称

	@FormField(type = FieldType.TEXTINPUT, label = "退货快递单号")
	private String refundExpressNo;// 退货快递单号

	@FormField(type = FieldType.NUMBER, label = "一级分销提成")
	private BigDecimal firstLevelBrokerage;// 一级分销提成

	@FormField(type = FieldType.NUMBER, label = "二级分销提成")
	private BigDecimal secondLevelBrokerage;// 二级分销提成

	@FormField(type = FieldType.NUMBER, label = "支付方式", data = "0|余额支付,1|微信支付,2|支付宝支付")
	private Integer payPathway;// 支付方式

	@FormField(type = FieldType.NUMBER, label = "是否已评价", data = "0|未评价,1|已评价")
	private Integer appraise = 0;// 是否已评价

	@FormField(type = FieldType.TIME, label = "评价时间")
	@JSONField(format = "yyyy-MM-dd HH:mm:ss")
	private Date appraiseTime;// 评价时间

	@FormField(type = FieldType.TEXTINPUT, label = "商家备注")
	private String businessRemarks;// 商家备注

	@FormField(type = FieldType.TEXTINPUT, label = "退款备注")
	private String refundRemarks;// 退款备注

	@FormField(type = FieldType.TEXTINPUT, label = "支付宝交易号")
	private String alipayNumber;// 支付宝单号

	@FormField(type = FieldType.TEXTINPUT, label = "微信交易号")
	private String wxNumber;// 微信单号

	private String orderNo;// 订单号
	
	private List<OrderItem> items = new ArrayList<>();

	@ManyToOne
	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}

	public BigDecimal getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(BigDecimal totalMoney) {
		this.totalMoney = totalMoney;
	}

	public BigDecimal getPostageMoney() {
		return postageMoney;
	}

	public void setPostageMoney(BigDecimal postageMoney) {
		this.postageMoney = postageMoney;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getOrderRemarks() {
		return orderRemarks;
	}

	public void setOrderRemarks(String orderRemarks) {
		this.orderRemarks = orderRemarks;
	}

	public LocalDateTime getPaymentTime() {
		return paymentTime;
	}

	public void setPaymentTime(LocalDateTime paymentTime) {
		this.paymentTime = paymentTime;
	}

	public LocalDateTime getShipmentsTime() {
		return shipmentsTime;
	}

	public void setShipmentsTime(LocalDateTime shipmentsTime) {
		this.shipmentsTime = shipmentsTime;
	}

	public LocalDateTime getReceivingTime() {
		return receivingTime;
	}

	public void setReceivingTime(LocalDateTime receivingTime) {
		this.receivingTime = receivingTime;
	}

	public LocalDateTime getApplyForTime() {
		return applyForTime;
	}

	public void setApplyForTime(LocalDateTime applyForTime) {
		this.applyForTime = applyForTime;
	}

	public LocalDateTime getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(LocalDateTime checkTime) {
		this.checkTime = checkTime;
	}

	public LocalDateTime getBuyerDshipmentsTime() {
		return buyerDshipmentsTime;
	}

	public void setBuyerDshipmentsTime(LocalDateTime buyerDshipmentsTime) {
		this.buyerDshipmentsTime = buyerDshipmentsTime;
	}

	public LocalDateTime getRefundTime() {
		return refundTime;
	}

	public void setRefundTime(LocalDateTime refundTime) {
		this.refundTime = refundTime;
	}

	public LocalDateTime getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(LocalDateTime finishTime) {
		this.finishTime = finishTime;
	}

	public String getExpressName() {
		return expressName;
	}

	public void setExpressName(String expressName) {
		this.expressName = expressName;
	}

	public BigDecimal getOrderRefundTime() {
		return orderRefundTime;
	}

	public void setOrderRefundTime(BigDecimal orderRefundTime) {
		this.orderRefundTime = orderRefundTime;
	}

	public String getExpressNo() {
		return expressNo;
	}

	public void setExpressNo(String expressNo) {
		this.expressNo = expressNo;
	}

	public String getRefundReason() {
		return refundReason;
	}

	public void setRefundReason(String refundReason) {
		this.refundReason = refundReason;
	}

	@Column(columnDefinition = "TEXT")
	public String getImageUrl() {
		return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}

	public String getRefundExpressName() {
		return refundExpressName;
	}

	public void setRefundExpressName(String refundExpressName) {
		this.refundExpressName = refundExpressName;
	}

	public String getRefundExpressNo() {
		return refundExpressNo;
	}

	public void setRefundExpressNo(String refundExpressNo) {
		this.refundExpressNo = refundExpressNo;
	}

	public BigDecimal getFirstLevelBrokerage() {
		return firstLevelBrokerage;
	}

	public void setFirstLevelBrokerage(BigDecimal firstLevelBrokerage) {
		this.firstLevelBrokerage = firstLevelBrokerage;
	}

	public BigDecimal getSecondLevelBrokerage() {
		return secondLevelBrokerage;
	}

	public void setSecondLevelBrokerage(BigDecimal secondLevelBrokerage) {
		this.secondLevelBrokerage = secondLevelBrokerage;
	}

	public Integer getPayPathway() {
		return payPathway;
	}

	public void setPayPathway(Integer payPathway) {
		this.payPathway = payPathway;
	}

	public Integer getAppraise() {
		return appraise;
	}

	public void setAppraise(Integer appraise) {
		this.appraise = appraise;
	}

	public Date getAppraiseTime() {
		return appraiseTime;
	}

	public void setAppraiseTime(Date appraiseTime) {
		this.appraiseTime = appraiseTime;
	}

	public String getBusinessRemarks() {
		return businessRemarks;
	}

	public void setBusinessRemarks(String businessRemarks) {
		this.businessRemarks = businessRemarks;
	}

	public String getRefundRemarks() {
		return refundRemarks;
	}

	public void setRefundRemarks(String refundRemarks) {
		this.refundRemarks = refundRemarks;
	}

	public String getAlipayNumber() {
		return alipayNumber;
	}

	public void setAlipayNumber(String alipayNumber) {
		this.alipayNumber = alipayNumber;
	}

	public String getWxNumber() {
		return wxNumber;
	}

	public void setWxNumber(String wxNumber) {
		this.wxNumber = wxNumber;
	}

	@ManyToOne
	public MemberAddress getMemberAddress() {
		return memberAddress;
	}

	public void setMemberAddress(MemberAddress memberAddress) {
		this.memberAddress = memberAddress;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	@Transient
	public List<OrderItem> getItems() {
		return items;
	}

	public void setItems(List<OrderItem> items) {
		this.items = items;
	}

}
