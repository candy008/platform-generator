<template>
	<div class="trans">
		<div class="transPage" v-show="pageState.active=='list'" >
			
			<div class="tools-panel">
				<!-- element 动画 -->
				<transition name="el-zoom-in-top">
				<!-- 更多查询 start -->
				<div class="tools-more" v-show="!hideMore">
					<div>
						<el-form :inline="true" :model="queryParams" class="demo-form-inline" label-width="120px">
							<#assign x=0 />
							<#list tb.columns as item>
								<el-form-item <#if (item.remarks)!="">label="${item.remarks}" <#else>label="${item.fLowerColName}"</#if> prop="${item.fLowerColName}">
										<el-input v-model="queryParams.${item.fLowerColName}"></el-input>
								</el-form-item>
							</#list>
						</el-form>
						<div class="more-search-btn" >
							<el-button type="primary" @click="searchData">查询</el-button>
							<el-button  @click="resetSearch">重置</el-button>
							<span @click="hideMore=true" class="hide-span">收起<i class="iconfont icon-jiantoushang"></i></span>
						</div>
					</div>
				</div>
				<!-- 更多查询 start -->
				</transition>
				
				<!-- toolbar start -->
				<div class="tools-bar">
					
					<!-- 查询 start -->
					<div class="tools-search">
						<el-form :inline="true" :model="queryParams" class="demo-form-inline">
							<el-form-item>
								<el-input v-model="queryParams.systemName" placeholder="请输入系统名称" icon="search" :on-icon-click="searchData"></el-input>
							</el-form-item>
							<span class="tools-more-show" @click="hideMore=false">
								更多<i class="iconfont icon-jiantouxia"></i>
							</span>
						</el-form>
					</div>
					<!-- 查询 end -->
					
					
					<!--按钮条组件 用来替换上面的btn按钮-->
					<tool-btn :btn-url="btnUrl" :btn-state="btnState"></tool-btn>
					<!-- btn end -->
					
				</div>
				<!-- toolbar end -->
				
			</div>

			<!-- 表格 start -->
			<edit-table ref="childTable" :query-url="queryUrl" :query-params="queryParams" :load-state="true" @row-dblclick="showDetail">
				<el-table-column type="selection" width="55"></el-table-column>
				<#list tb.columns as item>
					<el-table-column prop="${item.fLowerColName}" width="150" <#if (item.remarks)!="">label="${item.remarks}" <#else>label="${item.fLowerColName}"</#if>></el-table-column>
				</#list>
			</edit-table>
			<!-- 表格 end -->
		</div>
		
		<!-- 编辑页 -->
		<${tb.fLowerTName}-edit v-show="pageState.active=='edit'" class="transPage" :form-data="form" @hide="hidePage"></${tb.fLowerTName}-edit>
		<!-- 详情页 -->
		<${tb.fLowerTName}-detail v-show="pageState.active=='detail'" class="transPage" :detail-info="form" @hide="hidePage"></${tb.fLowerTName}-detail>
	</div>
</template>

