<title>${tb.fLowerTName}</title>
<body>
<!--这里的divID必须全局唯一，一般使用模块号  最外层的 div 里面的元素查找是必须是从当前div下面查找  start -->
<div id="${tb.fLowerTName}Module" class="easyui-panel" data-options="fit:true,border:false">
<!-- ${tb.fLowerTName} datagrid start -->
<table class="${tb.fLowerTName}DataGrid" >
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
		<#list tb.columns as item>
			<th data-options="field:'${item.fLowerColName}',width:150" ><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if></th>
		</#list>
		</tr>
	</thead>
</table>
<!-- ${tb.fLowerTName} datagrid end -->

<!-- ${tb.fLowerTName} datagrid toolbar start -->
<div class="${tb.fLowerTName}DataGridTb" style="height:auto" >
	<!-- 工具条 start -->
	<a href="javascript:void(0)" class="easyui-linkbutton view-btn" data-options="iconCls:'icon-large-smartart',plain:true" >查看</a>
	<a href="javascript:void(0)" class="easyui-linkbutton add-btn" data-options="iconCls:'icon-add',plain:true" >添加</a>
	<a href="javascript:void(0)" class="easyui-linkbutton update-btn" data-options="iconCls:'icon-edit',plain:true" >修改</a>
	<a href="javascript:void(0)" class="easyui-linkbutton delete-btn" data-options="iconCls:'icon-remove',plain:true" >删除</a>
	<a href="javascript:void(0)" class="easyui-linkbutton cancel-btn" data-options="iconCls:'icon-remove',plain:true" >取消</a>
	<!-- 工具条 end -->
	<!-- 查询form表单 start -->
	<div style="padding:1px;border-top:1px solid #dddddd;width:100%;background-color:#f4f4f4">
         <form class="search${tb.fUpperTName}FormId" method="post" action="$homeModule.getTarget("/${tb.fLowerTName}/insertOrUpdate")" >
    		<table cellpadding="5" style="width:100%">
    			<tr>
    			<#list tb.columns as item>
    				<td align="right" ><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if>:</td>
    				<td >
    					<input class="easyui-validatebox textbox" type="text" name="${item.fLowerColName}"  />
    				</td>
    			</#list>
    				<td style="width:10%" >
    					<a href="javascript:void(0)" class="easyui-linkbutton search${tb.fUpperTName}BtnCls" onclick="gridSearch('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid','#${tb.fLowerTName}Module .search${tb.fUpperTName}FormId')" data-options="iconCls:'icon-search'" style="width:80px">搜索</a>
    				</td>
    			</tr>
    		</table>
		</form>
    </div>
    <!-- 查询form表单 end -->
</div>
<!-- ${tb.fLowerTName} datagrid toolbar end -->
</div>
<!-- ${tb.fLowerTName} import edit page start -->
#parse("/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}Edit.vm")
<!-- ${tb.fLowerTName} import edit page end -->

