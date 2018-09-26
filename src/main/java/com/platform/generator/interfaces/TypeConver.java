package com.platform.generator.interfaces;

import java.util.Map;

public interface TypeConver {

	/**
	 * 将数据库的类型转换为Java
	 * @return
	 */
	public Map<String, String> dbTypeToJava(String str);
	/**
	 * 将数据库的类型转换为Java,number类型根据长度变成Integer或Long
	 * @param typeName
	 * @param columnSize
	 * @return
	 */
	public Map<String, String> dbTypeToJava(String typeName, String columnSize);
}
