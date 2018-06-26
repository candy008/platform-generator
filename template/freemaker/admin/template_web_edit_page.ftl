<!-- ${tb.fLowerTName} insert start -->
<div id="${tb.fLowerTName}EditWin"  style="width:200px" >
	<form id="${tb.fLowerTName}EditForm" method="post" action="$homeModule.getTarget("/${tb.fLowerTName}/insertOrUpdate")" >
		<table cellpadding="5" fit="true" style="width:100%">
			<#list tb.columns as item>
			<tr>
    			<td style="width:10%" nowrap>${item.remarks}:</td>
    			<td style="width:90%" >
    				<input class="easyui-textbox" type="text" name="${item.fLowerColName}" style="width:100%"  />
    			</td>
			</tr>
        	</#list>
		</table>
	</form>
</div>
<!-- ${tb.fLowerTName} insert start -->

<!-- ${tb.fLowerTName} insert toolbar start -->
<div id="${tb.fLowerTName}EditWinTb" style="height: auto">
	<a href="javascript:void(0)" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save',plain:true">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton close-btn" data-options="iconCls:'icon-no',plain:true">关闭</a>
</div>
<!-- ${tb.fLowerTName} insert toolbar start -->

<!-- ${tb.fLowerTName} insert toolbar start -->
<div id="${tb.fLowerTName}EditWinbbar" style="height: auto">
	<a href="javascript:void(0)" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton clear-btn" id="clearFormId" data-options="iconCls:'icon-clear'">重置</a>
	<a href="javascript:void(0)" class="easyui-linkbutton close-btn" data-options="iconCls:'icon-no'">关闭</a>
</div>
<!-- ${tb.fLowerTName} insert toolbar start -->

<script>

	/**
	 * window 编辑窗口初始化
	 */
	jQuery(function(){
		//初始化windows
		jQuery('#${tb.fLowerTName}EditWin').dialog({
			width:500,
			height: 370,
			title:'${tb.fLowerTName}',
			maximizable:true,
			modal:true,
			closed:true,
			iconCls:'icon-save',
			buttons:'#${tb.fLowerTName}EditWinbbar',
			toolbar:'#${tb.fLowerTName}EditWinTb',
			onClose:function(){
				//当关闭窗口是清楚form表单
				clearForm('${tb.fLowerTName}EditForm');
			}
		})
	})
	
	
	/*
	 * 保存
	 */
	jQuery('#${tb.fLowerTName}EditWinTb .save-btn,#${tb.fLowerTName}EditWinbbar .save-btn').click(function(){
		saveData('${tb.fLowerTName}DataGrid','search${tb.fUpperTName}FormId','${tb.fLowerTName}EditForm','${tb.fLowerTName}EditWin');
	})
	
	/*
	 * 关闭窗口
	 */
	jQuery('#${tb.fLowerTName}EditWinTb .close-btn ,#${tb.fLowerTName}EditWinbbar .close-btn').click(function(){
		jQuery('#${tb.fLowerTName}EditWin').window('close');
	})
	
	/*
	 * 清除表单
	 */
	selectToolbarBtn('${tb.fLowerTName}EditWinbbar','clear-btn').click(function(){
		clearForm('${tb.fLowerTName}EditWin');
	})
	
</script>