package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bawie.common.base.page.PaginatedList;
import com.bawie.common.base.page.impl.PaginatedArrayList;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class ${tb.fUpperTName}${cfb.fileNameSuffix}{

	@Autowired
	private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;

	@Test
	public void insert${tb.fUpperTName}(){
	
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}.set${item.fUpperColName}(0);
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
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		${tb.fLowerTName}Service.delete${tb.fUpperTName}ById(${tb.fLowerTName});	
	}
	
	@Test
	public void update${tb.fUpperTName}ById(){
		
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Date">
		${tb.fLowerTName}.set${item.fUpperColName}(new Date());
		<#else>
		${tb.fLowerTName}.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		${tb.fLowerTName}Service.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Test
	public void get${tb.fUpperTName}ById(){
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		${tb.fLowerTName}Service.get${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Test
	public void get${tb.fUpperTName}All(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Service.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	@Test
	public void get${tb.fUpperTName}ByPage(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		PaginatedList<${tb.fUpperTName}> ${tb.fLowerTName}PageList = new PaginatedArrayList<${tb.fUpperTName}>(${tb.fLowerTName}Query.getIndex(), ${tb.fLowerTName}Query.getPageSize());
		int total = ${tb.fLowerTName}Service.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.setTotalItem(total);
		${tb.fLowerTName}Query.setStartRow(${tb.fLowerTName}PageList.getStartRow());
		${tb.fLowerTName}Query.setEndRow(${tb.fLowerTName}PageList.getEndRow());
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Service.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.addAll(${tb.fLowerTName}List);
		
	}
	
	@Test
	public void get${tb.fUpperTName}ByPageCount(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Service.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
	
	public void set${tb.fUpperTName}Service(${tb.fUpperTName}Service  ${tb.fLowerTName}Service){
		this.${tb.fLowerTName}Service = ${tb.fLowerTName}Service;
	}
	
}