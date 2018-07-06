package ${cfb.packageName}.${cfb.packageSuffix};

<#list tb.packageMap?keys as key> 
import ${tb.packageMap[key]};
</#list>

<#if cfb.parentPackageName!="">
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>
import java.io.Serializable;

public class ${tb.fUpperTName}Extend extends ${tb.fUpperTName} implements Serializable{

	private static final long serialVersionUID = 1L;

}