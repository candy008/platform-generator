Ext.define('${cfb.packageName}.${cfb.packageSuffix}.${tb.fUpperTName}Model', {
	extend : 'Ext.data.Model',
    alias:'widget.${tb.fLowerTName}Model',
    fields:[ 
    	<#list tb.columns as item>
	    <#if item.javaPackage == "java.util.Date" >
  		{type:'date',mapping:'${item.fLowerColName}', name:'${tb.fLowerTName}.${item.fLowerColName}',dateFormat: 'Y-m-d H:i:s'},
		<#elseif item.javaPackage == "java.util.Integer"  >
		{type:'int',mapping:'${item.fLowerColName}',name:'${tb.fLowerTName}.${item.fLowerColName}' },
		<#else>
		{type:'string',mapping:'${item.fLowerColName}',name:'${tb.fLowerTName}.${item.fLowerColName}' },
		</#if>
		</#list>
    ],
});
