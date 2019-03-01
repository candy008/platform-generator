<!-- search start  -->
<div class="searchPanel padding-10">
	<form class="form-horizontal">
		<div class="searchContent" data-bind="with:queryData">
			<#assign x=0 />
			<#list tb.columns as item>
			<#if x lt 4 >
			<#if x%4==0>
			<#if x!=0></div></#if>
			<div class="row">
			</#if>
				<div class="col-md-3 col-sm-6">
					<div class="form-group">
						<label class="col-md-4 col-sm-4 control-label no-padding-right"><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if></label>
						<div class="col-md-8 col-sm-8">
							<input type="text" name="${item.fLowerColName}" class="form-control" data-bind="value:${item.fLowerColName}">
						</div>
					</div>
				</div>
			</#if>
			<#assign x=x+1 />
			</#list>
			</div>
			<!--******更多条件放这里********-->
			<div class="hideRule">
				<#assign x=0 />
				<#list tb.columns as item>
				<#if x gt 3 >
				<#if x%4==0>
				<#if x!=4></div></#if>
				<div class="row">
				</#if>
					<div class="col-md-3 col-sm-6">
						<div class="form-group">
							<label class="col-md-4 col-sm-4 control-label no-padding-right"><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if></label>
							<div class="col-md-8 col-sm-8">
								<input type="text" name="${item.fLowerColName}" class="form-control" data-bind="value:${item.fLowerColName}">
							</div>
						</div>
					</div>
				</#if>
				<#assign x=x+1 />
				</#list>
				</div>
			</div>
		</div>
		<!-- 展开更多的一行-->
		<div class="searchToolsbar">
			<div data-target=".hideRule" data-toggle="collapse" class="moreRule">
				<span>展开更多查询条件</span>
				<i class="glyphicon glyphicon-triangle-bottom"></i>
			</div>
			<div class="search-box">
				<button type="button" class="btn btn-default btn-sm reset-btn">重置</button>
				<button type="button" class="btn btn-default btn-sm search-btn">查询</button>
			</div>
		</div>
	</form>
</div>
<!-- search end -->