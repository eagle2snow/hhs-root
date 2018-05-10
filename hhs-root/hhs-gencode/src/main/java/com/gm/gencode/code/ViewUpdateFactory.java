package com.gm.gencode.code;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.gm.gencode.IBuildCodeFactory;
import com.gm.gencode.util.FieldAnnotation;
import com.gm.gencode.util.FieldAnnotationUtil;
import com.gm.utils.IOStreamUtil;
import com.gm.utils.StringUtil;

import freemarker.cache.FileTemplateLoader;
import freemarker.cache.TemplateLoader;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

public class ViewUpdateFactory implements IBuildCodeFactory {

	private ViewUpdateFactory() {
	}

	private Class<?> cl;
	private String codeOutPath = null;
	private String tplPath = null;
	private String tplName = "update.ftl";

	public Class<?> getCl() {
		return cl;
	}

	public void setCl(Class<?> cl) {
		this.cl = cl;
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

	public String getTplName() {
		return tplName;
	}

	public void setTplName(String tplName) {
		this.tplName = tplName;
	}

	@Override
	public void buildCode() throws IOException, TemplateException {

		Map<String, Object> map = new HashMap<String, Object>();
		String entityPackage = this.getCl().getName();
		String entitySimpleName = this.getCl().getSimpleName();

		String viewPath = entityPackage;
		String tempView = viewPath.substring(viewPath.lastIndexOf("."), viewPath.length());
		viewPath = viewPath.replace(tempView, "");
		String tempView2 = viewPath.substring(viewPath.lastIndexOf("."), viewPath.length());
		viewPath = viewPath.replace(tempView2, "");
		viewPath = (tempView2 + StringUtil.firstLetterToLowercase(tempView)).replaceFirst("\\.", "").replace(".", "\\");
		
		List<FieldAnnotation> list = FieldAnnotationUtil.list(getCl());

		map.put("list", list);
		map.put("package", entityPackage.replaceAll("model", "dao").replaceAll("." + entitySimpleName, ""));
		map.put("entityPackage", entityPackage);
		map.put("entitySimpleName", entitySimpleName);
		String projectJavaDir = System.getProperty("user.dir") + File.separator + "src" + File.separator + "main"
				+ File.separator + "webapp" + File.separator + "WEB-INF" + File.separator + "views" + File.separator;
		String outPath = projectJavaDir +"admin\\"+ viewPath;
		String tplPath = System.getProperty("user.dir") + File.separator + "src" + File.separator + "main"
				+ File.separator + "java" + File.separator + "com\\gm\\gencode\\tpl\\";
		tplPath = tplPath.replace("hhs-base", "hhs-gencode");
		File tplFile = new File(tplPath);
		TemplateLoader templateLoader = new FileTemplateLoader(tplFile);
		@SuppressWarnings("deprecation")
		Configuration cfg = new Configuration();
		cfg.setTemplateLoader(templateLoader);
		outPath = outPath.replace("hhs-base", "hhs-main");
		File file = new File(outPath.toLowerCase());


		IOStreamUtil.mkDir(file);
		String fileName = outPath + File.separator + "update.jsp";
		Template temp = cfg.getTemplate(this.tplName);
		StringWriter out = new StringWriter();
		temp.process(map, out);

		// System.out.println(out.toString());

		FileOutputStream fos = new FileOutputStream(fileName);
		PrintWriter pwriter = new PrintWriter(fos);
		pwriter.write(out.toString());
		pwriter.close();
		fos.close();

	}

	public static ViewUpdateFactory buildViewUpdateFactory(Class<?> cl) {
		ViewUpdateFactory idaoFactory = new ViewUpdateFactory();
		idaoFactory.cl = cl;
		return idaoFactory;
	}



}
