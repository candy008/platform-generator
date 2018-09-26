<!-- ${tb.fLowerTName} insert start -->
<div id="${tb.fLowerTName}InsertWin"  style="width:200px" >
	<form id="${tb.fLowerTName}InsertForm" method="post" action="$homeModule.getTarget("/${tb.fLowerTName}/insertOrUpdate")" >
		<table cellpadding="5" fit="true" style="width:100%">
			<#list tb.columns as item>
			<tr>
    			<td style="width:20px" nowrap>${item.remarks}:</td>
    			<td style="width:480px" >
    				<input class="easyui-textbox" type="text" name="${item.fLowerColName}" style="width:100%"  />
    			</td>
			</tr>
        	</#list>
		</table>
	</form>
</div>
<!-- ${tb.fLowerTName} insert start -->

<!-- ${tb.fLowerTName} insert toolbar start -->
<div id="${tb.fLowerTName}InsertWinTb" style="height: auto">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveData('${tb.fLowerTName}DataGrid','${tb.fLowerTName}InsertForm','${tb.fLowerTName}InsertWin')" data-options="iconCls:'icon-save',plain:true">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="getChanges()"
		data-options="iconCls:'icon-undo',plain:true">打印</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="jQuery('#${tb.fLowerTName}InsertWin').window('close')"
		data-options="iconCls:'icon-cancel',plain:true">关闭</a>
</div>
<!-- ${tb.fLowerTName} insert toolbar start -->

<!-- ${tb.fLowerTName} insert toolbar start -->
<div id="${tb.fLowerTName}InsertWinbbar" style="height: auto">
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="saveData('${tb.fLowerTName}DataGrid','${tb.fLowerTName}InsertForm','${tb.fLowerTName}InsertWin')"
		data-options="iconCls:'icon-save'">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm('${tb.fLowerTName}InsertWin')"
		data-options="iconCls:'icon-cancel'">重置</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="jQuery('#${tb.fLowerTName}InsertWin').window('close')"
		data-options="iconCls:'icon-cancel'">关闭</a>
</div>
<!-- ${tb.fLowerTName} insert toolbar start -->

<script>
    jQuery(function(){
		//初始化windows
        jQuery('#${tb.fLowerTName}InsertWin').dialog({
			width:500,
			height: 370,
            title:'${tb.fLowerTName}',
            collapsible:true,
			minimizable:true,
            maximizable:true,
            modal:true,
			closed:true,
			iconCls:'icon-save',
            buttons:'#${tb.fLowerTName}InsertWinbbar',
			toolbar:'#${tb.fLowerTName}InsertWinTb',
			onClose:function(){
				//当关闭窗口是清楚form表单
				clearForm('${tb.fLowerTName}InsertForm');
			}
        })
    })
</script>