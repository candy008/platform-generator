package com.platform.generator.config;

import java.util.Map;

import org.springframework.stereotype.Component;

import com.mchange.v2.c3p0.ComboPooledDataSource;
import com.platform.generator.bean.GeneratorBean;


@Component("generatorConfig")
public class GeneratorConfig {

	private String basePath;
	
	private ComboPooledDataSource dataSource; 
	
	private Map<String, GeneratorBean> generatorBeanMap;
	
	private String tableNames;
	
	private String dbName;
	
	private String freemakerTemplatePath;
	
	public String getBasePath() {
		return basePath;
	}

	public void setBasePath(String basePath) {
		this.basePath = basePath;
	}

	public ComboPooledDataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(ComboPooledDataSource dataSource) {
		this.dataSource = dataSource;
	}



	public Map<String, GeneratorBean> getGeneratorBeanMap() {
		return generatorBeanMap;
	}



	public void setGeneratorBeanMap(Map<String, GeneratorBean> generatorBeanMap) {
		this.generatorBeanMap = generatorBeanMap;
	}

	public String getTableNames() {
		return tableNames;
	}

	public void setTableNames(String tableNames) {
		this.tableNames = tableNames;
	}

	public String getDbName() {
		return dbName;
	}

	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public String getFreemakerTemplatePath() {
		return freemakerTemplatePath;
	}

	public void setFreemakerTemplatePath(String freemakerTemplatePath) {
		this.freemakerTemplatePath = freemakerTemplatePath;
	}



	
}
