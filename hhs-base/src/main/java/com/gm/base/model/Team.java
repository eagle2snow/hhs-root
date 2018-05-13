package com.gm.base.model;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.gm.gencode.annotation.M;

import lombok.Data;

@M("会员信息")
@Data
@Entity(name = "member")
@Table(name = "t_member")
@SuppressWarnings("serial")
public class Team extends Model {
	
	private Member member;
	

}
