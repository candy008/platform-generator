<?xml version="1.0" encoding="utf-8" ?>
<!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd" >
<sqlMap namespace="${tb.fUpperTName}">

	<typeAlias alias="${tb.fUpperTName}" type="${cfb.packageName1}.domain.${mytagprizepackage}.${tb.fUpperTName}" />
	<typeAlias alias="${tb.fUpperTName}Query" type="${cfb.packageName1}.domain.${mytagprizepackage}.query.${tb.fUpperTName}Query" />
	
	<resultMap id="${tb.fUpperTName}Result" class="${tb.fUpperTName}">
		<#list tb.columns as item>
		<result property="${item.fLowerColName}" column="${item.columnName}" />
		</#list>
	</resultMap>
	
	<sql id="${tb.fUpperTName}Field">
		<#list tb.columns as item>${item.columnName}<#if item_has_next>,</#if></#list>
	</sql>
	
	<sql id="condition">
        <dynamic prepend="where">
        <#list tb.columns as item>
        	<#if (item.javaType)="Integer">
			<isNotNull prepend="and" property="${item.fLowerColName}" >
				${item.columnName} = #${item.fLowerColName}#
			</isNotNull>
			<#elseif (item.javaType)!="Long" >
			<isNotNull prepend="and" property="${item.fLowerColName}" >
				${item.columnName} = #${item.fLowerColName}#
			</isNotNull>
			<#else>
			<isNotEmpty prepend="and" property="${item.fLowerColName}" >
				${item.columnName} = #${item.fLowerColName}#
			</isNotEmpty>
			</#if>
		</#list>
        </dynamic>
    </sql>
    
    <insert id="insert${tb.fUpperTName}" parameterClass="${tb.fUpperTName}">
		insert into ${tb.tableName}
			(<#list tb.columns as item><#assign x=0 /><#list tb.tableKey as items><#if items.fUpperkey != item.columnName><#assign x=1 /></#if></#list><#if x==1> ${item.columnName}<#if item_has_next>,</#if></#if></#list>) 
		values 
			(<#list tb.columns as item><#assign x=0 /><#list tb.tableKey as items><#if items.keyStr != item.fLowerColName><#assign x=1 /></#if></#list><#if x==1> #${item.fLowerColName}#<#if item_has_next>,</#if></#if></#list>)	
    	<selectKey resultClass="Long"  keyProperty="id" >    
             SELECT last_insert_id() as id ;   
        </selectKey>   
    </insert>
    
    <update id="update${tb.fUpperTName}ById" parameterClass="${tb.fUpperTName}">
		update  ${tb.tableName} 
		<dynamic prepend="set">
		<#list tb.columns as item>
			<#assign x=0 />
		     <#list tb.tableKey as items>
		     	<#if items.keyStr != item.fLowerColName>
					<#assign x=1 />	
				</#if>
		     </#list>
		     <#if x=1>
        	<#if (item.javaType)="Integer">
			<isNotNull prepend="," property="${item.fLowerColName}" >
				${item.columnName} = #${item.fLowerColName}#
			</isNotNull>
			<#elseif  (item.javaType)="Long" >
			<isNotNull prepend="," property="${item.fLowerColName}" >
				${item.columnName} = #${item.fLowerColName}#
			</isNotNull>
			<#else>
			<isNotEmpty prepend="," property="${item.fLowerColName}" >
				${item.columnName} = #${item.fLowerColName}#
			</isNotEmpty>
			</#if>
			</#if>
		</#list>
		</dynamic>
		<#if (tb.tableKey?size>0) > 
		where
			<#list tb.tableKey as item>
			${item.keyStr} = #${item.fLowerkey}#<#if item_has_next>and</#if>
			</#list> 
		</#if>
     </update>


     <delete id="delete${tb.fUpperTName}ById" parameterClass="long" >
    	delete from ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${item.fLowerkey}#<#if item_has_next>and</#if></#list> </#if>
    </delete>
	
	<select id="get${tb.fUpperTName}All" resultMap="${tb.fUpperTName}Result">
		SELECT 
			<include refid="${tb.fUpperTName}Field" />  
		from  
			${tb.tableName} $sortname$
	</select>

	<select id="get${tb.fUpperTName}ById" parameterClass="long" resultMap="${tb.fUpperTName}Result">
		SELECT <include refid="${tb.fUpperTName}Field" /> from  ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${item.fUpperkey}#<#if item_has_next>and</#if></#list> </#if>
	</select>
	
	<select id="get${tb.fUpperTName}ByPageCount" parameterClass="${tb.fUpperTName}Query" resultClass="int">
		SELECT count(*) from  ${tb.tableName}
		<include refid="condition" />
		$sortname$
	</select>
	
	<select id="get${tb.fUpperTName}ByPage" parameterClass="${tb.fUpperTName}Query" resultMap="${tb.fUpperTName}Result">
		SELECT <include refid="${tb.fUpperTName}Field" />  from  ${tb.tableName}
		<include refid="condition" />
		$sortname$ <![CDATA[ LIMIT #startRow#,#endRow#]]>
	</select>
    
</sqlMap>
