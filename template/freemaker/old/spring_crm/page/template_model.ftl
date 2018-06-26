const ${tb.fUpperTName}Model  = function(options){
	<#list tb.columns as item>
	//${item.remarks}
	this["${item.fLowerColName}"]=""<#if item_has_next>,</#if>
	</#list>
	if(options){
		for(var attr in options )
		this[attr] = options[attr]
	}
}
export default ${tb.fUpperTName}Model