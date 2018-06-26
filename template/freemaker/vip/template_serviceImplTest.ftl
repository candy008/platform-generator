package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.platform.base.utils.page.PaginatedList;
import com.platform.base.utils.page.impl.PaginatedArrayList;

import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}Query;
import ${cfb.packageName}.manager.${mytagprizepackage}.${tb.fUpperTName}Manager;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "classpath:spring-config.xml")
public class ${tb.fUpperTName}${cfb.fileNameSuffix}{

	@Autowired
	private ${tb.fUpperTName}Manager ${tb.fLowerTName}Manager;

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
	
		${tb.fLowerTName}Manager.insert${tb.fUpperTName}(${tb.fLowerTName});	
	}
	
	@Test
	public void delete${tb.fUpperTName}ById(){
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		${tb.fLowerTName}Manager.delete${tb.fUpperTName}ById(${tb.fLowerTName});	
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
		
		${tb.fLowerTName}Manager.update${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Test
	public void get${tb.fUpperTName}ById(){
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		${tb.fLowerTName}Manager.get${tb.fUpperTName}ById(${tb.fLowerTName});
	}
	
	@Test
	public void get${tb.fUpperTName}All(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Manager.get${tb.fUpperTName}All(${tb.fLowerTName}Query);
	}
	
	@Test
	public void get${tb.fUpperTName}ByPage(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		PaginatedList<${tb.fUpperTName}> ${tb.fLowerTName}PageList = new PaginatedArrayList<${tb.fUpperTName}>(${tb.fLowerTName}Query.getIndex(), ${tb.fLowerTName}Query.getPageSize());
		int total = ${tb.fLowerTName}Manager.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.setTotalItem(total);
		${tb.fLowerTName}Query.setStartRow(${tb.fLowerTName}PageList.getStartRow());
		${tb.fLowerTName}Query.setEndRow(${tb.fLowerTName}PageList.getEndRow());
		List<${tb.fUpperTName}> ${tb.fLowerTName}List = ${tb.fLowerTName}Manager.get${tb.fUpperTName}ByPage(${tb.fLowerTName}Query);
		${tb.fLowerTName}PageList.addAll(${tb.fLowerTName}List);
		
	}
	
	@Test
	public void get${tb.fUpperTName}ByPageCount(){
		${tb.fUpperTName}Query ${tb.fLowerTName}Query = new ${tb.fUpperTName}Query();
		${tb.fLowerTName}Manager.get${tb.fUpperTName}ByPageCount(${tb.fLowerTName}Query);
	}
	
	public void set${tb.fUpperTName}Manager(${tb.fUpperTName}Manager  ${tb.fLowerTName}Manager){
		this.${tb.fLowerTName}Manager = ${tb.fLowerTName}Manager;
	}
	
}