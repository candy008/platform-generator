package com.platform.generator.action;

import java.util.regex.Matcher;
import java.util.regex.Pattern;




public class Test {
	int arr[]=new int[10]; 
	public static void main(String[] args) {
		 Pattern pattern = Pattern.compile("([a-z]*)\\w");		 		
		 Matcher matcher=pattern.matcher("abc123def123efg");		 		
		 if (matcher.find()) 
		 {	
		 	System.out.println(matcher.group(1));
		 }

	}
}
