package com.gm.gencode;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.gm.gencode.code.ControllerFactory;
import com.gm.gencode.code.DaoImplFactory;
import com.gm.gencode.code.IDaoFactory;
import com.gm.gencode.code.IServiceFactory;
import com.gm.gencode.code.ServiceImplFactory;
import com.gm.gencode.code.ViewAdderFactory;
import com.gm.gencode.code.ViewManagerFactory;
import com.gm.gencode.code.ViewUpdateFactory;
import com.gm.utils.StringUtil;

import freemarker.template.TemplateException;

public class Build {
	public static void buildCode(Class cl, String buiders) throws IOException, TemplateException {

		if (buiders == null) {
			IBuildCodeFactory controller = ControllerFactory.buildControllerFactory(cl);
			controller.buildCode();

			IBuildCodeFactory idao = IDaoFactory.buildIDaoFactory(cl);
			idao.buildCode();

			IBuildCodeFactory daoimpl = DaoImplFactory.buildDaoImplFactory(cl);
			daoimpl.buildCode();

			IBuildCodeFactory serviceImpl = ServiceImplFactory.buildServiceImplFactory(cl);
			serviceImpl.buildCode();

			IBuildCodeFactory iservice = IServiceFactory.buildIServiceFactory(cl);
			iservice.buildCode();

			IBuildCodeFactory add = ViewAdderFactory.buildViewAdderFactory(cl);
			add.buildCode();

			IBuildCodeFactory update = ViewUpdateFactory.buildViewUpdateFactory(cl);
			update.buildCode();

			IBuildCodeFactory list = ViewManagerFactory.buildViewManagerFactory(cl);
			list.buildCode();

		} else {

			List<String> lists = StringUtil.toStringList(buiders, ",");

			if (lists.contains("c")) {

				IBuildCodeFactory controller = ControllerFactory.buildControllerFactory(cl);
				controller.buildCode();
			}

			if (lists.contains("idao")) {
				IBuildCodeFactory idao = IDaoFactory.buildIDaoFactory(cl);
				idao.buildCode();
			}

			if (lists.contains("dao")) {
				IBuildCodeFactory daoimpl = DaoImplFactory.buildDaoImplFactory(cl);
				daoimpl.buildCode();
			}

			if (lists.contains("si")) {
				IBuildCodeFactory serviceImpl = ServiceImplFactory.buildServiceImplFactory(cl);
				serviceImpl.buildCode();
			}

			if (lists.contains("is")) {
				IBuildCodeFactory iservice = IServiceFactory.buildIServiceFactory(cl);
				iservice.buildCode();
			}

			if (lists.contains("add")) {

				IBuildCodeFactory add = ViewAdderFactory.buildViewAdderFactory(cl);
				add.buildCode();
			}

			if (lists.contains("update")) {

				IBuildCodeFactory update = ViewUpdateFactory.buildViewUpdateFactory(cl);
				update.buildCode();
			}
			if (lists.contains("list")) {

				IBuildCodeFactory list = ViewManagerFactory.buildViewManagerFactory(cl);
				list.buildCode();
			}
		}

	}

}
