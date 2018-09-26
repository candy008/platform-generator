Ext.define('${cfb.packageName}.${cfb.packageSuffix}.${tb.fUpperTName}Grid', {
	extend : 'platform.common.grid.CommonGrid',
	alias : [ 'widget.${tb.fLowerTName}Grid' ],
	requires : ['${cfb.packageName}.${mytagprizepackage}.model.${tb.fUpperTName}Model'],
	primaryKey:'<#list tb.tableKey as item>${item.fLowerkey}<#if item_has_next>_</#if></#list>',
	moduleCode:'',
    moduleValue:'${tb.fLowerTName}Grid',
    dockedItems:[],
    functionUrls:{
    	deleteUrl:basePath+'/permit/${tb.fLowerTName}/${tb.fLowerTName}Delete.action',
    	saveUrl:'',
    	formClass:'${cfb.packageName}.${cfb.packageSuffix}.${tb.fUpperTName}Form'
    }, 
    columns:[ 
	    <#list tb.columns as item>
	    <#if item.javaPackage == "java.util.Date" >
	    {dataIndex:'${tb.fLowerTName}.${item.fLowerColName}',sortable : true,text:'${item.remarks}',width : 150,renderer : Ext.util.Format.dateRenderer('Y-m-d H:i:s')},
		<#else>
		{dataIndex:'${tb.fLowerTName}.${item.fLowerColName}',sortable:true,text:'${item.remarks}',width:150},
		</#if>
		</#list>
	],
    initComponent: function() {   	
    	var store = Ext.create('${cfb.packageName}.${mytagprizepackage}.store.${tb.fUpperTName}Store');
    	this.store = store;
        this.callParent(arguments);
    }
});
