package com.gm.base.test;

import java.io.IOException;

import com.gm.gencode.Build;

import freemarker.template.TemplateException;

public class CreateCode {

	public static void main(String[] args) throws IOException, TemplateException {

		/** ====================================================== **/
		/*
		 * 生成选项 idao,dao,si,is,c,add,update,list ，null则全部生成
		 * ======================================================
		 **/

		// Build.buildCode(Notice.class, "idao,dao,si,is,c,add,update,list");
		// Build.buildCode(News.class, "idao,dao,si,is,c,add,update,list");

		// Build.buildCode(AppInfo.class, "idao,dao,si,is,c,add,update,list");
		// Build.buildCode(MemberAddress.class, null);

		// Build.buildCode(AutoMsgType.class, null);
		// Build.buildCode(AutoMsg.class, null);
		// Build.buildCode(CommodityEvaluation.class, null);
		// Build.buildCode(OrderItem.class, "idao,dao,si,is");

		// Build.buildCode(TenReturnOne.class, "idao,dao,si,is");

		// Build.buildCode(TestTime.class, "update");

	}

}
