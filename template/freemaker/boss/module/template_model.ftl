package ${cfb.packageName}.${cfb.packageSuffix};

import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
<#list tb.packageMap?keys as key> 
import ${tb.packageMap[key]};
</#list>

<#if cfb.parentPackageName!="">
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>
import java.io.Serializable;
import java.math.BigDecimal;

public class ${tb.fUpperTName} <#if cfb.parentClassName!=""> extends ${cfb.parentClassName}</#if> implements Serializable{

	private static final long serialVersionUID = 1L;

	<#list tb.columns as item>
	//${item.remarks}
	private ${item.javaType} ${item.fLowerColName};
	</#list>
	
	<#list tb.columns as item>

	public void set${item.fUpperColName}(${item.javaType} ${item.fLowerColName}){
		this.${item.fLowerColName} =  ${item.fLowerColName};
	}
	
	public ${item.javaType} get${item.fUpperColName}(){
		return ${item.fLowerColName};
	}
	</#list>
}