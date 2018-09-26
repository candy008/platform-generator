<title>${tb.fLowerTName}</title>
<body>
<!-- ${tb.fLowerTName} datagrid start -->
<table id="${tb.fLowerTName}DataGrid" >
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
		<#list tb.columns as item>
			<th data-options="field:'${item.fLowerColName}',width:100" >${item.remarks}</th>
		</#list>
		</tr>
	</thead>
</table>
<!-- ${tb.fLowerTName} datagrid end -->

<!-- ${tb.fLowerTName} datagrid toolbar start -->
<div id="${tb.fLowerTName}DataGridTb" style="height:auto" >
	<div>
    	<a href="javascript:void(0)" class="easyui-linkbutton view-btn" data-options="iconCls:'icon-large-smartart',plain:true" >查看</a>
    	<a href="javascript:void(0)" class="easyui-linkbutton add-btn" data-options="iconCls:'icon-add',plain:true" >添加</a>
    	<a href="javascript:void(0)" class="easyui-linkbutton update-btn" data-options="iconCls:'icon-edit',plain:true" >修改</a>
    	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="deleteGridData('${tb.fLowerTName}DataGrid',delete${tb.fUpperTName})">删除</a>
	</div>
	<div style="padding:1px;border-top:1px solid #dddddd;width:100%;background-color:#f4f4f4">
         <form id="search${tb.fUpperTName}FormId" method="post" action="$homeModule.getTarget("/${tb.fLowerTName}/insertOrUpdate")" >
    		<table cellpadding="5" style="width:100%">
    			<tr>
    			<#list tb.columns as item>
    				<td style="width:5%" align="right" >${item.remarks}</td>
    				<td style="width:10%" >
    					<input class="easyui-textbox" type="text" name="${tb.fLowerTName}Query.${item.fLowerColName}"  />
    				</td>
    			</#list>
    				<td style="width:10%" >
    					<a href="javascript:void(0)" id="search${tb.fUpperTName}BtnId" class="easyui-linkbutton" onclick="gridSearch('${tb.fLowerTName}DataGrid','search${tb.fUpperTName}FormId')" data-options="iconCls:'icon-search'" style="width:80px">搜索</a>
    				</td>
    			</tr>
    		</table>
		</form>
    </div>
</div>
<!-- ${tb.fLowerTName} datagrid toolbar end -->

<!-- ${tb.fLowerTName} import edit page start -->
#parse("/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}Edit.vm")
<!-- ${tb.fLowerTName} import edit page end -->

<script>


 	/**
     * 打开查看窗口
     */
	jQuery('.view-btn').click(function(){
		openView${tb.fUpperTName}Win();
	})
	
	/**
     * 打开添加窗口
     */
	jQuery('.add-btn').click(function(){
		$('.save-btn').show();
		$('.clear-btn').show();
		jQuery('#${tb.fLowerTName}EditWin').window('open');
	})
	
	//打开修改窗口
	jQuery('.update-btn').click(function(){
		$('.save-btn').show();
		$('.clear-btn').hide();
		view${tb.fUpperTName}Win();
	})
	
	function openView${tb.fUpperTName}Win(id){
		$('.save-btn').hide();
		$('.clear-btn').hide();
		view${tb.fUpperTName}Win(id);
	}


 	/**
     * 打开查看窗口
	 * id 要查看记录的Id
	 * 加载form表单数据
     */
    function view${tb.fUpperTName}Win(id){
		var selectId;
		if(id){
			selectId = id
		}else{
			var selectData = jQuery('#${tb.fLowerTName}DataGrid').datagrid("getSelected");
			if(selectData){
				selectId = selectData.id;
			}
		}
		if(selectId){
			jQuery('#${tb.fLowerTName}EditWin').window('open');
			jQuery('#${tb.fLowerTName}EditForm').form('load', '$homeModule.getTarget("/${tb.fLowerTName}/get${tb.fUpperTName}ById")?${tb.fLowerTName}Query.id='+selectId);
		}else{
			jQuery.messager.alert('错误提示','请选择您要操作的记录！','info');
		}
    }




	/**
	 * 删除数据（该方法为回调方法）
	 * deleteIds 要删除记录的id,以逗号隔开（1,2,3,4,5） 
	 * dataGridId 要删除的grid的
	 */
	jQuery('.delete-btn').click(function(){
		deleteGridData('${tb.fLowerTName}DataGrid',function(deleteIds,dataGridId){
    		jQuery.ajax({  
    			type:"post",
    			url:"$!homeModule.getTarget("/${tb.fLowerTName}/deletePlatMaterialsByIdBatch")",
    			dataType:"json",
    			data:"batchId="+deleteIds,
    			success:function(data){
    				//刷新表格数据
    				reLoadDataGrid(dataGridId);
    				jQuery.messager.alert('提示信息','删除记录成功！','info');
    			}, 
    			error:function(data){
    				jQuery.messager.alert('提示信息','删除记录失败！','info');
    			}
    		});
		})
	})


	/**
     * ${tb.fLowerTName}的列表
     */
    jQuery(function(){
        jQuery('#${tb.fLowerTName}DataGrid').datagrid({
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
            toolbar:'#${tb.fLowerTName}DataGridTb',
            pagination:true,//分页
            pageSize : 20,//每页显示的条数
            pageList : [5,10,15,20,22,50],//切换每页显示的条数
            onDblClickRow:function(rowIndex,rowData){
            	openView${tb.fUpperTName}Win(rowData.id);
            },
			queryParams:getFormJson('search${tb.fUpperTName}FormId')
        });
    });
	

</script>
	
</body>