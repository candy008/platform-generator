<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${tb.fLowerTName}">

	<!-- 結果集 -->
	<resultMap id="${tb.fLowerTName}Result" type="${cfb.packageName}.domain.${mytagprizepackage}.${tb.fUpperTName}">
		<#list tb.columns as item>
		<result property="${item.fLowerColName}" column="${item.columnName}" />
		</#list>
	</resultMap>
	
	<!-- 查询字段-->
	<sql id="${tb.fLowerTName}Field">
		<#list tb.columns as item>${item.columnName}<#if item_has_next>,</#if></#list>
	</sql>
	
	<!-- 查询条件 -->
	<sql id="condition">
        <where>
        <#assign x=0 />
        <#list tb.columns as item>
        <#if x==0>
        	<#if (item.javaType)!="String">
        	<if test="${item.fLowerColName} != null" >
				${item.columnName} = #${"{${item.fLowerColName}}"}
			</if>
			<#else>
        	<if test="${item.fLowerColName} != null and ${item.fLowerColName} != ''" >
				${item.columnName} = #${"{${item.fLowerColName}}"}
			</if>
			</#if>
		<#else>
			<#if (item.javaType)!="String">
        	<if test="${item.fLowerColName} != null" >
				and ${item.columnName} = #${"{${item.fLowerColName}}"}
			</if>
			<#else>
        	<if test="${item.fLowerColName} != null and ${item.fLowerColName} != ''" >
				and ${item.columnName} = #${"{${item.fLowerColName}}"}
			</if>
			</#if>
		</#if>
		<#assign x=1 />
		</#list>
        </where>
    </sql>
    
    <!-- 修改条件 -->
	<sql id="updateDemoByCondition">
        <where>
        <#assign x=0 />
        <#list tb.columns as item>
        	<#if x==0>
	            <#if (item.javaType)!="String">
		    	<if test="parameter.${item.fLowerColName} != null" >
					${item.columnName} = #${"{parameter.${item.fLowerColName}}"}
				</if>
				<#else>
				<if test="parameter.${item.fLowerColName} != null and parameter.${item.fLowerColName} != ''" >
					${item.columnName} = #${"{parameter.${item.fLowerColName}}"}
				</if>
				</#if>
			<#else>
				 <#if (item.javaType)!="String">
		    	<if test="parameter.${item.fLowerColName} != null" >
					and ${item.columnName} = #${"{parameter.${item.fLowerColName}}"}
				</if>
				<#else>
				<if test="parameter.${item.fLowerColName} != null and parameter.${item.fLowerColName} != ''" >
					and ${item.columnName} = #${"{parameter.${item.fLowerColName}}"}
				</if>
				</#if>
			</#if>
			<#assign x=1 />
		</#list>
        </where>
    </sql>
    
    <!-- 新增 -->
	<insert id="insert${tb.fUpperTName}" parameterType="${tb.fLowerTName}">
		insert into ${tb.tableName}
			(<#list tb.columns as item><#assign x=0 /><#if tb.tableKey?size gt 0 ><#list tb.tableKey as items><#if items.fUpperkey != item.columnName><#assign x=1 /></#if></#list><#else><#assign x=1 /></#if><#if x==1>${item.columnName}<#if item_has_next>,</#if></#if></#list> ) 
		values 
			(<#list tb.columns as item><#assign x=0 /><#if tb.tableKey?size gt 0><#list tb.tableKey as items><#if items.keyStr != item.fLowerColName><#assign x=1 /></#if></#list><#else><#assign x=1 /></#if><#if x==1>#${"{${item.fLowerColName}}"}<#if item_has_next>,</#if></#if></#list>)
    </insert>
    
    <!-- 根据id删除 -->
    <delete id="delete${tb.fUpperTName}ById" parameterType="java.lang.Long" >
    	delete from ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"}#<#if item_has_next>and</#if></#list> </#if>
    </delete>
    
    <!-- 根据条件删除 -->
    <delete id="delete${tb.fUpperTName}ByCondition" parameterType="${tb.fLowerTName}Query" >
    	delete 
    	from 
    	${tb.tableName}<include refid="condition" /> 
    </delete>
    
    <!-- 根据id修改 -->
    <update id="update${tb.fUpperTName}ById" parameterType="java.lang.Long">
		update  ${tb.tableName} 
		<set>
<#list tb.columns as item>
	<#assign x=0 />
	<#if tb.tableKey?size gt 0 >
		<#list tb.tableKey as items>
			<#if items.keyStr != item.fLowerColName>
				<#assign x=1 />	
			</#if>
		</#list>
	<#else>
		<#assign x=1 />	
	</#if>
	<#if x=1>
		 <#if (item.javaType)!="String">
			<if test="${item.fLowerColName} != null " >
				${item.columnName} = #${"{${item.fLowerColName}}"},
			</if>
		<#else>
			<if test="${item.fLowerColName} != null and ${item.fLowerColName} != '' " >
				${item.columnName} = #${"{${item.fLowerColName}}"},
			</if>
		</#if>
	</#if>
</#list>
		</set>
		<#if (tb.tableKey?size>0) > 
		where
			<#list tb.tableKey as item>
			${item.keyStr} = #${"{${item.fLowerkey}}"}<#if item_has_next>and</#if>
			</#list> 
		</#if>
    </update>
    
     <!-- 根据条件修改 -->
    <update id="update${tb.fUpperTName}ByCondition" parameterType="map">
		update  ${tb.tableName} 
		<set>
<#list tb.columns as item>
	<#assign x=0 />
	<#if tb.tableKey?size gt 0 >
		<#list tb.tableKey as items>
			<#if items.keyStr != item.fLowerColName>
				<#assign x=1 />	
			</#if>
		</#list>
	<#else>
		<#assign x=1 />	
	</#if>
	<#if x=1>
		 <#if (item.javaType)!="String">
			<if test="record.${item.fLowerColName} != null " >
				${item.columnName} = #${"{record.${item.fLowerColName}}"},
			</if>
		<#else>
			<if test="record.${item.fLowerColName} != null and record.${item.fLowerColName} != '' " >
				${item.columnName} = #${"{record.${item.fLowerColName}}"},
			</if>
		</#if>
		
	</#if>
</#list>
		</set>
		<#if (tb.tableKey?size>0) > 
		<include refid="updateDemoByCondition" />
		</#if>
    </update>
    
    <!-- 查询所有 -->
    <select id="get${tb.fUpperTName}All" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
		SELECT 
		<include refid="${tb.fLowerTName}Field" />  
		from  
		${tb.tableName}<include refid="condition" />
	</select>
	
	<!-- 分页查询总数 -->
	<select id="get${tb.fUpperTName}ByPageCount" parameterType="${tb.fLowerTName}Query" resultType="int">
		SELECT count(*) from  ${tb.tableName}
		<include refid="condition" />
	</select>
	
	<!-- 分页查询 -->
	<select id="get${tb.fUpperTName}ByPage" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
		SELECT <include refid="${tb.fLowerTName}Field" />  from  ${tb.tableName}
		<include refid="condition" />
		<if test="sortname !=null">
		ORDER BY ${"$"}{sortname} ${"$"}{sortorder} 
		</if>
		LIMIT #${"{startRow}"},#${"{endRow}"}
	</select>
	
	<!-- 根据Id查询 -->
	<select id="get${tb.fUpperTName}ById" parameterType="java.lang.Long" resultMap="${tb.fLowerTName}Result">
		SELECT <include refid="${tb.fLowerTName}Field" /> from  ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fUpperkey}}"}<#if item_has_next>and</#if></#list> </#if>
	</select>
    
</mapper>
