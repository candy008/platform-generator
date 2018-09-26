<template>
	<div class="edit-page">
		<div class="list-view">
			<h3>基本信息</h3>
			<el-form label-position="right" label-width="160px" :model="formData" ref="form" :inline="true" :rules="rules">
				<#assign x=0 />
				<#list tb.columns as item>
				<#if x%2==0>
					<#if x!=0>
						</el-row>
					</#if>
					<el-row>
				</#if>
					<el-form-item <#if (item.remarks)!="">label="${item.remarks}"<#else>label="${item.fLowerColName}"</#if>  prop="${item.fLowerColName}">
						<el-input v-model="formData.${item.fLowerColName}"></el-input>
					</el-form-item>
				<#assign x=x+1 />
				</#list>
				</el-row>
			
			</el-form>
			<div class="button-bottom">
				<el-button @click="saveData"  size="large" type="success">保存</el-button>
				<el-button @click="cancel" size="large">取消</el-button>
			</div>
		</div>
	</div>
</template>

<script>
	//获取公用提交，删除接口
	import api from "@/assets/js/api"
	/*
	 @props {formData} 动态地保定父组件地formData值，当父组件改变该数据时，编辑页可以动态地更新数据
	 * */
		export default{
			props:['formData','options'],
			data(){
				return {
					disabled:false,
					rules:{
						<#list tb.columns as item>
							<#if (item.remarks)!="">
								${item.fLowerColName}:[
									{ required: true, message: '请输入${item.remarks}', trigger: 'blur,change' }
								],
							<#else>
								${item.fLowerColName}:[
									{ required: true, message: '请输入${item.fLowerColName}', trigger: 'blur,change' }
								],
							</#if>
						</#list>
					}
				}
			},
			methods:{
				resetForm(){
					this.$refs.form.resetFields();
				},
				/*
				 	提交hide事件，由父组件监听（返回列表页）
				 * */
				cancel(){
					this.$emit("hide")
				},
				/*
				 	保存数据
				 	调用保存数据的通用API，API说明参考api.js
				 * */
				saveData(){
					var _this = this
					this.$refs.form.validate((valid) => {
					if(!valid)
						return false;
					api.saveData({
						data(){
							return {
								baseUrl:this.BASEURL + "/${tb.fLowerTName}/insertOrUpdate",
								formData:_this.formData,
								callbackMethods:true,
								//当前操作的表格
								currentTable: _this.$refs.childTable,
								//当前组件
								currentComponent:_this,
							}
						},
						methods:{
							onSaveSuccess:function(success){
								_this.$message({
									showClose: true,
									message: '保存成功',
									type: 'success',
									duration: 1000
								});
								_this.$emit("hide")
							},
							onSaveError:function(error){
								_this.$message({
									showClose: true,
									message: '保存失败',
									type: 'error',
									duration: 1000
								});
								_this.$emit("hide")									
							}
						}
					})
					})
				}
			}
		}
</script>