Ext.define('${cfb.packageName}.${cfb.packageSuffix}.${tb.fUpperTName}Form', {
    extend: 'platform.common.form.CommonForm',
    alias: 'widget.${tb.fLowerTName}Form',
    url: basePath+'/permit/${tb.fLowerTName}/insertOrUpdata.action',
    moduleCode:'',
    moduleValue:'${tb.fLowerTName}Form',
    windowTitle:'操作编辑',
    items:[
        <#list tb.columns as item>
	    <#if item.javaPackage == "java.util.Date" >
	    {xtype: 'datefield', fieldLabel:'${item.remarks}', name:'${tb.fLowerTName}.${item.fLowerColName}',format:'Y-m-d H:i:s'},
		<#else>
		{xtype: 'textfield', fieldLabel:'${item.remarks}', name:'${tb.fLowerTName}.${item.fLowerColName}'},
		</#if>
		</#list>
	],
	afterSaveSuccess:function(form,action){
		var result = action.result.result.${tb.fLowerTName};
		var fieldIdObj = form.findField("${tb.fLowerTName}.id");
		fieldIdObj.setValue(result.id);
		Ext.Msg.show({
		     title:'保存',
		     msg: '保存成功！',
		     buttons: Ext.Msg.OK ,
		     icon: Ext.Msg.QUESTION,
       });
	},
    initComponent: function() {
        this.callParent(arguments);
    }
});


