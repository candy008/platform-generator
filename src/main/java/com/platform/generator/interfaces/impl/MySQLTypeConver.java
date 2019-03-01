package com.platform.generator.interfaces.impl;

import java.util.HashMap;
import java.util.Map;

import com.platform.generator.interfaces.TypeConver;

public class MySQLTypeConver implements TypeConver{

	@Override
	public Map<String, String> dbTypeToJava(String str) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, String> dbTypeToJava(String str, String columnSize) {
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
		}else if(str.toUpperCase().equals("TINYINT")){
			map.put("type", "Integer");
			map.put("package", "");
			return map;
		}else if(str.toUpperCase().equals("DECIMAL")){
			map.put("type", "BigDecimal");
			map.put("package", "");
			return map;
		}else{
			map.put("type", "String");
			map.put("package", "");
			return map;
		}
	}

}
