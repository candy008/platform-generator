	<!- mdlayout-page-section -->
	<div class="u-mdlayout-page-section"  style="top:0px;">					
		<!-- container -->
		<div class="u-container-fluid">					
			<!-- content start -->
			<div class="u-row content">						
				
				<!-- search start  -->
				<div class="row col-sm-12 search-panel">
					<div class="col-sm-11">
						<form class="bs-example form-horizontal search-form">
							<div class="form-group">
								<label class="col-lg-1 control-label">Email</label>
								<div class="col-lg-5">
									<input type="email" placeholder="Email" class="form-control">
								</div>
								<label class="col-lg-1 control-label">Password</label>
								<div class="col-lg-5">
									<input type="password" placeholder="Password" class="form-control">
								</div>
							</div>
						</form>
					</div>
					<div class="col-sm-1">
						<a class="u-button raised primary search-btn" >查询</a>
					</div>
				</div>
				<!-- search end -->
				
				<!-- toolsbar start -->
				<div class="row col-sm-12 toolsbar-panel">
					<div class="col-sm-12">
						<div class="form-group">
						<from action="#" method="post">
							<a class="u-button raised primary add-btn" >新增</a>
							<a class="u-button raised primary edit-btn">修改</a>
							<a class="u-button raised primary remove-btn">删除</a>
						</form>
						</div>
					</div>
				</div>
				<!-- toolsbar end -->
			
				
				<!-- main grid 主表 -->
				<div class="row col-sm-12 main-grid-list">
					<div class="col-sm-12">
						<div class="form-group">
							<!--widget-content-->
							<div class="widget-content">
								<div  u-meta='{"id":"grid1","type":"grid","data":"listData","multiSelect":false,"showNumCol":true,"editable":false,"onRowSelected":"rowClick"}' style="margin-bottom: 15px;" >
								    <#list tb.columns as item>
								    <div options='{"field":"${item.fLowerColName}","dataType":"string","title":"<#if (item.remarks)!="">${item.remarks}<#else>${item.fLowerColName}</#if>","editOptions":{"id":"${item.fLowerColName}","type":"string","maxLength":6},"editType":"string"}'></div>
						        	</#list>
								</div>
								<!-- 分页 -->
								<div class='u-pagination' u-meta='{"type":"pagination","data":"listData"}'></div>
								<!-- 分页 -->
							</div>
							<!--widget-content end -->
						</div>
					</div>
				</div>
				<!-- main grid 主表 -->
			</div>
			<!-- content end -->
			
		</div>
		<!-- container end -->
		
	</div>
	<!- mdlayout-page-section -->