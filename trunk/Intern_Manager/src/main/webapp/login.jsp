<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<c:set var="pageTitle" value="同济医学院考勤管理系统" scope="page"></c:set>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/head-inner.jsp"%>
<style type="text/css">
.login-box h2{
	font-family:"微软雅黑";
	margin-top:30px;
	margin-bottom:10px;
	text-shadow:text-shadow:0 -1px 1px rgba(0, 0, 0, 0.2);
}
.alert-error{
	margin: 16px 20px 0px;
}
.login-box{
margin:150px auto;
}
</style>
</head>

<body>
<div class="container-fluid">

			<div class="row-fluid">
				<div class="login-box">
					<h2 style="">请使用您的账号登录</h2>
					<c:if test="${error ne null}">
						<div class="alert alert-error" id="">
							${error}
						</div>
					</c:if>
					<c:if test="${error eq null}">
						<div class="alert alert-error hide" id="">
						</div>
					</c:if>
					<form class="form-horizontal" action="${ctx}/j_spring_security_check" method="post">
						<fieldset>

							<div class="input-prepend" title="用户名">
								<span class="add-on"><i class="halflings-icon user"></i></span>
								<input class="input-large span10" name="j_username" id="username" type="text" placeholder="请输入用户名">
							</div>
							<div class="clearfix"></div>

							<div class="input-prepend" title="密码">
								<span class="add-on"><i class="halflings-icon lock"></i></span>
								<input class="input-large span10" name="j_password" id="password" type="password" placeholder="请输入密码">
							</div>
							<div class="clearfix"></div>

							<div class="button-login">
								<button type="submit" class="btn btn-primary">登录</button>
							</div>
							<div class="clearfix"></div>
					<hr>
				</fieldset></form></div>
			</div><!--/row-->

	<%@ include file="/common/footer.jsp"%>
	</div><!--/.fluid-container-->
</body>

<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>
	<!-- end: JavaScript-->

	<script type="text/javascript">
	</script>
</html>