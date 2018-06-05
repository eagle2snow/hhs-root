package com.gm.base.model;

import com.gm.gencode.annotation.FormField;
import com.gm.gencode.annotation.M;
import com.gm.gencode.util.DataNature;
import com.gm.gencode.util.FieldType;

import javax.persistence.Entity;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.math.BigDecimal;

@M("会员账单明细表")
@Entity(name = "memberBillDetails")
@Table(name = "t_commodity_Bill_Details")
public class MemberBillDetails extends Model{

    @FormField(type = FieldType.SELECT, label = "会员", dataNature = DataNature.MODEL, ds = Member.class)
    private Member member;

    @FormField(type = FieldType.TEXTINPUT, label = "返佣类型")
    private Integer type; // 1:十返一，2:返套餐，3:提成，4:返5元每人，5:三级分润

    @FormField(type = FieldType.TEXTINPUT, label = "返佣金额")
    private BigDecimal recordMoney;

    @FormField(type = FieldType.TEXTINPUT, label = "消费金额")
    private BigDecimal consumeMoney;

    @FormField(type = FieldType.TEXTINPUT, label = "订单号")
    private String orderNo;

    @FormField(type = FieldType.TEXTINPUT, label = "交易详情")
    private String details;



    public MemberBillDetails() {
        super();
        // TODO Auto-generated constructor stub
    }

    @ManyToOne
    public Member getMember() {
        return member;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public BigDecimal getRecordMoney() {
        return recordMoney;
    }

    public void setRecordMoney(BigDecimal recordMoney) {
        this.recordMoney = recordMoney;
    }

    public BigDecimal getConsumeMoney() {
        return consumeMoney;
    }

    public void setConsumeMoney(BigDecimal consumeMoney) {
        this.consumeMoney = consumeMoney;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }
}
