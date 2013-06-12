<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="pageTitle" value="数据管理" scope="page"></c:set>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/common/head-inner.jsp" %>

	<style type="text/css">
		#data-man-nav-wapper{text-align: center;}
	</style>
</head>

<body>
	<!-- start: Header -->
	<%@ include file="/common/header.jsp" %>
	<!-- end: Header -->

	<div class="container-fluid">
		<div class="row-fluid">
			<!-- start: Main Menu -->
			<%@ include file="/common/nav.jsp" %>
			<!-- end: Main Menu -->

			<!-- start: Content -->
			<div id="content" class="span11" style="border-top-left-radius:0;">
			</div>
			<!-- end: Content -->

		</div>
	</div>
	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp" %>
	<!-- end: JavaScript-->
</body>
</html>
