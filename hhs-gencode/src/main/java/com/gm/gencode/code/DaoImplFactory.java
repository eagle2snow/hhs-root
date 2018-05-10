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

public class DaoImplFactory implements IBuildCodeFactory {

	private DaoImplFactory() {
	}

	private Class<?> cl;
	private String codeOutPath = null;
	private String tplPath = null;
	private String tplName = "DaoImpl.ftl";

	public static DaoImplFactory buildDaoImplFactory(Class<?> cl) {
		DaoImplFactory factory = new DaoImplFactory();
		factory.setCl(cl);
		return factory;
	}

	@Override
	public void buildCode() throws IOException, TemplateException {
		Map<String, Object> map = new HashMap<String, Object>();
		String entityPackage = this.getCl().getName();
		String entitySimpleName = this.getCl().getSimpleName();
		String _package = entityPackage.replaceAll("model", "dao").replaceAll(entitySimpleName, "impl");
		String idaoPackage = _package.replaceAll("impl", "I" + entitySimpleName + "Dao");
		map.put("package", _package);
		map.put("idaoPackage", idaoPackage);
		map.put("entityPackage", entityPackage);
		map.put("entitySimpleName", entitySimpleName);
		String projectJavaDir = System.getProperty("user.dir") + File.separator + "src" + File.separator + "main"
				+ File.separator + "java" + File.separator;
		String outPath = "";
		if (this.codeOutPath == null) {
			outPath = (projectJavaDir + _package.replaceAll("\\.", "\\\\")) + File.separator;
		} else {
			outPath = projectJavaDir + this.codeOutPath;
		}

		File tplFile = null;
		projectJavaDir = projectJavaDir.replace("hhs-base", "hhs-gencode");
		if (this.tplPath == null) {
			tplFile = new File(projectJavaDir + "com\\gm\\gencode\\tpl\\");
		} else {
			tplFile = new File(projectJavaDir + this.tplPath);
		}
		TemplateLoader templateLoader = new FileTemplateLoader(tplFile);
		@SuppressWarnings("deprecation")
		Configuration cfg = new Configuration();
		cfg.setTemplateLoader(templateLoader);
		File file = new File(outPath);
		IOStreamUtil.mkDir(file);

		String fileName = outPath + entitySimpleName + "DaoImpl.java";
		Template temp = cfg.getTemplate(this.tplName);
		StringWriter out = new StringWriter();
		temp.process(map, out);
		
		FileOutputStream fos = new FileOutputStream(fileName);
		PrintWriter pwriter = new PrintWriter(fos);
		pwriter.write(out.toString());
		pwriter.close();
		fos.close();
	}

	@Override
	public String getCodeOutPath() {
		// TODO Auto-generated method stub
		return codeOutPath;
	}

	@Override
	public void setCodeOutPath(String codeOutPath) {
		// TODO Auto-generated method stub
		this.codeOutPath = codeOutPath;
	}

	@Override
	public String getTplPath() {
		// TODO Auto-generated method stub
		return tplPath;
	}

	@Override
	public void setTplPath(String tplPath) {
		// TODO Auto-generated method stub
		this.tplPath = tplPath;
	}

	@Override
	public String getTplName() {
		// TODO Auto-generated method stub
		return tplName;
	}

	@Override
	public void setTplName(String tplName) {
		// TODO Auto-generated method stub
		this.tplName = tplName;
	}

	public Class<?> getCl() {
		return cl;
	}

	public void setCl(Class<?> cl) {
		this.cl = cl;
	}

}
