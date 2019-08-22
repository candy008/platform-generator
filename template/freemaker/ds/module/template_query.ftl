package ${cfb.packageName}.${cfb.packageSuffix};

<#list tb.packageMap?keys as key> 
import ${tb.packageMap[key]};
</#list>
<#list tb.columns as item>
<#if item.javaType == "BigDecimal">
import java.math.BigDecimal;
</#if>
</#list>
<#list tb.tableKey as item>
import java.util.List;
</#list>

import java.io.Serializable;
<#if  cfb.parentPackageName!="" >
	<#if cfb.parentClassName!="">
import ${cfb.parentPackageName}.${cfb.parentClassName};
	</#if>
</#if>



/**
 * ${tb.remarks}查询实体
 * 
 * @author administrator
 */
public class ${tb.fUpperTName}Query <#if  cfb.parentClassName!="" >extends ${cfb.parentClassName}</#if> implements Serializable {

	private static final long serialVersionUID = 1L;

	<#list tb.columns as item>
	/** ${item.remarks} **/
	private ${item.javaType} ${item.fLowerColName};
	</#list>
	
	<#list tb.tableKey as item>
	/** 主键集合List **/
	private List<String> ${item.fLowerkey}List;
    </#list>
	
	<#list tb.columns as item>

	/**
	 * 设置${item.remarks}
	 * @param ${item.fLowerColName} ${item.remarks}
	 */
	public void set${item.fUpperColName}(${item.javaType} ${item.fLowerColName}) {
		this.${item.fLowerColName} =  ${item.fLowerColName};
	}
	
	/**
	 * 获取${item.remarks}
     * @return ${item.javaType} ${item.remarks}
	 */
	public ${item.javaType} get${item.fUpperColName}() {
		return ${item.fLowerColName};
	}
	</#list>
	
	<#list tb.tableKey as item>
	/**
	 * 设置主键集合
	 * @param ${item.fLowerkey}List 主键集合
	 */
	public void set${item.fUpperkey}List(List<String> ${item.fLowerkey}List) {
		this.${item.fLowerkey}List =  ${item.fLowerkey}List;
	}
	
	/**
	 * 获取主键集合
     * @return List<String> 主键集合
	 */
	public List<String> get${item.fUpperkey}List() {
		return ${item.fLowerkey}List;
	}	
    </#list>
    
}