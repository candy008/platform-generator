<template>
	<div class="detail-page">
		<div class="list-view">
		<h3>基本信息</h3>
			<#assign x=0 />
			<#list tb.columns as item>
			<#if x%2==0>
			<#if x!=0>
			</el-row>
			</#if>
			<el-row>
				</#if>
				<el-col :span="12">
					<div class="info-wrap">
						<el-col :span="6"><span class="detail-title"><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if></span></el-col>
						<el-col :span="2"><span>:</span></el-col>
						<el-col :span="16"><span class="detail-info">{{detailInfo.${item.fLowerColName}}}</span></el-col>
					</div>
				</el-col>
				<#assign x=x+1 />
			</#list>
			</el-row>
				
			<div class="button-bottom">
				<el-button @click="cancel" size="large">取消</el-button>
			</div>
		</div>
	</div>
</template>

<script>
	/*
	 @props {detailInfo} 动态地保定父组件地detailInfo值，当父组件改变该数据时，详情页可以动态地更新数据
	 * */
	export default{
			props:['detailInfo'],
			/*
			 	详情页所需要的数据
			 * */
			data(){
				return {
				}
			},
			/*
			  返回列表页
			 * */
			methods:{
				cancel(){
					this.$emit("hide")
				}
			}
			
		}
	
</script>