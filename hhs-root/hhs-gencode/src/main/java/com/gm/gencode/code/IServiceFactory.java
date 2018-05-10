package com.gm.gencode.code;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

import com.gm.gencode.IBuildCodeFactory;
import com.gm.utils.IOStreamUtil;

import freemarker.cache.FileTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class IServiceFactory implements IBuildCodeFactory {

	private IServiceFactory() {
	}

	private Class<?> cl;
	private String codeOutPath = null;
	private String tplPath = null;
	private String tplName = "IService.ftl";

	public String getTplName() {
		return tplName;
	}

	public void setTplName(String tplName) {
		this.tplName = tplName;
	}

	public String getCodeOutPath() {
		return codeOutPath;
	}

	public void setCodeOutPath(String codeOutPath) {
		this.codeOutPath = codeOutPath;
	}

	public String getTplPath() {
		return tplPath;
	}

	public void setTplPath(String tplPath) {
		this.tplPath = tplPath;
	}

	public static IServiceFactory buildIServiceFactory(Class<?> cl) {
		IServiceFactory iServiceFactory = new IServiceFactory();
		iServiceFactory.cl = cl;
		return iServiceFactory;
	}

	public Class<?> getCl() {
		return cl;
	}

	public void setCl(Class<?> cl) {
		this.cl = cl;
	}

	@Override
	public void buildCode() throws IOException, TemplateException {
		Map<String, Object> map = new HashMap<String, Object>();
		String entityPackage = this.getCl().getName();
		String entitySimpleName = this.getCl().getSimpleName();

		map.put("package", entityPackage.replaceAll("model", "service").replaceAll("." + entitySimpleName, "").replace(".base", ""));

		map.put("entityPackage", entityPackage);
		map.put("entitySimpleName", entitySimpleName);
		String projectJavaDir = System.getProperty("user.dir") + File.separator + "src" + File.separator + "main"
				+ File.separator + "java" + File.separator;
		String outPath = "";
		if (this.codeOutPath == null) {
			outPath = (entityPackage.replaceAll("\\.", "\\\\")).replaceAll("model", "service")
					.replaceAll(entitySimpleName, "");
			outPath = projectJavaDir + outPath;
		} else {
			outPath = projectJavaDir + this.codeOutPath;
		}

		File tplFile = null;

		if (this.tplPath == null) {
			tplFile = new File(projectJavaDir.replace("hhs-base", "hhs-gencode") + "com\\gm\\gencode\\tpl\\");
		} else {
			tplFile = new File(projectJavaDir.replace("hhs-base", "hhs-gencode") + this.tplPath);
		}
		TemplateLoader templateLoader = new FileTemplateLoader(tplFile);
		@SuppressWarnings("deprecation")
		Configuration cfg = new Configuration();
		cfg.setTemplateLoader(templateLoader);
		outPath = outPath.replaceAll("\\\\hhs-base\\\\", "\\\\hhs-service\\\\");
		outPath = outPath.replace("\\base", "");
		File file = new File(outPath);
		IOStreamUtil.mkDir(file);
		
		String fileName = outPath + "I" + entitySimpleName + "Service.java";
		Template temp = cfg.getTemplate(this.tplName);
		StringWriter out = new StringWriter();
		temp.process(map, out);
		
		FileOutputStream fos = new FileOutputStream(fileName);
		PrintWriter pwriter = new PrintWriter(fos);
		pwriter.write(out.toString());
		pwriter.close();
		fos.close();

	}

}
