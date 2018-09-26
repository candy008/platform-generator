package ${cfb.packageName}.${cfb.packageSuffix};
<#if cfb.parentPackageName!="">
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>


public class ${tb.fUpperTName}Extend  extends ${tb.fUpperTName}{

	
}