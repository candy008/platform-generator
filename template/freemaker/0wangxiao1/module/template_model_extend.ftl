package ${cfb.packageName}.${cfb.packageSuffix};
<#if cfb.parentPackageName!="">
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>

/**
 * ${tb.remarks}实体扩展
 * 
 * @author administrator
 */
public class ${tb.fUpperTName}Extend extends ${tb.fUpperTName} {

	private static final long serialVersionUID = 1L;
	
}