package com.platform.generator.interfaces.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.platform.generator.interfaces.TypeConver;
public class DefaultTypeConver implements TypeConver {

	@Override
	public Map<String, String> dbTypeToJava(String str) {
		Map<String, String> map = new HashMap<String, String>();
		if(str.equals("VARCHAR")){
			map.put("type", "String");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("INT")){
			map.put("type", "Integer");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("SMALLINT")){
			map.put("type", "Integer");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("DATETIME")){
			map.put("type", "Date");
			map.put("package", "java.util.Date");
			return map;
		}else if(str.toUpperCase().equals("BIGINT UNSIGNED")){
			map.put("type", "Long");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("BIGINT")){
			map.put("type", "Long");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("DECIMAL")){
			map.put("type", "Double");
			map.put("package", "");
			return map;
		}
		else{
			map.put("type", "String");
			map.put("package", "");
			return map;
		}
	}

	@Override
	public Map<String, String> dbTypeToJava(String str, String columnSize) {
		Integer size = null;
		if(StringUtils.isNotBlank(columnSize)){
			size = Integer.valueOf(columnSize);
		}
		
		Map<String, String> map = new HashMap<String, String>();
		if(str.equals("VARCHAR")){
			map.put("type", "String");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("NUMBER")){
			if(size<=9){
				map.put("type", "Integer");
				map.put("package", "");
				return map;
			}else{
				map.put("type", "Long");
				map.put("package", "");
				return map;
			}
		}else if(str.toUpperCase().equals("BIGINT")){
			map.put("type", "Long");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("SMALLINT")){
			map.put("type", "Integer");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("DATE")){
			map.put("type", "Date");
			map.put("package", "java.util.Date");
			return map;
		}else if(str.toUpperCase().equals("DECIMAL")){
			map.put("type", "Double");
			map.put("package", "");
			return map;
		}else{
			map.put("type", "String");
			map.put("package", "");
			return map;
		}
	}
}
