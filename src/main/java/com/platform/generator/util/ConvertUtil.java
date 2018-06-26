package com.platform.generator.util;

import org.apache.commons.lang.StringUtils;

/**
 * 
 * @author quanjianjun
 * 
 */
public class ConvertUtil {

	public static String firstUpperCamelCase(String str) {
		if (StringUtils.isNotBlank(str)) {
			str = str.replace("T_", "");
			str = str.toLowerCase();
			String[] strs = str.split("_");
			if (strs.length == 1) {
				return firstLetterUpper(str);
			} else {
				String convertedStr = "";
				for (int i = 0; i < strs.length; i++) {
					convertedStr += firstLetterUpper(strs[i]);
				}
				return convertedStr;
			}
		}
		return str;
	}

	public static String firstLowerCamelCase(String str) {
		if (StringUtils.isNotBlank(str)) {
			str = str.replace("T_", "");
			str = str.toLowerCase();
			String[] strs = str.split("_");
			if (strs.length == 1) {
				return allLower(str);
			} else {
				String convertedStr = "";
				for (int i = 1; i < strs.length; i++) {
					convertedStr += firstLetterUpper(strs[i]);
				}
				return strs[0] + convertedStr;
			}
		}
		return str;
	}

	public static String firstLetterUpper(String str) {
		if (StringUtils.isNotBlank(str)) {
			str = str.replace("T_", "");
			str = str.toLowerCase();
			return str.substring(0, 1).toUpperCase()
					+ str.substring(1, str.length());
		}
		return str;
	}

	public static String allUpper(String str) {
		if (StringUtils.isNotBlank(str)) {
			str = str.replace("T_", "");
			str = str.toLowerCase();
			String[] strs = str.split("_");
			if (strs.length == 1) {
				return str.toUpperCase();
			} else {
				String convertedStr = "";
				for (int i = 0; i < strs.length; i++) {
					convertedStr += strs[i].toUpperCase();
				}
				return convertedStr;
			}
		}
		return str;
	}

	public static String allLower(String str) {
		if (StringUtils.isNotBlank(str)) {
			str = str.replace("T_", "");
			str = str.toLowerCase();
			String[] strs = str.split("_");
			if (strs.length == 1) {
				return str.toLowerCase();
			} else {
				String convertedStr = "";
				for (int i = 0; i < strs.length; i++) {
					convertedStr += strs[i].toLowerCase();
				}
				return convertedStr;
			}
		}
		return str;
	}

	public static void main(String[] args) {
		String s = "e_wfAA_T_AAD_dAAAA_AAdd";
		System.out.println(firstUpperCamelCase(s));
		System.out.println(firstLowerCamelCase(s));
		System.out.println(s.toLowerCase());
	}
}
