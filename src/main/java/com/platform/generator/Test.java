//package com.platform.generator;
//
//import java.io.PrintWriter;
//import java.io.StringWriter;
//import java.lang.reflect.Field;
//
//public class Test {
//
//public static void main(String[] args){
//	convertEntry(new VipClubGiftPackage(),new VipClubGiftPackage());
//}
//	
//	public static void convertEntry(Object srcObject, Object descObject) {
//		try {
//			Class<?>[] getParameterType = new Class[] {};
//			java.lang.reflect.Field[] fs = srcObject.getClass().getDeclaredFields();
//			for (Field f : fs) {
//				f.setAccessible(true);
//				String srcFieldType = f.getType().getSimpleName().toString().toLowerCase();
//				String srcFieldName = f.getName();
//				if (!srcFieldName.equals("serialVersionUID")) {
//					String getMethodName = "get" + headUpper(srcFieldName);
//					if (srcFieldType.equals("boolean")) {
//						getMethodName = "is" + headUpper(srcFieldName);
//					}
//					String src="a.get"+headUpper(srcFieldName)+"("+srcFieldName+")";
//					String des="b.get"+headUpper(srcFieldName)+"("+srcFieldName+")";
//			        String out="if("+src+".equals("+des+")"+")";
//			        System.out.println(out);
//
//				}
//			}
//		} catch (SecurityException e) {
//			StringWriter sw = new StringWriter();
//			PrintWriter pw = new PrintWriter(sw);
//			e.printStackTrace(pw);
//		} catch (IllegalArgumentException e) {
//			StringWriter sw = new StringWriter();
//			PrintWriter pw = new PrintWriter(sw);
//			e.printStackTrace(pw);
//		}
//	}
//	
////	public  static String headUpper(String s){
////		if(a.getId(id).equals(b.getId(id)))
////			if(a.getName(name).equals(b.getName(name)))
////			if(a.getStartTime(startTime).equals(b.getStartTime(startTime)))
////			if(a.getEndTime(endTime).equals(b.getEndTime(endTime)))
////			if(a.getStatus(status).equals(b.getStatus(status)))
////			if(a.getContent(content).equals(b.getContent(content)))
////			if(a.getType(type).equals(b.getType(type)))
////			if(a.getSelectType(selectType).equals(b.getSelectType(selectType)))
////			if(a.getCreater(creater).equals(b.getCreater(creater)))
////			if(a.getModifier(modifier).equals(b.getModifier(modifier)))
////			if(a.getCreated(created).equals(b.getCreated(created)))
////			if(a.getModified(modified).equals(b.getModified(modified)))
////			if(a.getOther(other).equals(b.getOther(other)))
////			if(a.getDefaultImgUrl(defaultImgUrl).equals(b.getDefaultImgUrl(defaultImgUrl)))
////			if(a.getOpenImgUrl(openImgUrl).equals(b.getOpenImgUrl(openImgUrl)))
////			if(a.getPinFileName(pinFileName).equals(b.getPinFileName(pinFileName)))
////			if(a.getGiftPinNum(giftPinNum).equals(b.getGiftPinNum(giftPinNum)))
////			if(a.getYiLingQuNum(yiLingQuNum).equals(b.getYiLingQuNum(yiLingQuNum)))
//
//
//}
