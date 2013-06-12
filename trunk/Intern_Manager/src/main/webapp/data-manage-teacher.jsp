<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.hustsse.cloud.enums.*"%>
<%@ include file="/common/taglibs.jsp"%>

<c:set var="pageTitle" value="数据管理-老师" scope="page"></c:set>
<c:set var="genderEnums" value="<%=GenderEnum.values()%>"/>

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
				<c:set var="dataManCurPage" value="teacher" scope="page"></c:set>
				<%@ include file="/common/data-man-nav.jsp"%>

				<!--  start: 老师 -->
				<div class="row-fluid">
					<div class="box span12">
						<div class="box-header">
							<h2>
								<i class="halflings-icon search"></i><span class="break"></span>老师
							</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content">
							<!-- start: query form -->
							<form action="${ctx}/data-manage/teacher" class="form-horizontal query-form float-form">
								<fieldset>
									<div class="control-group">
										<label for="" class="control-label">二级学科</label>
										<div class="controls">
											<select name="teacherTeam.area.department.secondarySubject.id" id="" class="input-mini select-ss" rel="uniform">
												<option value=""></option>
												<c:forEach var="ss" items="${allSS}">
													<option value="${ss.id}"
														<c:if test="${query.teacherTeam.area.department.secondarySubject.id==ss.id}">selected="selected"</c:if>>${ss.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">科室</label>
										<div class="controls">
											<select name="teacherTeam.area.department.id" id="" class="input-mini select-dept" rel="uniform"
												<c:if test="${query.teacherTeam.area.department.id!=null}">init-value="${query.teacherTeam.area.department.id}"</c:if>>
												<option value=""></option>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">病区</label>
										<div class="controls">
											<select name="teacherTeam.area.id"
												rel="uniform" class="input-mini select-area"
												<c:if test="${query.teacherTeam.area.id!=null}">init-value="${query.teacherTeam.area.id}"</c:if>>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">教授组</label>
										<div class="controls">
											<select name="teacherTeam.id"
												rel="uniform" class="input-mini select-team"
												<c:if test="${query.teacherTeam.id!=null}">init-value="${query.teacherTeam.id}"</c:if>>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">名称</label>
										<div class="controls">
											<input type="text" value="${query.name}" name="name" class="input-medium" placeholder="请输入老师名称">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">工号</label>
										<div class="controls">
											<input type="text" value="${query.teacherNo}" name="teacherNo" class="input-medium" placeholder="请输入老师工号">
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
									<div class="alert alert-info">暂无老师</div>
								</c:when>
								<c:otherwise>
									<form id="del-form" action="${ctx}/data-manage/teacher/del" method="post">
										<input type="hidden" value="" name="returnUrl"/>
										<table class="table table-bordered table-striped"
											id="teacher-table">
											<thead>
												<tr>
													<th style="width: 10px" class="center"><input
														type="checkbox" rel="uniform" class="check-all"></th>
													<th>工号</th>
													<th>名称</th>
													<th>教授组</th>
													<th>病区</th>
													<th>科室</th>
													<th>二级学科</th>
													<th>性别</th>
													<th>出生日期</th>
													<th>操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="teacher" items="${page.result}">
													<tr>
														<td class="center">
															<input id="cb-${teacher.id}" type="checkbox" name="ids" value="${teacher.id}" rel="uniform">
														</td>
														<td>${teacher.teacherNo}</td>
														<td>${teacher.name}</td>
														<td>${teacher.teacherTeam.name}</td>
														<td>${teacher.teacherTeam.area.name}</td>
														<td>${teacher.teacherTeam.area.department.name}</td>
														<td>${teacher.teacherTeam.area.department.secondarySubject.name}</td>
														<td>${teacher.gender.description}</td>
														<td><fmt:formatDate value="${teacher.birthday}" type="date" pattern="yyyy-MM-dd"/></td>
														<td>
															<a class="btn btn-primary btn-mini btn-edit" teacher-id="${teacher.id}"><i class="icon-edit icon-white"></i>编辑</a>
															<a class="btn btn-danger btn-mini btn-delete-one" teacher-id="${teacher.id}" teacher-no="${teacher.teacherNo}" teacher-name="${teacher.name}"><i class="icon-trash icon-white"></i>删除</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<button class="btn btn-primary" id="btn-del" disabled="disabled">删除</button>
									</form>


									<!-- start: 分页 -->
									<div class="pagination pagination-centered">
										<form id="queryform" target="_self" style="display: none;" method="get" action="${ctx}/data-manage/teacher">
											<input id="pageNum" type="hidden" value="${page.pageNo}" name="pageNum">
											<input id="pageSize" type="hidden" value="${page.pageSize}" name="pageSize">
											<input id="totalCount" type="hidden" value="${page.totalCount}" name="totalCount">
											<!-- 翻页时保留查询条件 和query form要一致-->
											<input type="hidden" value="${query.teacherTeam.id}" name="teacherTeam.id" />
											<input type="hidden" value="${query.teacherTeam.area.id}" name="teacherTeam.area.id" />
											<input type="hidden" value="${query.teacherTeam.area.department.id}" name="teacherTeam.area.department.id" />
											<input type="hidden" value="${query.teacherTeam.area.department.secondarySubject.id}" name="teacherTeam.area.department.secondarySubject.id" />
											<input type="hidden" value="${query.name}" name="name" />
											<input type="hidden" value="${query.teacherNo}" name="teacherNo" />
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
								action="${ctx}/data-manage/teacher/add" method="post">
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
											<select rel="uniform" class="input-small validate[required] required select-dept">
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">病区</label>
										<div class="controls">
											<select rel="uniform" class="input-small validate[required] required select-area">
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">教授组</label>
										<div class="controls">
											<select name="teacherTeam.id" onchange="if($('noAdd').val() && $('#teamIdAdd').val()) $('#noAdd').trigger('blur');"
												rel="uniform" class="input-small validate[required] required select-team"
												id="teamIdAdd">
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">工号</label>
										<div class="controls">
											<input name="teacherNo" type="text"
												class="input-large validate[required,ajax[isNoUsed]]"	maxlength="20" placeholder="请输入老师工号" id="noAdd">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">名称</label>
										<div class="controls">
											<input name="name" type="text"
												class="input-large validate[required]"	maxlength="20" placeholder="请输入老师名称" id="nameAdd">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">性别</label>
										<div class="controls">
											<select name="gender" rel="uniform" class="input-small">
												<c:forEach var="g" items="${genderEnums}">
													<option value="${g}">${g.description}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">出生日期</label>
										<div class="controls">
											<input name="birthday" type="text" yearRange="1970:2000" class="input-large datepicker-dropdown-year-month validate[custom[date]]" placeholder="格式 1983-01-02">
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
			<p class="alert hide">
				<strong>警告!</strong>&nbsp;&nbsp;删除老师将同时删除该老师下的所有及相关考勤记录！
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
		<form action="${ctx}/data-manage/teacher/update" method="post" class="form-horizontal" style="margin: 0">
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
														<@ if(ss[i].id==teacher.teacherTeam.area.department.secondarySubject.id){ @> selected="selected"<@}@>
														value="<@= ss[i].id @>"><@= ss[i].name @></option>
												<@ } @>
											</select>
					</div>
				</div>

			  <div class="control-group">
					<label for="" class="control-label">科室</label>
					<div class="controls">
						<select 			rel="uniform"
											init-value="<@=teacher.teacherTeam.area.department.id@>"
											class="input-small validate[required]  required select-dept">
						</select>
					</div>
				</div>

			<div class="control-group">
					<label for="" class="control-label">病区</label>
					<div class="controls">
						<select 			rel="uniform"
											init-value="<@=teacher.teacherTeam.area.id@>"
											class="input-small validate[required]  required select-area">
						</select>
					</div>
				</div>

			<div class="control-group">
					<label for="" class="control-label">教授组</label>
					<div class="controls">
						<select 			name="teacherTeam.id"
											rel="uniform"
											init-value="<@=teacher.teacherTeam.id@>"
											class="input-small validate[required]  required select-team">
						</select>
					</div>
				</div>

				<div class="control-group">
										<label for="" class="control-label">工号</label>
										<div class="controls">
											<input name="teacherNo" type="text" value="<@=teacher.teacherNo@>"
												class="input-medium validate[required,ajax[isNoUsedWhenEdit]]"	maxlength="20" placeholder="请输入老师工号" id="noEdit">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">名称</label>
										<div class="controls">
											<input name="name" type="text" value="<@=teacher.name@>"
												class="input-medium validate[required]"	maxlength="20" placeholder="请输入老师名称" id="nameEdit">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">性别</label>
										<div class="controls">
											<select name="gender" rel="uniform" class="input-small">
													<!--这种数据字典下拉框基本不会变就从别的控件拷过来，不ajax请求了-->
													<@$('select[name=gender]').eq(0).find("option").each(function(i,e){@>
															<@==$.getJqueryOuterHtml($(e).removeAttr('selected').attr('selected',$(e).attr('value') == teacher.gender))@>
													<@});@>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">出生日期</label>
										<div class="controls">
											<input name="birthday"
													<@if(teacher.birthday){@>
														value="<@=moment(teacher.birthday).format('YYYY-MM-DD')@>"
													<@}@>
												type="text" yearRange="1970:2000" class="input-medium datepicker-dropdown-year-month validate[custom[date]]" placeholder="格式 1983-01-02">
										</div>
									</div>

				<input type="hidden" value="<@=teacher.id@>" name="id" id="idEdit"/>
			</fieldset>
	</script>

	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>

	<script type="text/javascript">
		$(function() {
			var baseUrl = $.appCtx + '/data-manage/teacher';
			// return url的设置。编辑和删除时要停留在当前页
			$("input[name=returnUrl]").val(window.location.href);
			// validationengine新增老师时的rule扩展
			$.extend($.validationEngineLanguage.allRules,{
				"isNoUsed" : {
					// remote json service location
					"url" : baseUrl + "/add/noCanUse",
					// error
					"alertText" : "该工号已被使用",
					"alertTextOk" : "该工号可以使用",
					// speaks by itself
					"alertTextLoad" : "<img src='${ctx}/static/img/validating.gif'/>"
				},
				"isNoUsedWhenEdit" : {
					// remote json service location
					"url" : baseUrl+ "/update/noCanUse",
					"extraDataDynamic" : [ '#idEdit' ],
					// error
					"alertText" : "该工号已被使用",
					"alertTextOk" : "该工号可以使用",
					// speaks by itself
					"alertTextLoad" : "<img src='${ctx}/static/img/validating.gif'/>"
				}
			});



			// 新增、编辑表单校验
			$("#add-form,#editModal form").validationEngine('attach');

			// 列表中多选时看情况dis/enable掉删除按钮
			$("#teacher-table input[type=checkbox]").change(function() {
				$('#btn-del').attr('disabled', true);
				$("#teacher-table input[type=checkbox]").each(function() {
					if ($(this).attr('checked'))
						$('#btn-del').removeAttr('disabled');
				});
			});

			// 弹出批量删除确认框
			$('#btn-del').click(function(e) {
				e.preventDefault();
				$('#del-tip').html("确定删除该<em>"+ $("#teacher-table tbody input[type=checkbox]:checked").length+ "</em>条记录？");
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
								+ $(this).attr('teacher-no') + "&nbsp;&nbsp;" + $(this).attr('teacher-name')
								+ "</em> 吗？");
				$('#confirmDel').modal();
				self = $(this);
				// 更新“确认”按钮的事件
				$('#btn-del-confirm').off('click').click(function() {
					// 取消表格中所有复选框的选中状态，选中当前记录。最后提交删除表单。
					var cbs = $('#del-form input[type=checkbox]:checked')
					cbs.removeAttr('checked');
					$('#cb-'+ self.attr('teacher-id')).attr('checked',true);
					$.uniform.update(cbs);
					$.uniform.update($('#cb-'+ self.attr('teacher-id')));
					$('#del-form').submit();
				});
			});

			// 弹出编辑框
			$('.btn-edit').click(function(e) {
				self = $(this);
				$.get($.appCtx+ "/data-manage/secondary-subject/all",function(ss){
					$.get($.appCtx+ "/data-manage/teacher/"+ self.attr('teacher-id'),function(data) {
							if (data) {
								$('#editModal .modal-body').empty().html(template.render('edit-modal-temp',{
									"teacher" : data,
									"ss":ss,
									"$":$,
									"moment":moment
								})).find('select[rel="uniform"],input:checkbox, input:radio, input:file')
									.not('[data-no-uniform="true"],#uniform-is-ajax')
									.uniform();// uniform化表单元素

								$('#editModal .select-ss').trigger('change'); //加载科室、病区、教授组下拉框
								$('#editModal .datepicker-dropdown-year-month')
									.datepicker({changeYear:true,changeMonth:true,yearRange:$(e).attr('yearRange')}); // 日期选择
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
