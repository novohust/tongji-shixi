<%@ page contentType="text/html;charset=UTF-8"%>
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="brand" href="#"><img style="width: 300px;margin-top: 0px;" src="${ctx}/static/img/tongji.png"/></a>

				<!-- start: Header Menu -->
				<div class="nav-no-collapse header-nav" style="margin-top: 22px;">
					<ul class="nav pull-right">
						<!-- end: User Dropdown -->
						<li title="退出登录">
							<a class="btn" href="${ctx}/auth/logout">
								<i class="halflings-icon white off"></i>
							</a>
						</li>
					</ul>
				</div>

				<div class=" pull-right" style="margin-top:10px;margin-right:10px;">
					<i class="halflings-icon white user" style="margin-top:3px;"></i>&nbsp;欢迎回来，<sec:authentication property="name"/>
				</div>
				<!-- end: Header Menu -->

			</div>
		</div>
	</div>
