<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${cfb.packageName}.mapper.${mytagprizepackage}.${tb.fUpperTName}Mapper">

	<!-- 結果集 -->
	<resultMap id="${tb.fLowerTName}Result" type="${cfb.packageName}.domain.${mytagprizepackage}.${tb.fUpperTName}">
		<#list tb.columns as item>
		<result property="${item.fLowerColName}" column="${item.columnName}" />
		</#list>
	</resultMap>
	
	<!-- 查询字段-->
	<sql id="${tb.fLowerTName}Field"><#list tb.columns as item>${item.columnName}<#if item_has_next>,</#if></#list>
	</sql>
	
	<!-- 查询条件 -->
	<sql id="condition">
        <where>
        	ifnull(dr,0) = 0
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
		<#list tb.tableKey as item>
			<if test="${item.keyStr}List != null and ${item.keyStr}List.size()>0" >
				and ${item.keyStr} in 
				<foreach item="item" index="index" collection="${item.keyStr}List" open="(" separator="," close=")">
    				#${"{item}"} <#assign x=x+1 />
    			</foreach>
			</if>
    	<#if item_has_next> and </#if>
    	</#list>
        </where>
    </sql>
    
    <!-- 修改条件 -->
	<sql id="updateByCondition">
        <where>
        ifnull(dr,0) = 0
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
	<insert id="insert" parameterType="${tb.fLowerTName}">
		insert into ${tb.tableName}(<#list tb.columns as item>${item.columnName}<#if item_has_next>,</#if></#list> ) 
		values (<#list tb.columns as item>#${"{${item.fLowerColName},jdbcType=${item.jdbcType}}"}<#if item_has_next>,</#if></#list>)
    </insert>
    
    <!-- 批量新增 -->	
	<insert id="insertBatch" parameterType="java.util.List">
       insert into ${tb.tableName}(<#list tb.columns as item>${item.columnName}<#if item_has_next>,</#if></#list> ) 
	   values 
	   <foreach collection="list" item="obj" index="index" separator="," >
	 	(<#list tb.columns as item>#${"{obj.${item.fLowerColName}}"}<#if item_has_next>,</#if></#list>)
	   </foreach>
   </insert>
   
    <!-- 根据id进行逻辑删除 (修改数据库数据为删除状态) -->
    <update id="logicDeleteById" parameterType="${tb.fLowerTName}Query" >
    	update ${tb.tableName} <#if (tb.tableKey?size>0) > set dr=1 where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> </#if>
    </update>
    
    <!-- 根据条件进行逻辑删除  (修改数据库数据为删除状态)-->
    <update id="logicDeleteByCondition" parameterType="${tb.fLowerTName}Query" >
    	update ${tb.tableName} set dr=1 <include refid="condition" /> 
    </update>
    
    <!-- 根据条件进行逻辑删除  (修改数据库数据为删除状态)-->
    <update id="logicDeleteByBatchId" parameterType="${tb.fLowerTName}Query" >
    	update ${tb.tableName} set dr=1 
    	<#assign x=1 />
    	<#list tb.tableKey as item>
    	where ${item.keyStr} in 
    	<foreach item="item" index="index" collection="idList" open="(" separator="," close=")">
    		#${"{item}"} <#assign x=x+1 />
    	</foreach><#if item_has_next> and </#if>
    	</#list>
    </update>
    
    <!-- 根据id删除 (删除数据库数据)-->
    <delete id="deleteById" parameterType="${tb.fLowerTName}Query" >
    	delete from ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> </#if>
    </delete>
    
    <!-- 根据条件删除 (删除数据库数据)-->
    <delete id="deleteByCondition" parameterType="${tb.fLowerTName}Query" >
    	delete from ${tb.tableName} <include refid="condition" /> 
    </delete>
    
    <!-- 根据主键批量删除 (删除数据库数据)-->
    <delete id="deleteByBatchId" parameterType="${tb.fLowerTName}Query" >
    	delete from ${tb.tableName}
		<#assign x=1 />
    	<#list tb.tableKey as item>where ${item.keyStr} in 
    	<foreach item="item" index="index" collection="idList" open="(" separator="," close=")">
    		#${"{item}"} <#assign x=x+1 />
    	</foreach>
    	<#if item_has_next> and </#if>
    	</#list>
    </delete>
    
    <!-- 根据id修改 -->
    <update id="updateById" parameterType="${tb.fLowerTName}Query">
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
		where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> 
		</#if>
    </update>
    
     <!-- 根据条件修改 -->
    <update id="updateByCondition" parameterType="map">
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
    <update id="updateByBatchId"  parameterType="java.util.List">
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
			where <#list tb.tableKey as item>${item.keyStr} = #${"{obj.${item.fLowerkey}}"}<#if item_has_next> and </#if></#list> 
			</#if>
	     </foreach>
     	</if>
    </update>
    
    <!-- 查询所有 -->
    <select id="getAll" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
		select <include refid="${tb.fLowerTName}Field" />  from  ${tb.tableName}
		<include refid="condition" />
        <include refid="conditionExtend" />
		<if test="sort !=null">
		    order by ${"$"}{sort} ${"$"}{order} 
		</if>
	</select>

    <!-- 查询所有 -->
    <select id="getAllByMap" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
        select <include refid="${tb.fLowerTName}Field" />  from  ${tb.tableName}
        <include refid="condition" />
        <include refid="conditionExtend" />
        <if test="sort !=null">
            order by ${"$"}{sort} ${"$"}{order}
        </if>
    </select>
	
	<!-- 分页查询总数 -->
	<select id="getByPageCount" parameterType="${tb.fLowerTName}Query" resultType="int">
		select count(*) from  ${tb.tableName}
		<include refid="condition" />
        <include refid="conditionExtend" />
    </select>
	
	<!-- 分页查询 -->
	<select id="getByPage" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
		select <include refid="${tb.fLowerTName}Field" /> from ${tb.tableName}
		<include refid="condition" />
        <include refid="conditionExtend" />
	</select>
	
	<!-- 根据Id查询 -->
	<select id="getById" parameterType="${tb.fLowerTName}Query" resultMap="${tb.fLowerTName}Result">
		select <include refid="${tb.fLowerTName}Field" /> from  ${tb.tableName} <#if (tb.tableKey?size>0) > where <#list tb.tableKey as item>${item.keyStr} = #${"{${item.fLowerkey}}"} and ifnull(dr,0) = 0 <#if item_has_next> and </#if></#list> </#if>
	</select>
    
</mapper>
