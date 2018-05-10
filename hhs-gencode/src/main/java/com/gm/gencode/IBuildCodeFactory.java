package com.gm.gencode;

import java.io.IOException;

import freemarker.template.TemplateException;

/**
 * 代码生产工厂接口
 * @author Guet
 *
 */
public interface IBuildCodeFactory {

	/**
	 * 核心代码生成
	 */
	public void buildCode() throws IOException,TemplateException;
	
	
	
	/**
	 * 获取代码输出路径
	 * @return
	 */
	public String getCodeOutPath();

	/**
	 * 设置代码输出路径
	 * @param codeOutPath
	 */
	public void setCodeOutPath(String codeOutPath);
	

	/**
	 * 获取代码模板路径
	 * @return
	 */
	public String getTplPath();
	
	/**
	 * 设置代码模板路径
	 * @param tplPath
	 */
	public void setTplPath(String tplPath);
	
	/**
	 * 获取模板名称
	 * @return
	 */
	public String getTplName();

	/**
	 * 设置代码模板名称
	 * @param tplName
	 */
	public void setTplName(String tplName);

}