<script>
      

	/**
     * 打开查看窗口
     */
	jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .view-btn').linkbutton({
		onClick:function(){
			jQuery('#${tb.fLowerTName}EditWinbbar .save-btn').hide();
			jQuery('#${tb.fLowerTName}EditWinbbar .clear-btn').hide();
			load${tb.fUpperTName}Win();
		}
	})
	       
	
	/**
     * 打开添加窗口
     */
	jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .add-btn').linkbutton({
		onClick:function(){
			jQuery('#${tb.fLowerTName}EditWinbbar .save-btn').show();
			jQuery('#${tb.fLowerTName}EditWinbbar .clear-btn').show();
			jQuery('#${tb.fLowerTName}EditWin').window('open');
		}
	})
	
	/**
     * 打开修改窗口
     */
	jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .update-btn').linkbutton({
		onClick:function(){
			jQuery('#${tb.fLowerTName}EditWinbbar .save-btn').show();
			jQuery('#${tb.fLowerTName}EditWinbbar .clear-btn').hide();
			load${tb.fUpperTName}Win();
		}
	})

    /**
	 * 加载form表单数据
     */
    function load${tb.fUpperTName}Win(<#assign x=1 /><#list tb.tableKey as item>id${x}<#assign x=x+1 /><#if item_has_next>,</#if></#list>){
		<#assign x=1 />
			<#list tb.tableKey as item>
		var selectId${x};<#assign x=x+1 />
			</#list>
		if(<#assign x=1 /><#list tb.tableKey as item>id${x} != undefined <#assign x=x+1 /><#if item_has_next>||</#if></#list>){
			<#assign x=1 />
			<#list tb.tableKey as item>
				selectId${x} = id${x}<#assign x=x+1 />
			</#list>
		}else{
			var selectDataArr = jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid("getSelections");
			if(selectDataArr.length==1){
			<#assign x=1 />
			<#list tb.tableKey as item>
				selectId${x} = selectDataArr[0].${item.fLowerkey}<#assign x=x+1 />
			</#list>
			}else if(selectDataArr.length>1){
				jQuery.messager.alert('错误提示','您不能同时操作多条记录！','info');
				return;
			}
		}
		if(<#assign x=1 /><#list tb.tableKey as item>selectId${x} != undefined <#assign x=x+1 /><#if item_has_next>||</#if></#list>){
			jQuery('#${tb.fLowerTName}EditWin .${tb.fLowerTName}EditForm').form('load', '$homeModule.getTarget("/${tb.fLowerTName}/get${tb.fUpperTName}ById")?<#assign x=1 /><#list tb.tableKey as item>${item.fLowerkey}='+selectId${x}<#if item_has_next>+'&&</#if><#assign x=x+1 /></#list>);
		}else{
			jQuery.messager.alert('错误提示','请选择您要操作的记录！','info');
		}
    }
    

	/**
	 * 删除
	 */
	jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .delete-btn').linkbutton({
		onClick:function(){
			var url = "$!homeModule.getTarget("/${tb.fLowerTName}/delete${tb.fUpperTName}ByIdBatch")";
			jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid("removeRow",{
				searchFormId:"#${tb.fLowerTName}Module .search${tb.fUpperTName}FormId",
				url:url,
				pkName:[<#list tb.tableKey as item>'${item.fLowerkey}'<#if item_has_next>,</#if></#list>]
			});
		}
	})

	/**
     * ${tb.fLowerTName}的列表
     */
    jQuery(function(){
        jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid({
            url:'$homeModule.getTarget("/${tb.fLowerTName}/get${tb.fUpperTName}ByPage")',
            method:'post',
            singleSelect:false,
            border:false,
            fit:true,//表格宽自适应
            //fitColumns: true,//表格单元个宽自适应
            nowrap : true,
	        striped : true,
	        remoteSort:false,
	        multiSort:true,
	        rownumbers:true,
            toolbar:'#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb',
	        toolbarSelector:'#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb',
            pagination:true,//分页
            pageSize : 20,//每页显示的条数
            pageList : [5,10,15,20,22,50],//切换每页显示的条数
            onDblClickRow:function(rowIndex,rowData){
            	jQuery('#${tb.fLowerTName}EditWinbbar .save-btn').hide();
				jQuery('#${tb.fLowerTName}EditWinbbar .clear-btn').hide();
            	load${tb.fUpperTName}Win(<#assign x=1 /><#list tb.tableKey as item>rowData.${item.fLowerkey}<#if item_has_next>,</#if><#assign x=x+1 /></#list>);
            },
			queryParams:getFormJson('#${tb.fLowerTName}Module .search${tb.fUpperTName}FormId'),
			onSaveSuccess:function(data){
            	//alert("onSaveSuccess");
            },
            onBeforeEdit:function(){
            	//alert("onBeforeEdit");
            },
            onSaveError:function(){
            	//alert("onSaveError");
            },
            onDeleteSuccess:function(data){
            	//alert("onDeleteSuccess");
            },
            onBeforeDelete:function(){
            	//alert("onBeforeDelete");
            },
            onDeleteError:function(){
            	//alert("onDeleteError");
            }
        });
    });
	

</script>
	
</body>