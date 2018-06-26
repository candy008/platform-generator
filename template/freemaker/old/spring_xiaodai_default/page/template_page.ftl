<title>${tb.fLowerTName}</title>
<body>
<!-- module start -->
<div class="u-mdlayout" id="${tb.fLowerTName}Module" style="padding-top:10px;">
	<!-- master -->
	<div class="u-mdlayout-master" style="display:none"></div>		
		<!-- detail start -->
		<div class="u-mdlayout-detail">	
			
			<!- mdlayout-page -->
			<div class="u-mdlayout-page  current" id="${tb.fLowerTName}list_page">					
				#parse("/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}List.vm")
			</div>
			<!- mdlayout-page end -->
			
			<!-- demo import edit page start -->
			<div class="u-mdlayout-page" id="${tb.fLowerTName}addPage">
				#parse("/WEB-INF/vm/${tb.fLowerTName}/${tb.fLowerTName}Edit.vm")
			<!-- demo import edit page end -->
			
			</div>
			
		</div>
		<!-- detail start -->
	</div>

<!-- module end -->

<script>


jQuery(function(){

	var _CONST = {
			STATUS_ADD: 'add',
			STATUS_EDIT: 'edit'
	}, 
	app, viewModel, basicDatas, events;
	
	
	/**
	 * 表格需要的数据
	 */
	var getInitData = function() {
		viewModel.listData.setSimpleData([
			{
			<#list tb.columns as item>
				'${item.fLowerColName}': '${item.fLowerColName}'<#if item_has_next>,</#if>
			</#list>
			}
		]);
	}
	
	/**
	 * 表格需要的格式
	 */
	basicDatas = {
		listData: new u.DataTable({
			meta: {
			<#list tb.columns as item>
				${item.fLowerColName}:{
					type: 'string'
				}<#if item_has_next>,</#if>
			</#list>
			}
		}),
		formStatus: ko.observable(_CONST.STATUS_ADD),
	};

	computes = {
		refFormInputValue: function(field) {
			debugger;
			return ko.pureComputed({
				read: function() {

					if (viewModel.formStatus() == _CONST.STATUS_ADD) {
						var fr = this.getFocusRow()
						return fr != null ? fr.ref(field) : '';
					} else if (viewModel.formStatus() == _CONST.STATUS_EDIT) {
						var srs = this.getSelectedRows()
						return srs.length > 0 ? srs[0].ref(field) : ''
					}


				},
				owner: viewModel.listData
			})
		}
	}

	/**
	 * ko事件
	 */
	events = {
		backClick: function() {
			var status = viewModel.formStatus();
			if(status == _CONST.STATUS_ADD) {
				viewModel.listData.removeRow(viewModel.listData.rows().length-1);
			} else if(status == _CONST.STATUS_EDIT) {
				var r = viewModel.listData.getSelectedRows()[0];
				r.setSimpleData(r.originData);
			}			

			var	md = document.querySelector('#${tb.fLowerTName}Module')['u.MDLayout']
			md.dBack();
		},
		saveClick: function() {
			var	md = document.querySelector('#${tb.fLowerTName}Module')['u.MDLayout']
			md.dBack()
		},
		rowClick: function(row, e) {
			//getChildData(row);
		},
		afterAdd:function(element, index, data){
            if (element.nodeType === 1) {
                u.compMgr.updateComp(element);
            }
        }

	}

	viewModel = u.extend({}, basicDatas, computes, events);
	
	//新增功能
	jQuery("#${tb.fLowerTName}Module .toolsbar-panel .add-btn").click(function(){
		var md = document.querySelector('#${tb.fLowerTName}Module')['u.MDLayout'];
		md.dGo('${tb.fLowerTName}addPage');
		viewModel.formStatus(_CONST.STATUS_ADD);
		var r = viewModel.listData.createEmptyRow();
		viewModel.listData.setRowFocus(r);
	});
	//修改功能
	jQuery("#${tb.fLowerTName}Module .toolsbar-panel .edit-btn").click(function(){
		var md = document.querySelector('#${tb.fLowerTName}Module')['u.MDLayout']
		md.dGo('${tb.fLowerTName}addPage')
		viewModel.formStatus(_CONST.STATUS_EDIT)
		var r = viewModel.listData.getSelectedRows()[0];
		r.originData = r.getSimpleData();
	});
	//删除功能
	jQuery("#${tb.fLowerTName}Module .toolsbar-panel .remove-btn").click(function(){
		viewModel.listData.removeRows(viewModel.listData.getSelectedRows());
	});
	
	window.vm = viewModel;
	app = u.createApp({
		el: '#${tb.fLowerTName}Module',
		model: viewModel
	});
	getInitData();

});


</script>
	
</body>