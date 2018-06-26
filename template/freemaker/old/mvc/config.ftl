Ext.define('platform.permit.${tb.fLowerTName}.store.${tb.fUpperTName}Model', {
	extend : 'Ext.data.Model',
	alias:'widget.${tb.fLowerTName}Model',
	fields:[ 
	<#list tb.columns as item>
		{type : '${item.typeName}',mapping:'${item.fLowerColName}',name: '${tb.fLowerTName}.${item.fLowerColName}' },
	</#list>
	],
});


	<#list tb.columns as item>
		{xtype: 'textfield', fieldLabel: '${item.remarks}', name: '${tb.fLowerTName}.${item.fLowerColName}'},
	</#list>
		


Ext.define('platform.permit.module.Module', {
    extend: 'Ext.grid.Panel',
    alias: ['widget.${tb.fLowerTName}'],
    requires: [
       'Ext.grid.Panel',
       'Ext.toolbar.Toolbar',
       'platform.permit.${tb.fLowerTName}.${tb.fUpperTName}Tbar'
    ],
    border:false, 
	columnLines : true,
	enableLocking : true,
	animCollapse : false,
	margin : '0 0 0 0',
    tbar:{xtype:'${tb.fUpperTName}Tbar'},
    columns:[ 
	<#list tb.columns as item>
		{dataIndex:'${tb.fLowerTName}.${item.fLowerColName}',sortable:true,text:'${item.remarks}',width:150},
	</#list>
	],
    initComponent: function() {
    	this.store = Ext.create('platform.permit.${tb.fLowerTName}.store.${tb.fUpperTName}GridStore');
        this.callParent(arguments);
    },
	 listeners:{
	
	}
    
});
