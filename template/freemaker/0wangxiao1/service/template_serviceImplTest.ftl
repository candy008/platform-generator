package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.Hashtable;
import java.util.Map;
import javax.annotation.Resource;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.domain.PageRequest;
import org.springframework.test.context.junit4.SpringRunner;
import ${cfb.packageName}.domain.${mytagprizepackage1}.${tb.fUpperTName};
import ${cfb.packageName}.domain.${mytagprizepackage1}.query.${tb.fUpperTName}QueryExtend;
import ${cfb.packageName}.service.${mytagprizepackage}.${tb.fUpperTName}Service;
import com.imfbp.bs.BsTestApplication;
import com.platform.common.utils.tool.InstanceUtils;

<#list tb.columns as item>
<#if item.javaType =="BigDecimal">
import java.math.BigDecimal;
</#if>
</#list>

@RunWith(SpringRunner.class)
@SpringBootTest(classes = BsTestApplication.class)
public class ${tb.fUpperTName}${cfb.fileNameSuffix}{

    @Resource(name="${tb.fLowerTName}Service")
    private ${tb.fUpperTName}Service ${tb.fLowerTName}Service;
	
	@Test
	public void insert${tb.fUpperTName}(){
        for ( int i=0; i<20; i++){
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
            ${tb.fLowerTName}Service.insert(${tb.fLowerTName});
        }
	}
	
	@Test
	public void delete${tb.fUpperTName}ById(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
        ${tb.fLowerTName}QueryExtend.setId("id");
		${tb.fLowerTName}Service.deleteById(${tb.fLowerTName}QueryExtend);
	}
	
	@Test
	public void delete${tb.fUpperTName}ByCondition(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Double">
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="BigDecimal">
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Date">
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}(new Date());
		<#else>
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		${tb.fLowerTName}Service.deleteByCondition(${tb.fLowerTName}QueryExtend);
	}
	

	@Test
	public void delete${tb.fUpperTName}ByBatchId(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
		String batchId = "id,id1";
		${tb.fLowerTName}QueryExtend.setBatchId(batchId);
		${tb.fLowerTName}Service.deleteByBatchId(${tb.fLowerTName}QueryExtend);
	}
	
	@Test
	public void logicDelete${tb.fUpperTName}ById(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
        String batchId = "id,id1";
        ${tb.fLowerTName}QueryExtend.setBatchId(batchId);
		${tb.fLowerTName}Service.logicDeleteById(${tb.fLowerTName}QueryExtend);
	}
	
	@Test
	public void logicDelete${tb.fUpperTName}ByCondition(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Double">
		<#elseif item.javaType=="BigDecimal">
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Date">
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}(new Date());
		<#else>
		${tb.fLowerTName}QueryExtend.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		${tb.fLowerTName}Service.logicDeleteByCondition(${tb.fLowerTName}QueryExtend);
	}
	

	@Test
	public void logicDelete${tb.fUpperTName}ByBatchId(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
		String batchId = "1,2,3";
		${tb.fLowerTName}QueryExtend.setBatchId(batchId);
		${tb.fLowerTName}Service.logicDeleteByBatchId(${tb.fLowerTName}QueryExtend);
	}
	
	@Test
	public void update${tb.fUpperTName}ById(){
		
		${tb.fUpperTName} ${tb.fLowerTName} = new ${tb.fUpperTName}();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		${tb.fLowerTName}.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Double">
		<#elseif item.javaType=="BigDecimal">
		BigDecimal val = new BigDecimal(Math.random());
		val.setScale(2, BigDecimal.ROUND_HALF_UP);
		${tb.fLowerTName}.set${item.fUpperColName}(val);
		<#elseif item.javaType=="Integer">
		${tb.fLowerTName}.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Date">
		${tb.fLowerTName}.set${item.fUpperColName}(new Date());
		<#else>
		${tb.fLowerTName}.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		${tb.fLowerTName}Service.updateById(${tb.fLowerTName});
	}
	
	@Test
	public void update${tb.fUpperTName}ByCondition(){
		
		${tb.fUpperTName} record = new ${tb.fUpperTName}();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		record.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Double">
		record.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="BigDecimal">
		<#elseif item.javaType=="Integer">
		record.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Date">
		record.set${item.fUpperColName}(new Date());
		<#else>
		record.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		${tb.fUpperTName}QueryExtend parameter = new ${tb.fUpperTName}QueryExtend();
		
		<#list tb.columns as item>
		<#if item.javaType=="Long">
		parameter.set${item.fUpperColName}(0l);
		<#elseif item.javaType=="Double">
		parameter.set${item.fUpperColName}(22.2);
		<#elseif item.javaType=="BigDecimal">
		<#elseif item.javaType=="Integer">
		parameter.set${item.fUpperColName}(0);
		<#elseif item.javaType=="Date">
		parameter.set${item.fUpperColName}(new Date());
		<#else>
		parameter.set${item.fUpperColName}("${item.fUpperColName}");
		</#if>
		</#list>
		
		Map<String, Object> data = new Hashtable<String, Object>();
		data.put("record",record);
		data.put("parameter",parameter);
		
		${tb.fLowerTName}Service.updateByCondition(record, parameter);
	}
	
	@Test
	public void get${tb.fUpperTName}ById(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
		${tb.fLowerTName}Service.getById(${tb.fLowerTName}QueryExtend);
	}
	
	@Test
	public void get${tb.fUpperTName}All(){
		${tb.fUpperTName}QueryExtend ${tb.fLowerTName}QueryExtend = new ${tb.fUpperTName}QueryExtend();
		${tb.fLowerTName}Service.getAll(${tb.fLowerTName}QueryExtend);
	}
	
	@Test
	public void get${tb.fUpperTName}ByPage(){
        PageRequest pageRequest = PageRequest.of(1,20);
        Map<String,Object> paramMap = InstanceUtils.newHashMap();
        ${tb.fLowerTName}Service.getByPage(pageRequest,paramMap);
	}
	
	@Test
	public void get${tb.fUpperTName}ByPageCount(){
        Map<String,Object> paramMap = InstanceUtils.newHashMap();
		${tb.fLowerTName}Service.getByPageCount(paramMap);
	}

}