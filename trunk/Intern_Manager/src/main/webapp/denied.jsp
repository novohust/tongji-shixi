<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<c:set var="pageTitle" value="没有权限" scope="page"></c:set>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/head-inner.jsp"%>
</head>

<body>

	<!-- start: Header -->
	<%@ include file="/common/header.jsp"%>
	<!-- end: Header -->

<div class="container-fluid">
		<div id="content" class="center" style="
		    width: 700px;
		    font-size: 25px;
		    line-height: 100px;
		    margin-bottom:80px;
		">
			您所在的用户组没有权限查看该页面
		</div>

	<%@ include file="/common/footer.jsp"%>
	</div><!--/.fluid-container-->
</body>

	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>
	<!-- end: JavaScript-->

	<script type="text/javascript">
	</script>
</html>