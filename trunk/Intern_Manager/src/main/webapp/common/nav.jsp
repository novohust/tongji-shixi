<%@ page contentType="text/html;charset=UTF-8"%>
<div id="sidebar-left" class="span1">
	<div class="nav-collapse sidebar-nav">
		<ul class="nav nav-tabs nav-stacked main-menu">
			<sec:authorize ifAllGranted="Admin" >
				<li><a href="${ctx}/intern-add"><i class="fa-icon-barcode"></i><span class="hidden-tablet"> 考勤录入</span></a></li>
			</sec:authorize>

			<!-- User只能看查询 -->
			<li><a href="${ctx}/intern-query"><i class="fa-icon-search"></i><span class="hidden-tablet"> 考勤查询</span></a></li>

			<sec:authorize ifAllGranted="Admin" >
			<li><a href="${ctx}/barcode-print"><i class="fa-icon-print"></i><span class="hidden-tablet"> 条码打印</span></a></li>
			</sec:authorize>

			<sec:authorize ifAllGranted="Admin" >
			<li><a href="${ctx}/data-import"><i class="fa-icon-signin"></i><span class="hidden-tablet"> 数据导入</span></a></li>
			</sec:authorize>

			<sec:authorize ifAllGranted="Admin" >
			<li><a href="${ctx}/data-manage"><i class="fa-icon-align-justify"></i><span class="hidden-tablet"> 数据管理</span></a></li>
			</sec:authorize>
		</ul>
	</div>
</div>
