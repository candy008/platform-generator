package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.platform.common.utils.page.PaginatedList;
import com.platform.common.utils.page.impl.MysqlPaginatedArrayList;
import com.platform.common.web.result.EasyUIGridResult;


import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;
import ${cfb.packageName}.dao.${mytagprizepackage}.${tb.fUpperTName}Dao;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class ${tb.fUpperTName}${cfb.fileNameSuffix}{

	@Autowired
	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	@Autowired
	private ${tb.fUpperTName}Dao ${tb.fLowerTName}Dao;

	@Test
	public void insert${tb.fUpperTName}(){
	
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Double">
		${tb.fLowerTName}.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="Date">
		${tb.fLowerTName}.set${item.fUpperColName}(new Date());
		<#else>
		${tb.fLowerTName}.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
	
		${tb.fLowerTName}Service.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	@Test
	public void delete${tb.fUpperTName}ById(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Service.delete${tb.fUpperTName}ById(${tb.fLowerTName}Query);	
	}
	
	@Test
	public void delete${tb.fUpperTName}ByCondition(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}Query.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}Query.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Double">
		${tb.fLowerTName}.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="Date">
		${tb.fLowerTName}Query.set${item.fUpperColName}(new Date());
		<#else>
		${tb.fLowerTName}Query.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		${tb.fLowerTName}Service.delete${tb.fUpperTName}ByCondition(${tb.fLowerTName}Query);	
	}
	
	@Test
	public void update${tb.fUpperTName}ById(){
		
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Double">
		${tb.fLowerTName}.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="Date">
		${tb.fLowerTName}.set${item.fUpperColName}(new Date());
		<#else>
		${tb.fLowerTName}.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		${tb.fLowerTName}Service.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Test
	public void update${tb.fUpperTName}ByCondition(){
		
		${tb.fUpperTName}Query record = new ${tb.fUpperTName}Query();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		record.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Integer">
		record.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Double">
		${tb.fLowerTName}.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="Date">
		record.set${item.fUpperColName}(new Date());
		<#else>
		record.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		${tb.fUpperTName}Query parameter = new ${tb.fUpperTName}Query();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		parameter.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Integer">
		parameter.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Double">
		${tb.fLowerTName}.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="Date">
		parameter.set${item.fUpperColName}(new Date());
		<#else>
		parameter.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		Map<String, Object> data = new Hashtable<String, Object>();
		data.put("record",record);
		data.put("parameter",parameter);
		
		${tb.fLowerTName}Service.update${tb.fUpperTName}ByCondition(record, parameter);
	}
	
	@Test
	public void get${tb.fUpperTName}ById(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Service.get${tb.fUpperTName}ById(${tb.fLowerTName}Query);
	}
	
	@Test
	public void get${tb.fUpperTName}All(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Service.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	@Test
	public void get${tb.fUpperTName}ByPage(){
	
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		//如果排序的字段是空或者空字符串
		if(${tb.fLowerTName}Query!=null&&StringUtils.isBlank(${tb.fLowerTName}Query.getSort())){
			${tb.fLowerTName}Query.setSort("${tb.tableKey[0].fLowerkey}");
			${tb.fLowerTName}Query.setOrder("desc");;
		}
		int total = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
		PaginatedList<${tb.fUpperTName}> ${tb.fLowerTName}PageList = new MysqlPaginatedArrayList<${tb.fUpperTName}>(${tb.fLowerTName}Query,total);
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Dao.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.addAll(${tb.fLowerTName}List);
		EasyUIGridResult<${tb.fUpperTName}> result = new EasyUIGridResult<${tb.fUpperTName}>(${tb.fLowerTName}PageList);
		System.out.println(result);
	}
	
	@Test
	public void get${tb.fUpperTName}ByPageCount(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Service.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
	
	public void set${tb.fUpperTName}Service(${tb.fUpperTName}Service  ${tb.fLowerTName}Service){
		this.${tb.fLowerTName}Service = ${tb.fLowerTName}Service;
	}
	
	public void set${tb.fUpperTName}Dao(${tb.fUpperTName}Dao  ${tb.fLowerTName}Dao){
		this.${tb.fLowerTName}Dao = ${tb.fLowerTName}Dao;
	}
	
}