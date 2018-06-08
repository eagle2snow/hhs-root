package com.gm.base.model;

import java.math.BigDecimal;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.gm.gencode.annotation.FormField;
import com.gm.gencode.annotation.M;
import com.gm.gencode.util.FieldType;

import lombok.Data;

@Data
@M("会员账户账单")
@SuppressWarnings("serial")
@Entity(name = "memberAccountBill")
@Table(name = "t_member_acount_bill")
public class MemberAccountBill extends Model {

	@FormField(type = FieldType.NUMBER, label = "自己Id")
	private Integer selfId;
	
	@FormField(type = FieldType.TEXTINPUT, label = "自己昵称")
	private String selfName;

	@FormField(type = FieldType.TEXTINPUT, label = "上家ID")
	private Integer upId;

	@FormField(type = FieldType.TEXTINPUT, label = "上家姓名")
	private String upName;

	/*@FormField(type = FieldType.TEXTINPUT, label = "下家ID")
	private Integer nextId;

	@FormField(type = FieldType.TEXTINPUT, label = "下家姓名")
	private String nextName;*/

	@FormField(type = FieldType.TEXTINPUT, label = "订单ID")
	private String orderNo;

	@FormField(type = FieldType.NUMBER, label = "类型", data = "1|十返一,2|返套餐,3|5元/人,4|提成,6|三级分润,7|买商品,8|买套餐,9|提现")
	private Integer type;

	@FormField(type = FieldType.TEXTINPUT, label = "金额")
	private BigDecimal money;

	@FormField(type = FieldType.TEXTINPUT, label = "备注")
	private String remark;

}
