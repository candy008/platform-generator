<div class="panel panel-default">
	<div class="panel-heading ">
		<button type="button" class="btn btn-default btn-sm save-btn">保存</button>
		<button type="button" class="btn btn-default btn-sm back-btn">取消</button>
	</div>
	<div class="panel-body" data-bind="with:editData">
		<form class="${tb.fLowerTName}EditForm form-horizontal">
			<#assign x=0 />
			<#list tb.columns as item>
				<#if x%4==0>
					<#if x!=0>
			</div>
					</#if>
			<div class="row">
				</#if>
				<div class="col-md-3 col-sm-6">
					<div class="form-group">
						<label class="col-md-3 col-sm-4 control-label no-padding-right"><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if></label>
						<div class="col-md-9 col-sm-8">
							<input type="text" name="${item.fLowerColName}" class="form-control" data-bind="value:${item.fLowerColName},enable:enableState">
						</div>
					</div>
				</div>
				<#assign x=x+1 />
			</#list>
			</div>
		</form>
	</div>
</div>


