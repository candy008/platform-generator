package com.platform.generator.util;

public enum ConfEnum {
	
	TEMPLATE_NAME("templateName"), 
	FILENAME_SUFFIX("fileNameSuffix"),
	PACKAGE_SUFFIX("packageSuffix"),
	FILE_TYPE("fileType"),
	PARENT_CLASSNAME("parentClassName"), 
	PARENT_PACKAGENAME("parentPackageName"), 
	PACKAGENAME("packageName"),
	PATH("path"); 
	
	
	
	
    
    public String config;
	
	ConfEnum(String config){
		this.config=config;
	}
	
	public String getConfig(){
		return config;
	}

}