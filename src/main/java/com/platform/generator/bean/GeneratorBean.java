package com.platform.generator.bean;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

public class GeneratorBean {
	
	//父类名称
	private String parentClassName;
	//父类包名
	private String parentPackageName;
	//包名
	private String packageName;
	//类名称
	private String className;
	//文件类型
	private String fileType;
	//文件的后缀名称
	private String fileNameSuffix;
	//模板名称
	private String templateName;
	//包的最后一级
	private String packageSuffix;
	private String packageSuffixPath;
	private List<GeneratorBean> yilaiList;
	
	private String packageName1;
	
	private String packageNameTemp;
	
	private String path;
	
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	//依赖的Bean
	private List<GeneratorBean> relyBeanList;
	//接口集合
	private Map<String, String> interfaceMap;
	
	private List<String> configList;
	
	public String getParentClassName() {
		return parentClassName;
	}
	public void setParentClassName(String parentClassName) {
		this.parentClassName = parentClassName;
	}
	public String getParentPackageName() {
		return parentPackageName;
	}
	public void setParentPackageName(String parentPackageName) {
		this.parentPackageName = parentPackageName;
	}
	public String getPackageName() {
		if(StringUtils.isNotEmpty(packageNameTemp)){
			return packageNameTemp;
		}
		return packageName;
	}
	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	public String getClassName() {
		return className;
	}
	public void setClassName(String className) {
		this.className = className;
	}
	
	public Map<String, String> getInterfaceMap() {
		return interfaceMap;
	}
	public void setInterfaceMap(Map<String, String> interfaceMap) {
		this.interfaceMap = interfaceMap;
	}
	public String getFileType() {
		return fileType;
	}
	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	public List<GeneratorBean> getRelyBeanList() {
		return relyBeanList;
	}
	public void setRelyBeanList(List<GeneratorBean> relyBeanList) {
		this.relyBeanList = relyBeanList;
	}
	public String getFileNameSuffix() {
		return fileNameSuffix;
	}
	public void setFileNameSuffix(String fileNameSuffix) {
		this.fileNameSuffix = fileNameSuffix;
	}
	public String getTemplateName() {
		return templateName;
	}
	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}
	public String getPackageSuffix() {
		return packageSuffix;
	}
	public void setPackageSuffix(String packageSuffix) {
		this.packageSuffix = packageSuffix;
	}
	public List<String> getConfigList() {
		return configList;
	}
	public void setConfigList(List<String> configList) {
		this.configList = configList;
	}
	public String getPackageSuffixPath() {
		return packageSuffixPath;
	}
	public void setPackageSuffixPath(String packageSuffixPath) {
		this.packageSuffixPath = packageSuffixPath;
	}
	public List<GeneratorBean> getYilaiList() {
		return yilaiList;
	}
	public void setYilaiList(List<GeneratorBean> yilaiList) {
		this.yilaiList = yilaiList;
	}
	public String getPackageNameTemp() {
		return packageNameTemp;
	}
	public void setPackageNameTemp(String packageNameTemp) {
		this.packageNameTemp = packageNameTemp;
	}
	public String getPackageName1() {
		return packageName1;
	}
	public void setPackageName1(String packageName1) {
		this.packageName1 = packageName1;
	}
	
}
