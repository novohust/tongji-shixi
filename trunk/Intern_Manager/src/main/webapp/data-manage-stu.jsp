<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="pageTitle" value="数据管理-学生" scope="page"></c:set>

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
				<c:set var="dataManCurPage" value="stu" scope="page"></c:set>
				<%@ include file="/common/data-man-nav.jsp" %>


				<!--  start: 查询 -->
				<div class="row-fluid">
					<div class="box span12">
						<div class="box-header">
							<h2><i class="halflings-icon search"></i><span class="break"></span>查询</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content">
							<!-- start: query form 选择学生 -->
							<form action="" class="form-horizontal query-form float-form">
								<fieldset>
									<div class="control-group">
										<label for="" class="control-label">学号</label>
										<div class="controls"><input type="text" class="input-medium" placeholder="请输入学生学号"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">姓名</label>
										<div class="controls"><input type="text" class="input-medium" placeholder="请输入学生姓名"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">专业</label>
										<div class="controls"><input type="text" class="input-medium" placeholder="请输入专业名称"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">年级</label>
										<div class="controls"><input type="text" class="input-medium" placeholder="请输入年级"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">班级</label>
										<div class="controls"><input type="text" class="input-medium" placeholder="请输入班级"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">导师</label>
										<div class="controls"><input type="text" class="input-medium" placeholder="请输入导师姓名"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">类别</label>
										<div class="controls">
											<select name="" id="" class="input-mini" rel="uniform">
												<option value="1">本科</option>
												<option value="2">硕士</option>
												<option value="3">博士</option>
											</select>
										</div>
									</div>
									<div class="float-form-actions" >
										<button class="btn btn-primary" type="submit">查询</button>
										<button class="btn switch-to-barcode" >清空</button>
									  </div>
								</fieldset>
							</form>
							<!--  end: query form 选择学生-->
							<table class="table table-bordered table-striped">
						  <thead>
							  <tr>
							  	<th style="width:10px" class="center"><input type="checkbox" rel="uniform"></th>
							  	<th>学号</th>
								<th>姓名</th>
								<th>年级</th>
								<th>类别</th>
								<th>专业</th>
								<th>班级</th>
								<th>性别</th>
								<th>导师</th>
								<th>出生日期</th>
								<th style="width:100px">描述</th>
								<th style="width:60px">操作</th>
							  </tr>
						  </thead>
						  <tbody>
							<tr>
								<td class="center"><input type="checkbox" rel="uniform"></td>
								<td >M20127512</td>
								<td>
									<span
									style="cursor:pointer;"
									data-toggle="popover"
									data-html="true"
									data-placement="top"
									data-trigger="hover"
									data-content="<img class='avatar' src='http://tp1.sinaimg.cn/1681338140/180/40000270170/1'>" >
										<i class="fa-icon-user"
										style="font-size:14px;">
										</i>
										欧阳上官
									</span>
								</td>
								<td>2011</td>
								<td >本科</td>
								<td >内科</td>
								<td>2</td>
								<td>男</td>
								<td>张三李四</td>
								<td>1986-09-26</td>
								<td>
									<div style="width:200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"
									style="cursor:pointer;"
									data-toggle="popover"
									data-html="true"
									data-placement="top"
									data-trigger="hover"
									data-content="本科院校：华中科技大学；是否党员：是.本科院校：华中科技大学；是否党员：是本科院校：华中科技大学；是否党员：是本科院校：华中科技大学；是否党员：是本科院校：华中科技大学；是否党员：是">
										本科院校：华中科技大学；是否党员：是.本科院校：华中科技大学；是否党员：是本科院校：华中科技大学；是否党员：是本科院校：华中科技大学；是否党员：是本科院校：华中科技大学；是否党员：是
									</div>
								</td>
								<td><a class="btn btn-info btn-mini" href="#"><i class="icon-edit icon-white"></i>编辑</a></td>
							</tr>
						  </tbody>
				 	</table>
				 	<button class="btn btn-primary">删除</button>
					<!-- start: 分页 -->
					<!-- 分页  -->
					<div  class="pagination pagination-centered">
				    		<form id="queryform" target="_self" style="display:none;" method="post" action="myTaskList.htm">
					            		<input id="pageNum" type="hidden" value="11" name="pageNum">
					            		<input id="pageSize" type="hidden" value="10" name="pageSize">
					            		<input id="totalCount" type="hidden" value="101" name="totalCount">
						            <!-- 翻页时保留查询条件 -->
						            <input type="hidden" value="$!creator" name="creator"/>
						            <input type="hidden" value="$!taskName" name="taskName"/>
						            <input type="hidden" value="$!taskType" name="taskType"/>
					        	</form>

						<div id="pagination">
						    	<ul class="page-detail" style="margin-left:0;"></ul>
						            	<ul class="page-jump-wrapper">
						            		<li>
						            			<span id="page-jump-info">
						            				共<em>11 </em> 页 到<input class="input-mini" type="text" maxlength="4" autocomplete="off">页
						            				<button type="submit" class="btn btn-small">确定</button>
						            			</span>
						            		</li>
						         	</ul>
						</div>
					 </div>
					<!-- end:分页 -->
						</div>
					</div>
				</div>
				<!--  end: 查询 -->

				<!--  start: 新增 -->
				<div class="row-fluid">
					<div class="box span12">
						<div class="box-header">
							<h2><i class="halflings-icon plus-sign"></i><span class="break"></span>新增</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content">
							<form data-validate="parsley" class="form-horizontal" action="${ctx}/data-manage/stu/add" enctype="multipart/form-data" method="post">
								<fieldset>
								  <div class="control-group">
										<label for="" class="control-label">学号</label>
										<div class="controls">
											<input data-trigger="blur" data-regexp-message="学号必须由字母和数字组成" data-regexp="#[A-Za-z0-9]{1,20}"
												 name="stuNo" type="text" class="input-large required" placeholder="请输入学生学号"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">姓名</label>
										<div class="controls"><input name="name" type="text" class="input-large" placeholder="请输入学生姓名"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">出生日期</label>
										<div class="controls">
											<input type="text" name="birthday" class="input-large datepicker-dropdown-year-month" placeholder="格式 1983-01-02">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">专业</label>
										<div class="controls"><input name="major" type="text" class="input-large" placeholder="请输入专业名称"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">导师</label>
										<div class="controls"><input name="mentor" type="text" class="input-large" placeholder="请输入导师姓名"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">年级</label>
										<div class="controls"><input name="grade" type="text" class="input-large" placeholder="请输入年级"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">类别</label>
										<div class="controls">
											<select name="type" id="" class="input-mini" rel="uniform">
												<option value="1">本科</option>
												<option value="2">硕士</option>
												<option value="3">博士</option>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">照片</label>
										<div class="controls">
											<input type="file" name="avatar">
										</div>
									</div>

								  <div class="form-actions">
									<button type="submit" class="btn btn-primary">确定</button>
									<button  type="reset" class="btn btn-clear">清空</button>
								  </div>
								</fieldset>
						  	</form>
						</div>
					</div>
				</div>
				<!--  end: 新增 -->

			</div>
			<!-- end: Content -->

			<%@ include file="/common/footer.jsp" %>

		</div>
	</div>
	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp" %>
	<!-- end: JavaScript-->
</body>
</html>
