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
	
	if(berfore.get${item.fUpperColName}().equals(after.get${item.fUpperColName}())){
		insertGiftLog(berfore.getId(),after.getRid(),after.getModifier(),OperationLogType.GIFT_O_LOG_TYPE.getCode(),"${item.remarks}",berfore.get${item.fUpperColName}(),after.get${item.fUpperColName}());
	}
	</#list>
	

}