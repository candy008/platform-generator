Ext.define('${cfb.packageName}.${cfb.packageSuffix}.${tb.fUpperTName}Store',{
	extend:'platform.common.store.CommonStore',
	model:'${cfb.packageName}.${mytagprizepackage}.model.${tb.fUpperTName}Model',
    alias:'widget.${tb.fLowerTName}Store',
	pageSize : PAGE_SIZE,
	proxy : {
		// 异步获取数据，这里的URL可以改为任何动态页面，只要返回JSON数据即可
		type : 'ajax',
		url : basePath+'/permit/${tb.fLowerTName}/get${tb.fUpperTName}PageList',
		reader : {
			type : 'json',
			root : 'rows',
			totalProperty : 'total'
		}
	},
	autoLoad : true
});
