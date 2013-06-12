<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageTitle" value="数据管理-教授组" scope="page"></c:set>

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
		<div class="row-fluid">
			<!-- start: Main Menu -->
			<%@ include file="/common/nav.jsp"%>
			<!-- end: Main Menu -->

			<!-- start: Content -->
			<div id="content" class="span11" style="border-top-left-radius: 0;">
				<c:set var="dataManCurPage" value="teacherTeam" scope="page"></c:set>
				<%@ include file="/common/data-man-nav.jsp"%>

				<!--  start: 教授组 -->
				<div class="row-fluid">
					<div class="box span12">
						<div class="box-header">
							<h2>
								<i class="halflings-icon search"></i><span class="break"></span>教授组
							</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content">
							<!-- start: query form -->
							<form action="${ctx}/data-manage/teacher-team" class="form-horizontal query-form float-form">
								<fieldset>
									<div class="control-group">
										<label for="" class="control-label">二级学科</label>
										<div class="controls">
											<select name="area.department.secondarySubject.id" id="" class="input-mini select-ss" rel="uniform">
												<option value=""></option>
												<c:forEach var="ss" items="${allSS}">
													<option value="${ss.id}"
														<c:if test="${query.area.department.secondarySubject.id==ss.id}">selected="selected"</c:if>>${ss.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">科室</label>
										<div class="controls">
											<select name="area.department.id" id="" class="input-mini select-dept" rel="uniform"
												<c:if test="${query.area.department.id!=null}">init-value="${query.area.department.id}"</c:if>>
												<option value=""></option>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">病区</label>
										<div class="controls">
											<select onchange="if($('#nameAdd').val() && $('#areaIdAdd').val()) $('#nameAdd').trigger('blur');"
												name="area.id"
												rel="uniform" class="input-small select-area"
												<c:if test="${query.area.id!=null}">init-value="${query.area.id}"</c:if>>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">名称</label>
										<div class="controls">
											<input type="text" value="${query.name}" name="name" class="input-medium" placeholder="请输入教授组名称">
										</div>
									</div>

									<div class="float-form-actions">
										<button class="btn btn-primary" type="submit">查询</button>
										<button class="btn switch-to-barcode" type="reset">清空</button>
									</div>
								</fieldset>
							</form>
							<!--  end: query form 选择学生-->

							<c:choose>
								<c:when test="${page.result==null||fn:length(page.result)==0}">
									<div class="alert alert-info">暂无教授组</div>
								</c:when>
								<c:otherwise>
									<form id="del-form" action="${ctx}/data-manage/teacher-team/del" method="post">
										<input type="hidden" value="" name="returnUrl"/>
										<table class="table table-bordered table-striped"
											id="teacher-team-table">
											<thead>
												<tr>
													<th style="width: 10px" class="center"><input
														type="checkbox" rel="uniform" class="check-all"></th>
													<th>名称</th>
													<th>病区</th>
													<th>科室</th>
													<th>二级学科</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="teacherTeam" items="${page.result}">
													<tr>
														<td class="center">
															<input id="cb-${teacherTeam.id}" type="checkbox" name="ids" value="${teacherTeam.id}" rel="uniform">
														</td>
														<td>${teacherTeam.name}</td>
														<td>${teacherTeam.area.name}</td>
														<td>${teacherTeam.area.department.name}</td>
														<td>${teacherTeam.area.department.secondarySubject.name}</td>
														<td>
															<a class="btn btn-primary btn-mini btn-edit" teacher-team-id="${teacherTeam.id}"><i class="icon-edit icon-white"></i>编辑</a>
															<a class="btn btn-danger btn-mini btn-delete-one" teacher-team-id="${teacherTeam.id}" teacher-team-name="${teacherTeam.name}"><i class="icon-trash icon-white"></i>删除</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<button class="btn btn-primary" id="btn-del" disabled="disabled">删除</button>
									</form>


									<!-- start: 分页 -->
									<div class="pagination pagination-centered">
										<form id="queryform" target="_self" style="display: none;" method="get" action="${ctx}/data-manage/teacher-team">
											<input id="pageNum" type="hidden" value="${page.pageNo}" name="pageNum">
											<input id="pageSize" type="hidden" value="${page.pageSize}" name="pageSize">
											<input id="totalCount" type="hidden" value="${page.totalCount}" name="totalCount">
											<!-- 翻页时保留查询条件 和query form要一致-->
											<input type="hidden" value="${query.area.id}" name="area.id" />
											<input type="hidden" value="${query.area.department.id}" name="area.department.id" />
											<input type="hidden" value="${query.area.department.secondarySubject.id}" name="area.department.secondarySubject.id" />
											<input type="hidden" value="${query.name}" name="name" />
										</form>

										<div id="pagination">
											<ul class="page-detail" style="margin-left: 0;"></ul>
											<ul class="page-jump-wrapper">
												<li>
													<span id="page-jump-info"> 共<em>11 </em> 页 到<input class="input-mini" type="text" maxlength="4" autocomplete="off">页
														<button type="submit" class="btn btn-small">确定</button>
													</span>
												</li>
											</ul>
										</div>
									</div>
									<!-- end:分页 -->
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
				<!--  end: 查询 -->

				<!--  start: 新增 -->
				<div class="row-fluid">
					<div class="box span12">
						<div class="box-header">
							<h2>
								<i class="halflings-icon plus-sign"></i><span class="break"></span>新增
							</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i
									class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content">
							<form id="add-form" class="form-horizontal"
								action="${ctx}/data-manage/teacher-team/add" method="post">
								<fieldset>
									<div class="control-group">
										<label for="" class="control-label">二级学科</label>
										<div class="controls">
											<select rel="uniform" class="input-small validate[required] required select-ss"
												id="ssIdAdd">
												<c:forEach var="ss" items="${allSS}">
													<option value="${ss.id}">${ss.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">科室</label>
										<div class="controls">
											<select rel="uniform" class="input-small validate[required] required select-dept"
												id="deptIdAdd">
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">病区</label>
										<div class="controls">
											<select onchange="if($('#nameAdd').val() && $('#areaIdAdd').val()) $('#nameAdd').trigger('blur');"
												name="area.id"
												rel="uniform" class="input-small validate[required] required select-area"
												id="areaIdAdd">
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">名称</label>
										<div class="controls">
											<input name="name" type="text"
												class="input-large validate[required,ajax[isNameUsed]]"	maxlength="20" placeholder="请输入教授组名称" id="nameAdd">
										</div>
									</div>


									<div class="form-actions">
										<button type="submit" class="btn btn-primary">确定</button>
										<button type="reset" class="btn">清空</button>
									</div>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
				<!--  end: 新增 -->

			</div>
			<!-- end: Content -->

			<%@ include file="/common/footer.jsp"%>

		</div>
	</div>


	<div class="modal hide fade in" id="confirmDel">
		<div class="modal-header">
			<button data-dismiss="modal" class="close" type="button">×</button>
			<h3>提示</h3>
		</div>
		<div class="modal-body">
			<p id="del-tip"></p>
			<p class="alert">
				<strong>警告!</strong>&nbsp;&nbsp;删除教授组将同时删除该教授组下的所有老师及相关考勤记录！
			</p>
		</div>
		<div class="modal-footer">
			<a data-dismiss="modal" class="btn" href="#">取消</a> <a
				class="btn btn-primary" href="#" id="btn-del-confirm">确定</a>
		</div>
	</div>

	<div class="modal hide fade in" id="editModal">
		<div class="modal-header">
			<button data-dismiss="modal" class="close" type="button">×</button>
			<h3>编辑</h3>
		</div>
		<form action="${ctx}/data-manage/teacher-team/update" method="post" class="form-horizontal" style="margin: 0">
			<input type="hidden" value="" name="returnUrl"/>
			<div class="modal-body">
			</div>
			<div class="modal-footer">
				<a data-dismiss="modal" class="btn" href="#">取消</a>
				<button class="btn btn-primary" type="submit">确定</button>
			</div>
		</form>
	</div>

	<!-- 编辑时的表单内部模板 -->
	<script id="edit-modal-temp" type="text/html">
			<fieldset>

				<div class="control-group">
					<label for="" class="control-label">二级学科</label>
					<div class="controls">
						<select 			rel="uniform"
											class="input-small validate[required] required select-ss"
											id="ssIdEdit">
												<@ for(i = 0; i < ss.length; i++){ @>
													<option
														<@ if(ss[i].id==teacherTeam.area.department.secondarySubject.id){ @> selected="selected"<@}@>
														value="<@= ss[i].id @>"><@= ss[i].name @></option>
												<@ } @>
											</select>
					</div>
				</div>

			  <div class="control-group">
					<label for="" class="control-label">科室</label>
					<div class="controls">
						<select 			rel="uniform"
											init-value="<@=teacherTeam.area.department.id@>"
											class="input-small validate[required]  required select-dept"
											id="deptIdEdit">
						</select>
					</div>
				</div>

			<div class="control-group">
					<label for="" class="control-label">病区</label>
					<div class="controls">
						<select 			onchange="if($('#nameEdit').val() && $('#areaIdEdit').val()) $('#nameEdit').trigger('blur');"
											name="area.id"
											rel="uniform"
											init-value="<@=teacherTeam.area.id@>"
											class="input-small validate[required]  required select-area"
											id="areaIdEdit">
						</select>
					</div>
				</div>

			  <div class="control-group">
					<label for="" class="control-label">名称</label>
					<div class="controls">
						<input name="name" type="text" id="nameEdit" class="input-large
										validate[required,ajax[isNameUsedWhenEdit]]
										" maxlength="20" placeholder="请输入教授组名称" value="<@=teacherTeam.name@>">
					</div>
				</div>
				<input type="hidden" value="<@=teacherTeam.id@>" name="id" id="idEdit"/>
			</fieldset>
	</script>

	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>

	<script type="text/javascript">
		$(function() {
			var baseUrl = $.appCtx + '/data-manage/teacher-team';
			// return url的设置。编辑和删除时要停留在当前页
			$("input[name=returnUrl]").val(window.location.href);
			// validationengine新增教授组时的rule扩展
			$.extend($.validationEngineLanguage.allRules,{
				"isNameUsed" : {
					// remote json service location
					"url" : baseUrl + "/add/nameCanUse",
					// error
					"alertText" : "该教授组已存在",
					"alertTextOk" : "该名称可以使用",
					"extraDataDynamic" : [ "#areaIdAdd" ],
					// speaks by itself
					"alertTextLoad" : "<img src='${ctx}/static/img/validating.gif'/>"
				},
				"isNameUsedWhenEdit" : {
					// remote json service location
					"url" : baseUrl+ "/update/nameCanUse",
					"extraDataDynamic" : [ '#idEdit','#areaIdEdit' ],
					// error
					"alertText" : "该教授组已存在",
					"alertTextOk" : "该名称可以使用",
					// speaks by itself
					"alertTextLoad" : "<img src='${ctx}/static/img/validating.gif'/>"
				}
			});



			// 新增、编辑表单校验
			$("#add-form,#editModal form").validationEngine('attach');

			// 列表中多选时看情况dis/enable掉删除按钮
			$("#teacher-team-table input[type=checkbox]").change(function() {
				$('#btn-del').attr('disabled', true);
				$("#teacher-team-table input[type=checkbox]").each(function() {
					if ($(this).attr('checked'))
						$('#btn-del').removeAttr('disabled');
				});
			});

			// 弹出批量删除确认框
			$('#btn-del').click(function(e) {
				e.preventDefault();
				$('#del-tip').html("确定删除该<em>"+ $("#teacher-team-table tbody input[type=checkbox]:checked").length+ "</em>条记录？");
				$('#confirmDel').modal();
				// 更新“确认”按钮的事件
				$('#btn-del-confirm').off('click').click(function() {
							$('#del-form').submit();
				});
			});

			// 单个删除确认框
			$('.btn-delete-one').click(function(e) {
				e.preventDefault();
				$('#del-tip').html("确定删除记录 <em>"
								+ $(this).attr('teacher-team-name')
								+ "</em> 吗？");
				$('#confirmDel').modal();
				self = $(this);
				// 更新“确认”按钮的事件
				$('#btn-del-confirm').off('click').click(function() {
					// 取消表格中所有复选框的选中状态，选中当前记录。最后提交删除表单。
					var cbs = $('#del-form input[type=checkbox]:checked')
					cbs.removeAttr('checked');
					$('#cb-'+ self.attr('teacher-team-id')).attr('checked',true);
					$.uniform.update(cbs);
					$.uniform.update($('#cb-'+ self.attr('teacher-team-id')));
					$('#del-form').submit();
				});
			});

			// 弹出编辑框
			$('.btn-edit').click(function(e) {
				self = $(this);
				$.get($.appCtx+ "/data-manage/secondary-subject/all",function(ss){
					$.get($.appCtx+ "/data-manage/teacher-team/"+ self.attr('teacher-team-id'),function(data) {
							if (data) {
								$('#editModal .modal-body').empty().html(template.render('edit-modal-temp',{"teacherTeam" : data,"ss":ss}))
										.find('select[rel="uniform"],input:checkbox, input:radio, input:file')
										.not('[data-no-uniform="true"],#uniform-is-ajax')
										.uniform();// uniform化表单元素

								$('#editModal .select-ss').trigger('change'); //加载科室、病区下拉框

								$('#editModal').modal();
							}

					});
				});

				});
		});
	</script>
	<!-- end: JavaScript-->
</body>
</html>
