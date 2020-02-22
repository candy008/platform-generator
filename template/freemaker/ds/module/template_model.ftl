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
<#list tb.columns as item>
<#if item.javaType =="BigDecimal">
import java.math.BigDecimal;
</#if>
</#list>


/**
 * ${tb.remarks}实体
 * 
 * @author administrator
 */
public class ${tb.fUpperTName} <#if cfb.parentClassName!=""> extends ${cfb.parentClassName}</#if>implements Serializable {

	private static final long serialVersionUID = 1L;

	<#list tb.columns as item>
	/** ${item.remarks} **/
	private ${item.javaType} ${item.fLowerColName};
	</#list>
	
	<#list tb.columns as item>

	/**
	 * 设置${item.remarks}
	 * @param ${item.fLowerColName} ${item.remarks}
	 */
	public void set${item.fUpperColName}(${item.javaType} ${item.fLowerColName}){
		this.${item.fLowerColName} =  ${item.fLowerColName};
	}
	
	/**
	 * 获取${item.remarks}
	 * @return ${item.javaType} ${item.remarks}
	 */
	public ${item.javaType} get${item.fUpperColName}(){
		return ${item.fLowerColName};
	}
	</#list>
}