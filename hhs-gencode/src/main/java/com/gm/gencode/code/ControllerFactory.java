package com.gm.gencode.code;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;


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

public class ControllerFactory implements IBuildCodeFactory {

	private ControllerFactory() {
	}

	private Class<?> cl;
	private String codeOutPath = null;
	private String tplPath = null;
	private String tplName = "Controller.ftl";

	public static ControllerFactory buildControllerFactory(Class<?> cl) {
		ControllerFactory factory = new ControllerFactory();
		factory.setCl(cl);
		return factory;
	}

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
	
		String _package = entityPackage.substring(0, entityPackage.length()-entitySimpleName.length()-1);
		_package = _package.replace(".base.", ".admin.");
		_package = _package.replaceAll(".model.", ".controller.");
		String temp1 = _package.substring(_package.lastIndexOf("."),_package.length());
		String tempPackage = _package.replace(temp1, "");
		String temp2 = tempPackage.substring(tempPackage.lastIndexOf("."),tempPackage.length());
		tempPackage = tempPackage.replace(temp2, "");
		tempPackage = tempPackage +".service";
		String iServicePackage = tempPackage + temp1 + temp2.replace(temp2,".I" + entitySimpleName + "Service");
		
		String entityName = StringUtil.firstCase(entitySimpleName);
		String path = entityPackage.replace("base", "admin").replaceAll("com.gm.", "").replaceAll("model.", "").toLowerCase()
				.replaceAll("\\.", "\\/") + "/";
		String view = "app/" + path;
		String iService = "I" + entitySimpleName + "Service";
		String className = entityPackage.replace(".base.", ".admin.");
		
		className = StringUtil.firstCapital(temp1.replace(".", ""))+entitySimpleName;
		
		String perm = entityPackage.replaceAll("com.gm.", "").replaceAll("model.", "").toLowerCase().replaceAll("\\.", ":");
		perm = perm.replaceAll("base", "admin");
		String addPerm = perm + ":add";
		String showPerm = perm + ":show";
		String updatePerm = perm + ":update";
		String deletePerm = perm + ":delete";
		
		
		map.put("addPerm", addPerm);
		map.put("showPerm", showPerm);
		map.put("updatePerm", updatePerm);
		map.put("deletePerm", deletePerm);
		map.put("path", path);
		map.put("view", view);
		map.put("IService", iService);
		map.put("controllerName",className);

		map.put("package", _package);
		map.put("iServicePackage", iServicePackage.replaceAll(".admin", ""));
	
		map.put("entityPackage", entityPackage);
		map.put("entitySimpleName", entitySimpleName);
		map.put("entityName", entityName);

		List<FieldAnnotation> list = FieldAnnotationUtil.list(cl);

		Map<Class, String> models = new HashMap<>();
		for (FieldAnnotation fa : list) {
			if (null != fa.getDs() ) {

				//System.out.println(fa.getDs() + "fff");

				models.put(fa.getDs(), fa.getFieldName());
			}
		}

		String addMap = "";
		String services = "";
		for (Entry<Class, String> e : models.entrySet()) {
			String s = "map.put(\"" + e.getValue() + "List\"," + e.getValue() + "Service" + ".list());";
			addMap += s;

			//System.out.println("xxxx" + e.getKey().getSimpleName());

			String service = " @Resource private I" + e.getKey().getSimpleName() + "Service " + e.getValue()
					+ "Service; ";
			services += service;
		}

		map.put("addMap", addMap);

		map.put("services", services);
		
		String workspace =System.getProperty("user.dir").replaceAll("hhs-base","");
		workspace = workspace.substring(0, workspace.length()-1);
		String projectJavaDir = workspace+ File.separator +  "hhs-main" + File.separator + "src" + File.separator + "main"
				+ File.separator + "java" + File.separator;
		String outPath = "";
		
		if (this.codeOutPath == null) {
			outPath = (_package.replaceAll("\\.", "\\\\")) + File.separator;
			outPath = projectJavaDir + outPath;
		} else {
			outPath = projectJavaDir + this.codeOutPath;
		}
		File tplFile = null;
		projectJavaDir = projectJavaDir.replace("hhs-main","hhs-gencode");
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
		String fileName = outPath + className + "Controller.java";
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
