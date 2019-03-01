<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE struts PUBLIC
        "-//Apache Software Foundation//DTD Struts Configuration 2.0//EN"
        "http://struts.apache.org/dtds/struts-2.0.dtd">

<struts>
	<package name="${tb.fLowerTName}" namespace="/${tb.fLowerTName}" extends="struts-permit">
		
		<!-- 查询所有跳转到${tb.fUpperTName}的首页 -->
		<action name="to${tb.fUpperTName}Page" class="${cfb.packageName}.action.${mytagprizepackage1}.${tb.fUpperTName}Action" method="to${tb.fUpperTName}Page">
			<result name="to${tb.fUpperTName}Page">/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}.vm</result>
		</action>
		
		<!-- 获取分页数据 -->
		<action name="get${tb.fUpperTName}ByPage" class="${cfb.packageName}.action.${mytagprizepackage1}.${tb.fUpperTName}Action" method="get${tb.fUpperTName}ByPage"></action>
		
		<!-- 根据id查找 -->
		<action name="get${tb.fUpperTName}ById" class="${cfb.packageName}.action.${mytagprizepackage1}.${tb.fUpperTName}Action" method="get${tb.fUpperTName}ById"></action>

		<!-- 添加或删除 -->
		<action name="insertOrUpdate" class="${cfb.packageName}.action.${mytagprizepackage1}.${tb.fUpperTName}Action" method="insertOrUpdate"></action>

		<!-- 根据id批量删除 -->
		<action name="delete${tb.fUpperTName}ByIdBatch" class="${cfb.packageName}.action.${mytagprizepackage1}.${tb.fUpperTName}Action" method="delete${tb.fUpperTName}ByIdBatch"></action>

	</package>
</struts>