<script>
	/*
	 * 引入组件以及js模块
	 * 组件使用说明参考具体组件
	 */
	import ${tb.fLowerTName}Edit from "./${tb.fLowerTName}Edit.vue"
	import ${tb.fLowerTName}Detail from "./${tb.fLowerTName}Detail.vue"
	import api from "@/assets/js/api.js"
	import ${tb.fLowerTName}Model from "@/assets/model/ins_web/${tb.fLowerTName}/${tb.fLowerTName}Model.js"
	 
	export default {
		name: "${tb.fLowerTName}",
		/**
		 * 注册组件 components
		 * ${tb.fLowerTName}Edit：编辑页组件
		 * ${tb.fLowerTName}Detail：详情页组件
		 * editTable：表格组件
		 */
		components: {
			${tb.fLowerTName}Edit,
			${tb.fLowerTName}Detail
		},
		/**
		 * 列表页所需要的数据
		 * queryUrl：表格组件去获取数据的地址
		 * queryParams：动态传给表格组件的查询参数，绑定在当前的查询表单中
		 * pageState：当前页面的状态
		 * list：列表页是否隐藏
		 * edit：编辑页是否显示
		 * detail：详情页是否显示
		 * hideMore：更多查询条件的列表是否隐藏
		 * form：编辑页面表单所需要的动态绑定的数据源
		 * emptyForm：空数据源，用作新增页面使用(方便赋值
		 */
		data() {
			return {
				//表格分页数据的地址
				queryUrl: this.BASEURL + "${tb.fLowerTName}/get${tb.fUpperTName}ByPage",
				//按钮组件（根据提供的json数据动态的渲染成一组按钮的组件,目前使用json文件替代,将来换成组件服务)
				btnUrl:"/data/ins_web/${tb.fLowerTName}/${tb.fLowerTName}Btn.json",
				//表格查询绑定的参数
				queryParams: {
				<#list tb.columns as item>
					${item.fLowerColName}:""<#if item_has_next>,</#if>
				</#list>
				},
				btnState:{
					addFun:true,
					editFun:true,
					deleteFun:true,
					refreshFun:true
				},
				options: {},
				//用来做页面切换的
				pageState: new api.pageState("list"),
				//隐藏更多查询项，true为隐藏，false为显示
				hideMore: true,
				//用来绑定form表单的数据
				form: new ${tb.fLowerTName}Model(),
				//用来清楚表单数据
				emptyForm: new ${tb.fLowerTName}Model()
			}
		},
		created() {
		},
		methods: {
			/**
			 * 重置查询表单	
			 */
			resetSearch() {
				for (var attr in this.queryParams) {
					this.queryParams[attr] = ""
				}
			},
			/**
			 * 查询表格数据
			 */
			searchData() {
				//将更多查询隐藏
				this.hideMore = true;
				//调用子组件的方法，重新加载表格数据
				this.refreshFun();
			},
			/**
			 * 切回列表页面(编辑页以及详情页调用同一个方法)
			 */
			hidePage() {
				//切换页面
				this.pageState.goBack()
					//将也没中的更多查询隐藏
				this.hideMore = true;
				//重置高级查询表单
				this.resetSearch();
				//调用子组件的方法，重新加载表格数据
				this.refreshFun();
				Object.assign(this.form, this.emptyForm);
				this.$refs.edit.resetForm();
			},
			/**
			 * 刷新当前表格
			 */
			refreshFun() {
				this.$refs.childTable.loadTableData()
			},
			rowClick(row) {
					 
					 this.btnState.addFun = true,
					 this.btnState.editFun = true,
					 this.btnState.deleteFun = true,
					 this.btnState.refreshFun = true
					 
			},
			/**
			 * 显示单行数据详情
			 * 双击行的事件回调函数
			 * @param {row} 所点击行的数据	
			 */
			showDetail(row) {
				Object.assign(this.form, row);
				this.pageState.goNext("detail");
			},
			/**
			 * 新增数据
			 * 点击新增按钮的回调函数
			 */
			addFun(btnName) {
				Object.assign(this.form, this.emptyForm);
				this.pageState.goNext("edit", btnName);
			},
			/**
			 * 修改一条数据
			 * 点击修改按钮时触发的回调函数
			 */
			editFun(btnName) {
				if(!this.$refs.childTable.multipleSelection.length) {
					this.$message("请至少选择一条数据！")
					return;
				}
				Object.assign(this.form, this.$refs.childTable.multipleSelection[0])
		
				this.pageState.goNext("edit",btnName)
			},
			/**
			 * 删除数据
			 * 点击删除按钮时触发的回调函数
			 */
			deleteFun() {
				if(!this.$refs.childTable.multipleSelection.length) {
					this.$message("请至少选择一条数据！")
					return;
				}
				this.$confirm('是否删除选中数据?', '提示', {
					confirmButtonText: '确定',
					cancelButtonText: '取消',
					type: 'warning'
				}).then(() => {
					var str = ""
					//获取所有选中的数据，动态地拼接所选中的id,调用删除数据的统一接口 api.removeData
					this.$refs.childTable.multipleSelection.forEach(function(value) {
						str += value.id + ","
					})
					var _this = this
					api.removeData({
						data() {
							return {
								//删除数据的地址
								baseUrl: this.BASEURL + "/${tb.fLowerTName}/delete${tb.fUpperTName}ByBatchId",
								formData: {
									batchId: str
								},
								//当前操作的表格
								currentTable: _this.$refs.childTable,
								//当前组件
								currentComponent:_this,
								//执行自己定义的数据（true 发布出删除成功和删除失败的回掉函数，封装的方法不做任何处理）
								callbackMethods: false
							}
						},
						methods: {
							//当删除成功
							onSaveSuccess: function(success) {
								//调用子组件的方法，重新加载表格数据
								_this.refreshFun();
							},
							//当删除失败
							onSaveError: function(error) {
								//调用子组件的方法，重新加载表格数据
								_this.refreshFun();
							}
						}
					})
				}).catch(() => {});
			}
		}
	}
</script>