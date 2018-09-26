<div class="panel panel-default">
	<div class="panel-heading ">
		<button type="button" class="u-button raised primary" data-bind="click: backClick">取消</button>
		<button type="button" class="u-button raised primary" data-bind="click: saveClick">保存</button>
	</div>
	<div class="panel-body">
		<form class="bs-example form-horizontal">
			<!-- form-group 为一行 -->
			<#list tb.columns as item>
			<div class="form-group">
				<label class="col-xs-1 control-label"><#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if></label>
				<div class="col-xs-5">
					<input type="text" name="${item.fLowerColName}" class="form-control">
				</div>
			</div>
			</#list>
		</form>
	</div>
</div>

