package ${cfb.packageName}.${cfb.packageSuffix};

<#list tb.columns as item>
<#if item.javaPackage!="" >
import ${item.javaPackage};
</#if>
</#list>
import java.io.Serializable;


public class ${tb.fUpperTName} implements Serializable{

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