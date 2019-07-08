<title>${tb.fLowerTName}</title>
<body>
<div id="${tb.fLowerTName}Module" >
	
	<!-- list page start -->
	<div class="listPage startPage">
		#parse("/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}Search.vm")
		#parse("/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}List.vm")
	</div>
	<!-- list page end -->
	
	<!-- edit page end -->
	<div class="${tb.fLowerTName}Edit" style="display:none;">
		#parse("/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}Edit.vm")
	</div>
	<!-- edit page end -->
	
</div>


<script>

jQuery(function(){

	
	//列表后台访问地址
	var url_page = '$homeModule.getTarget('/${tb.fLowerTName}/get${tb.fUpperTName}ByPage')';
	//添加修改后台访问地址
	var url_add = '$homeModule.getTarget('/${tb.fLowerTName}/insertOrUpdate')';
	//删除后台访问地址
	var url_del = '$homeModule.getTarget('/${tb.fLowerTName}/delete${tb.fUpperTName}ByBatchId')';
	
	//查询对象
	var queryData = new ${tb.fUpperTName}View();
	//编辑对象
	var editData = new ${tb.fUpperTName}View();
	//空对象用来清空编辑和查询对象
	var emptyData = new ${tb.fUpperTName}View();
	
	var viewModel={
		queryData:ko.mapping.fromJS(queryData),
		editData:ko.mapping.fromJS(editData),
		pageState:ko.observable("")
	}
	
	/**
	 * 表头
	 */
	var col = [{  
<#list tb.columns as item>
		field:"${item.fLowerColName}",
		title:"<#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if>"
<#if item_has_next>
	},{
</#if>
</#list>
 	}];
    
	
	/**
     * 初始化layoutMDI
     */
	$("#${tb.fLowerTName}Module").layoutMDI({
		//当页面后退时候触发的事件
		onBackPage: function(target, options) {
			ko.mapping.fromJS(emptyData,viewModel.editData);
		} 
	});
	
	/**
     * 创建一个表格，但是没有赋值dataSource数据，这是表格将没有数据
	 */
	var gridObj = $("#${tb.fLowerTName}Module .${tb.fLowerTName}List").grid({
		dataSource:'',
    	id: 'case-g1',
   		keyField: 'id',
   		parentKeyField: 'pid',
    	multiSelect: true,
    	showNumCol:true,
    	height: 500,
    	columns: col,
    	onDblClickFun:function(gridObj,rowObj,rowIndex){
			//设置页面的输入框为不可修改
			viewModel.editData.enableState(false);
			//得到点击行
    		var dbClickRow = gridObj.rowObj;
    		//赋值
    		ko.mapping.fromJS(dbClickRow.value, viewModel.editData);
    		//跳转到编辑页
        	$("#${tb.fLowerTName}Module").layoutMDI("go", ".${tb.fLowerTName}Edit");
    	}
    });
	
	/**
	 * 初始化分页
	 */
	var paginationObj = $("#${tb.fLowerTName}Module .pagination").pagination({
		pageSize:5,
		styleMode:2,
		onSelectPage:function(pageNumber, pageSize){
			var queryData = $.extend(ko.mapping.toJS(viewModel.queryData),{pageNumber:pageNumber,pageSize:pageSize});
			jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}List").gridPlugin("reLoad",queryData);
		}
	});
	
	/**
	 * 初始化表格插件
	 */
	var gridPluginObj = jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}List").gridPlugin({
		url: url_page,
		gridObj:gridObj,
		queryParam:getParams(),
		pagination:true,//是否分页默认为否
		paginationObj:paginationObj,//分页控件对象
		initData:false,//初始化时候是否加载数据(true时候加载，false时候不加载)
		onDataSuccess:function(data){
			//当列表加载成功之后调用
		},
		onDataError:function(data){
			//当列表加载失败之后调用
		},
	})
	
	/**
	 * form表单插件
	 */
	jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}EditForm").formPlugin({
		url: url_add,//添加修改的地址
		gridPlugin:gridPluginObj,//表格插件对象
		onSaveSuccess:function(data){
			//保存成功后退出编辑页面
			$("#${tb.fLowerTName}Module").layoutMDI("back");
		},
		onSaveError:function(data){
			//保存失败回调事件
		},
		onSaveError:function(data){
			//保存失败回调事件
			jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}List").gridPlugin("load", {});
		},
		onDeleteSuccess:function(data){
			
		}
	})
	
	/**
	 * 新增功能
	 */			
    jQuery("#${tb.fLowerTName}Module .toolsbarPanel .add-btn").click(function(){
    	//设置页面的输入框可以输入
		viewModel.editData.enableState(true);
		//设置页面为添加状态
		viewModel.pageState(pageState.add);
        $("#${tb.fLowerTName}Module").layoutMDI("go", ".${tb.fLowerTName}Edit");
    });

	/**
	 * 修改功能
	 */		    
    jQuery("#${tb.fLowerTName}Module .toolsbarPanel .update-btn").click(function(){
    	//设置页面的输入框可以输入
		viewModel.editData.enableState(true);
		//设置页面为修改状态
		viewModel.pageState(pageState.edit);
    	//当前选中行
    	var selectRow = gridObj.getSelectRows();
    	//将数据绑定到表单上面
    	ko.mapping.fromJS(selectRow[0], viewModel.editData);
    	//跳转到编辑页面
        $("#${tb.fLowerTName}Module").layoutMDI("go", ".${tb.fLowerTName}Edit");
    });

	/**
	 * 删除功能
	 */	    
    jQuery("#${tb.fLowerTName}Module .toolsbarPanel .remove-btn").click(function(){
    	//要删除的id用","隔开
		var batchId = "";
		//当前选中行
		var selectRow = gridObj.getSelectRows();
		//判断是否选中要删除的数据
		if(selectRow.length == 0) {
			alert("请选择您要修改的数据");
			return;
		}
	
		for(var i = 0; i < selectRow.length; i++) {
			var row = selectRow[i];
			if(i == 0) {
				batchId = row["id"] + batchId;
			} else {
				batchId = row["id"] + "," + batchId;
			}
		}
		//删除数据
		jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}EditForm").formPlugin("remove",{batchId:batchId,url:url_del});
    });
    
    /**
	 * 刷新功能(只是刷新当前页，如果要刷新所有页面使用 load 方法)
	 */	 
    jQuery("#${tb.fLowerTName}Module .toolsbarPanel .refresh-btn").click(function(){
		jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}List").gridPlugin("reLoad",viewModel.queryData);
    });
    
    //保存功能
	jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}Edit .save-btn").click(function(){
		if(viewModel.pageState()=="add"){
			ko.mapping.fromJS(emptyData,viewModel.queryData);
		}
		var param = {
			formData:ko.mapping.toJS(viewModel.editData),//要提交的数据
			queryData:ko.mapping.toJS(viewModel.queryData),//修改完毕刷新表格的参数
			editType:viewModel.pageState()//页面的状态(add：添加，edit:编辑)
		}
		jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}EditForm").formPlugin("save",param);
	});
	
	//查找功能
	jQuery("#${tb.fLowerTName}Module .searchToolsbar .search-btn").click(function(){
		jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}List").gridPlugin("load",ko.mapping.toJS(viewModel.queryData));
	});
	
	//重置查询条件功能
	jQuery("#${tb.fLowerTName}Module .searchToolsbar .reset-btn").click(function(){
		ko.mapping.fromJS(emptyData,viewModel.queryData);
	});
	
	//编辑页返回
	jQuery("#${tb.fLowerTName}Module .${tb.fLowerTName}Edit .back-btn").click(function(){
		$("#${tb.fLowerTName}Module").layoutMDI("back");
	});

	ko.applyBindings(viewModel);

});

function ${tb.fUpperTName}View(){
	<#list tb.columns as item>
	//${item.remarks}
	this.${item.fLowerColName}="";
	</#list>
	//编辑页面状态
	this.enableState=true;
}

function getParams(selector){
	return {};
}

</script>
	
</body>