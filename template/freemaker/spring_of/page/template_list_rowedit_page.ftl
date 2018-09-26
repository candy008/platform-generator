<title>${tb.fLowerTName}</title>
<body>
<!-- ${tb.fLowerTName} datagrid start -->
<!--这里的divID必须全局唯一，一般使用模块号  最外层的 div 里面的元素查找是必须是从当前div下面查找  start -->
<div id="${tb.fLowerTName}Module" class="easyui-panel" data-options="fit:true,border:false">
<table class="${tb.fLowerTName}DataGrid" >
	<thead>
		<tr>
			<th data-options="field:'ck',checkbox:true"></th>
		<#list tb.columns as item>
			<th data-options="field:'${item.fLowerColName}',width:150,editor:{type:'textbox',options:{required:true}}" ><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if></th>
		</#list>
		</tr>
	</thead>
</table>
<!-- ${tb.fLowerTName} datagrid end -->

<!-- ${tb.fLowerTName} datagrid toolbar start -->
<div class="${tb.fLowerTName}DataGridTb" style="height:auto" >
	<!-- 工具条 start -->
	<a href="javascript:void(0)"  class="easyui-linkbutton refresh-btn type-enable" data-options="iconCls:'icon-add',plain:true" >刷新</a>
	<a href="javascript:void(0)"  class="easyui-linkbutton add-btn type-enable" data-options="iconCls:'icon-add',plain:true" >添加</a>
	<a href="javascript:void(0)"  class="easyui-linkbutton update-btn type-enable" data-options="iconCls:'icon-edit',plain:true" >修改</a>
	<a href="javascript:void(0)"  class="easyui-linkbutton delete-btn type-enable" data-options="iconCls:'icon-remove',plain:true" >删除</a>
	<a href="javascript:void(0)"  class="easyui-linkbutton save-btn type-disable" data-options="iconCls:'icon-edit',plain:true,disabled:true" >保存</a>
	<a href="javascript:void(0)"  class="easyui-linkbutton cancel-btn type-disable" data-options="iconCls:'icon-remove',plain:true,disabled:true" >取消</a>
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
    					<a href="javascript:void(0)" class="easyui-linkbutton search${tb.fUpperTName}BtnCls"  onclick="gridSearch('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid','#${tb.fLowerTName}Module .search${tb.fUpperTName}FormId')" data-options="iconCls:'icon-search'" style="width:80px">搜索</a>
    				</td>
    			</tr>
    		</table>
		</form>
    </div>
    <!-- 查询form表单 end -->
</div>
<!-- ${tb.fLowerTName} datagrid toolbar end -->
</div>
<script>

	jQuery(function(){ 
	
		/**
		 * ${tb.fLowerTName}的列表
		 */
	    jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid({
	        url:'$homeModule.getTarget("/${tb.fLowerTName}/get${tb.fUpperTName}ByPage")',
	        method:'post',
	        singleSelect:false,
	        border:false,
	        fit:true,//表格宽自适应
	        nowrap : true,
	        striped : true,
	        remoteSort:false,
	        multiSort:true,
	        toolbar:'#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb',
	        toolbarSelector:'#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb',
	        pagination:true,//分页
	        pageSize : 20,//每页显示的条数
	        pageList : [5,10,15,20,22,50],//切换每页显示的条数
			queryParams:getFormJson('${tb.fLowerTName}Module.search${tb.fUpperTName}FormId'),
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
		
		
		/**
	     * 刷新
	     */
	     
		jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .refresh-btn').linkbutton({
			onClick:function(){
				gridRefresh('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid','#${tb.fLowerTName}Module .search${tb.fUpperTName}FormId')
			}
		})
	        
	 	/**
	     * 添加
	     */
		jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .add-btn').linkbutton({
			onClick:function(){
				jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid("addRow",{})
			}
		})
		
		/**
	     * 修改
	     */
		jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .update-btn').linkbutton({
			onClick:function(){
				jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid("editRow",{})
			}
		})	
	
		/**
		 * 删除
		 */
		jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .delete-btn').linkbutton({
			onClick:function(){
				var url = "$!homeModule.getTarget("/${tb.fLowerTName}/delete${tb.fUpperTName}ByIdBatch")";
				jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid("removeRow",{
					searchFormId:"#${tb.fLowerTName}Module .search${tb.fUpperTName}FormCls",
					url:url,
					pkName:[<#list tb.tableKey as item>'${item.fLowerkey}'<#if item_has_next>,</#if></#list>]
				});
			}
		})
		
		/**
		 * 保存
		 */
		jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .save-btn').linkbutton({
		    onClick:function(){
				var url = "$homeModule.getTarget("/${tb.fLowerTName}/insertOrUpdate")";
				jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid("saveDataRow",{
					searchFormId:"#${tb.fLowerTName}Module .search${tb.fUpperTName}FormCls",
					url:url
				});
			}
		})
	
		/**
		 * 取消
		 */
		jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGridTb .cancel-btn').linkbutton({
			onClick:function(){
				 //取消当前编辑行把当前编辑行把undefined回滚改变的数据,取消选择的行
				 jQuery('#${tb.fLowerTName}Module .${tb.fLowerTName}DataGrid').datagrid("cancelRow");
			}
		})
	});
	
</script>
	
</body>