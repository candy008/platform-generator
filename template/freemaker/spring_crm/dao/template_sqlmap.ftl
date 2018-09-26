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
        <#list tb.columns as item>
        	<#if (item.columnName)=="del_state">
       	 ifnull(del_state,0) = 0
        </#if>
        </#list>
        <#assign x=0 />
        <#list tb.columns as item>
        <#if x==0>
        	<#if (item.javaType)!="String">
        	<if test="${item.fLowerColName} != null" >
				and ${item.columnName} = #${"{${item.fLowerColName}}"}
			</if>
			<#else>
        	<if test="${item.fLowerColName} != null and ${item.fLowerColName} != ''" >
				and ${item.columnName} = #${"{${item.fLowerColName}}"}
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
	<sql id="updateByCondition">
        <where>
         <#list tb.columns as item>
        	<#if (item.columnName)=="del_state">
       	 ifnull(del_state,0) = 0
        </#if>
        </#list>
        <#assign x=0 />
        <#list tb.columns as item>
        	<#if x==0>
	            <#if (item.javaType)!="String">
		    	<if test="parameter.${item.fLowerColName} != null" >
					and	${item.columnName} = #${"{parameter.${item.fLowerColName}}"}
				</if>
				<#else>
				<if test="parameter.${item.fLowerColName} != null and parameter.${item.fLowerColName} != ''" >
					and ${item.columnName} = #${"{parameter.${item.fLowerColName}}"}
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
			(<#list tb.columns as item>${item.columnName}<#if item_has_next>,</#if></#list> ) 
		values 
			(<#list tb.columns as item>#${"{${item.fLowerColName},jdbcType=${item.jdbcType}}"}<#if item_has_next>,</#if></#list>)
    </insert>
    
    <!-- 批量新增 -->	
	<insert id="insertBatch${tb.fUpperTName}" parameterType="java.util.List">
       insert into ${tb.tableName}
			(<#list tb.columns as item>${item.columnName}<#if item_has_next>,</#if></#list> ) 
	   values
	    <foreach collection="list" item="obj" index="index" separator="," >
	    	(<#list tb.columns as item>#${"{obj.${item.fLowerColName}}"}<#if item_has_next>,</#if></#list>)
	    </foreach>
   </insert>
    
    <#list tb.columns as item>
    <#if (item.columnName)=="del_state">
	<!-- 根据id进行逻辑删除 (修改数据库数据为删除状态) -->
    <update id="logicDelete${tb.fUpperTName}ById" parameterType="${tb.fLowerTName}Query" >
    	update ${tb.tableName} <#if (tb.tableKey?size>0) > set del_state=1 where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> </#if>
    </update>
    
    <!-- 根据条件进行逻辑删除  (修改数据库数据为删除状态)-->
    <update id="logicDelete${tb.fUpperTName}ByCondition" parameterType="${tb.fLowerTName}Query" >
    	update ${tb.tableName} set del_state=1<include refid="condition" /> 
    </update>
    
    <!-- 根据条件进行逻辑删除  (修改数据库数据为删除状态)-->
    <update id="logicDelete${tb.fUpperTName}ByBatchId" parameterType="map" >
    	update ${tb.tableName} set del_state=1 
    	where 
    	<#assign x=1 />
    	<#list tb.tableKey as item>
    	${item.keyStr} in 
    	<foreach item="item" index="index" collection="batchId${x}" open="(" separator="," close=")">
    		#${"{item}"} <#assign x=x+1 />
    	</foreach>
    	<#if item_has_next> and </#if>
    	</#list>
    </update>
    </#if>
    </#list>
    
    <!-- 根据id删除 (删除数据库数据)-->
    <delete id="delete${tb.fUpperTName}ById" parameterType="${tb.fLowerTName}Query" >
    	delete from ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> </#if>
    </delete>
    
    <!-- 根据条件删除 (删除数据库数据)-->
    <delete id="delete${tb.fUpperTName}ByCondition" parameterType="${tb.fLowerTName}Query" >
    	delete from 
    	${tb.tableName}<include refid="condition" /> 
    </delete>
    
    <!-- 根据主键批量删除 (删除数据库数据)-->
    <delete id="delete${tb.fUpperTName}ByBatchId" parameterType="map" >
    	delete from ${tb.tableName} 
    	where
		<#assign x=1 />
    	<#list tb.tableKey as item>
    	${item.keyStr} in 
    	<foreach item="item" index="index" collection="batchId${x}" open="(" separator="," close=")">
    		#${"{item}"} <#assign x=x+1 />
    	</foreach>
    	<#if item_has_next> and </#if>
    	</#list>
    </delete>
    
    <!-- 根据id修改 -->
    <update id="update${tb.fUpperTName}ById" parameterType="${tb.fLowerTName}Query">
		update  ${tb.tableName} 
		<set>
<#list tb.columns as item>
	<#assign x=0 />
	<#if tb.tableKey?size gt 0 >
		<#list tb.tableKey as items>
			<#if items.fLowerkey != item.fLowerColName>
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
			<#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> 
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
				<#if items.fLowerkey != item.fLowerColName>
					<#assign x=1 />	
				</#if>
			</#list>
		<#else>
			<#assign x=1 />	
		</#if>
		<#if x=1>
			 <#if (item.javaType)!="String">
		 		<if test="record.${item.fLowerColName} != null">
					${item.columnName} = #${"{record.${item.fLowerColName}}"},
				</if>
			<#else>
				<if test="record.${item.fLowerColName} != null and record.${item.fLowerColName} != ''">
					${item.columnName} = #${"{record.${item.fLowerColName}}"},
				</if>
			</#if>
		</#if>
	</#list>
		</set>
		<#if (tb.tableKey?size>0) > 
		<include refid="updateByCondition" />
		</#if>
    </update>
    
    <!-- 根据主键进行批量修改 -->
    <update id="update${tb.fUpperTName}ByBatchId"  parameterType="java.util.List">
    	<if test="list != null">
	     <foreach collection="list" item='obj' separator=";" >
	     update ${tb.tableName}
	     <set>
	<#list tb.columns as item>
		<#assign x=0 />
		<#if tb.tableKey?size gt 0 >
			<#list tb.tableKey as items>
				<#if items.fLowerkey != item.fLowerColName>
					<#assign x=1 />	
				</#if>
			</#list>
		<#else>
			<#assign x=1 />	
		</#if>
		<#if x=1>
			 <#if (item.javaType)!="String">
		 		<if test="obj.${item.fLowerColName} != null">
					${item.columnName} = #${"{obj.${item.fLowerColName}}"},
				</if>
			<#else>
				<if test="obj.${item.fLowerColName} != null and obj.${item.fLowerColName} != ''">
					${item.columnName} = #${"{obj.${item.fLowerColName}}"},
				</if>
			</#if>
		</#if>
	</#list>
			</set>
			<#if (tb.tableKey?size>0) > 
			where
				<#list tb.tableKey as item>${item.keyStr} = #${"{obj.${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> 
			</#if>
	     </foreach>
     	</if>
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
		SELECT count(1) from  ${tb.tableName}
		<include refid="condition" />
	</select>
	
	<!-- 分页查询 -->
	<select id="get${tb.fUpperTName}ByPage" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
		SELECT <include refid="${tb.fLowerTName}Field" /> from ${tb.tableName}
		<include refid="condition" />
		<if test="sort !=null">
		    ORDER BY ${"$"}{sort} ${"$"}{order} 
		</if>
		<![CDATA[LIMIT #${"{startRow}"}, #${"{endRow}"} ]]>
	</select>
	
	<!-- 根据Id查询 -->
	<select id="get${tb.fUpperTName}ById" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
		SELECT <include refid="${tb.fLowerTName}Field" /> from  ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"} 
		<#list tb.columns as item>
    	<#if (item.columnName)=="del_state">
		and ifnull(del_state,0) = 0
    	</#if>
    	</#list> 
		<#if item_has_next> and </#if></#list> </#if>
	</select>
    
</mapper>
