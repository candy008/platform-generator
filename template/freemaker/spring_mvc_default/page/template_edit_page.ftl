<!-- ${tb.fLowerTName} insert start -->
<div id="${tb.fLowerTName}EditWin"  style="width:200px" >
	<form class="${tb.fLowerTName}EditForm" method="post" action="$homeModule.getTarget("/${tb.fLowerTName}/insertOrUpdate")" >
		<table cellspacing="5" fit="true" style="width:100%">
			<#list tb.columns as item>
			<tr>
    			<td align="right"><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if>:</td>
    			<td>
    				<input class="easyui-validatebox textbox" type="text" name="${item.fLowerColName}" style="width:100%"  />
    			</td>
			</tr>
        	</#list>
		</table>
	</form>
</div>

<!-- ${tb.fLowerTName} win toolbar start -->
<div id="${tb.fLowerTName}EditWinbbar" style="height: auto">
	<a href="javascript:void(0)" class="easyui-linkbutton save-btn" data-options="iconCls:'icon-save'">保存</a> 
	<a href="javascript:void(0)" class="easyui-linkbutton clear-btn" data-options="iconCls:'icon-clear'">重置</a>
	<a href="javascript:void(0)" class="easyui-linkbutton close-btn" data-options="iconCls:'icon-no'">关闭</a>
</div>
<!-- ${tb.fLowerTName} win toolbar start -->

<script>

	/**
	 * window 编辑窗口初始化
	 */
	jQuery(function(){
		// form表单
    	jQuery('#${tb.fLowerTName}EditWin .${tb.fLowerTName}EditForm').form({
    		novalidate:true,
    		gridSelector:'#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid',
    		winSelector:'#${tb.fLowerTName}EditWin',
    		searchFormSelector:'#${tb.fLowerTName}Module .search${tb.fUpperTName}FormId',
    		onLoadSuccess:function(){
    			//当数据加载完成打开form窗口
    			jQuery('#${tb.fLowerTName}EditWin').window('open');
    		}
    	});

	
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
				clearForm('#${tb.fLowerTName}EditWin .${tb.fLowerTName}EditForm');
			},
			onResize:function(width, height){
				formLayout('#${tb.fLowerTName}EditWin .${tb.fLowerTName}EditForm',width,100,2);
			}
		})
		
	})
	
	
	/*
	 * 保存
	 */
    jQuery('#${tb.fLowerTName}EditWinbbar .save-btn').linkbutton({
		onClick:function(){
			jQuery('#${tb.fLowerTName}EditWin .${tb.fLowerTName}EditForm').form('saveData');
		}
	})
	
	/*
	 * 关闭窗口
	 */
    jQuery('#${tb.fLowerTName}EditWinbbar .close-btn').linkbutton({
		onClick:function(){
			jQuery('#${tb.fLowerTName}EditWin').window('close');
		}
	})
	
	/*
	 * 清除表单
	 */
	jQuery('#${tb.fLowerTName}EditWinbbar .clear-btn').linkbutton({
		onClick:function(){
			clearForm('#${tb.fLowerTName}EditWin .${tb.fLowerTName}EditForm');
		}
	})
	
	
</script>