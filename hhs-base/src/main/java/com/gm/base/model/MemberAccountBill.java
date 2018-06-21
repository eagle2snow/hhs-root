package com.gm.base.model;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.gm.gencode.annotation.FormField;
import com.gm.gencode.annotation.M;
import com.gm.gencode.util.FieldType;

import lombok.Data;

/**
 * @author Eagle
 *
 */
@M("会员账户账单")
@SuppressWarnings("serial")
@Entity(name = "memberAccountBill")
@Table(name = "t_member_acount_bill")
public class MemberAccountBill extends Model {

	@FormField(type = FieldType.NUMBER, label = "自己Id")
	private Integer selfId;

	@FormField(type = FieldType.TEXTINPUT, label = "自己昵称")
	private String selfName;

	@FormField(type = FieldType.NUMBER, label = "上家ID")
	private Integer upId;

	@FormField(type = FieldType.TEXTINPUT, label = "上家姓名")
	private String upName;
	
	@FormField(type = FieldType.NUMBER, label = "三级分润等级记录")
	private Integer status; // 1：直推   2：直系
	
	

	/*
	 * @FormField(type = FieldType.TEXTINPUT, label = "下家ID") private Integer
	 * nextId;
	 * 
	 * @FormField(type = FieldType.TEXTINPUT, label = "下家姓名") private String
	 * nextName;
	 */

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@FormField(type = FieldType.TEXTINPUT, label = "订单ID")
	private String orderNo;

	@FormField(type = FieldType.NUMBER, label = "类型", data = "1|十返一,2|返套餐,3|5元/人,4|提成,6|三级分润,7|买商品,8|买套餐,9|提现")
	private Integer type;

	@FormField(type = FieldType.TEXTINPUT, label = "金额")
	private BigDecimal money = BigDecimal.ZERO;

	@FormField(type = FieldType.TEXTINPUT, label = "备注")
	private String remark;

	public MemberAccountBill() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberAccountBill(Integer selfId, String selfName, Integer upId, String upName, String orderNo, Integer type,
			BigDecimal money, String remark) {
		super();
		this.selfId = selfId;
		this.selfName = selfName;
		this.upId = upId;
		this.upName = upName;
		this.orderNo = orderNo;
		this.type = type;
		this.money = money;
		this.remark = remark;
	}

	public Integer getSelfId() {
		return selfId;
	}

	public void setSelfId(Integer selfId) {
		this.selfId = selfId;
	}

	public String getSelfName() {
		return selfName;
	}

	public void setSelfName(String selfName) {
		this.selfName = selfName;
	}

	public Integer getUpId() {
		return upId;
	}

	public void setUpId(Integer upId) {
		this.upId = upId;
	}

	public String getUpName() {
		return upName;
	}

	public void setUpName(String upName) {
		this.upName = upName;
	}

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public BigDecimal getMoney() {
		return money;
	}

	public void setMoney(BigDecimal money) {
		this.money = money;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
