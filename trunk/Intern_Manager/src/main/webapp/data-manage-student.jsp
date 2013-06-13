<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<c:set var="pageTitle" value="数据管理-学生" scope="page"></c:set>
<c:set var="genderEnums" value="<%=GenderEnum.values()%>"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<%@ include file="/common/head-inner.jsp"%>
<style type="text/css">
	.popover-content{padding:0;}
	.popover-content>div{padding:9px 14px;}
</style>
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
				<c:set var="dataManCurPage" value="student" scope="page"></c:set>
				<%@ include file="/common/data-man-nav.jsp"%>

				<!--  start: 学生 -->
				<div class="row-fluid">
					<div class="box span12">
						<div class="box-header">
							<h2>
								<i class="halflings-icon search"></i><span class="break"></span>学生
							</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content">
							<!-- start: query form -->
							<form action="${ctx}/data-manage/student" class="form-horizontal query-form float-form">
								<fieldset>
									<div class="control-group">
										<label for="" class="control-label">学号</label>
										<div class="controls">
											<input type="text" value="${query.stuNo}" name="stuNo" class="input-medium" placeholder="请输入学生学号">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">姓名</label>
										<div class="controls">
											<input type="text" value="${query.name}" name="name" class="input-medium" placeholder="请输入学生姓名">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">专业</label>
										<div class="controls">
											<select name="major.id" class="input-mini" rel="uniform">
												<option value=""></option>
												<c:forEach var="m" items="${allMajor}">
													<option value="${m.id}"
														<c:if test="${query.major.id==m.id}">selected="selected"</c:if>>${m.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">年级</label>
										<div class="controls">
											<input  data-mask="9999" value="${query.grade}" name="grade" type="text" class="input-medium" placeholder="请输入学生年级">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">班级</label>
										<div class="controls">
											<input type="text" data-mask="99" value="${query.clazz}" name="clazz" class="input-medium" placeholder="请输入学生班级">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">导师</label>
										<div class="controls">
											<input type="text" value="${query.mentor}" name="mentor" class="input-medium" placeholder="请输入学生导师">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">类别</label>
										<div class="controls">
											<select name="type" rel="uniform" class="input-small">
													<option value=""></option>
												<c:forEach var="t" items="${stuTypeEnums}">
													<option value="${t}"
														<c:if test="${query.type == t}">selected="selected"</c:if>
													>${t.description}</option>
												</c:forEach>
											</select>
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
									<div class="alert alert-info">暂无学生</div>
								</c:when>
								<c:otherwise>
									<form id="del-form" action="${ctx}/data-manage/student/del" method="post">
										<input type="hidden" value="" name="returnUrl"/>
										<table class="table table-bordered table-striped"
											id="student-table">
											<thead>
												<tr>
													<th style="width: 10px" class="center"><input
														type="checkbox" rel="uniform" class="check-all"></th>
													<th>学号</th>
													<th>姓名</th>
													<th>类别</th>
													<th>专业</th>
													<th>年级</th>
													<th>班级</th>
													<th>性别</th>
													<th>导师</th>
													<th>出生日期</th>
													<th>描述</th>
													<th style="width:102px">操作</th>
												</tr>
											</thead>
											<tbody>
												<c:forEach var="student" items="${page.result}">
													<tr>
														<td class="center">
															<input id="cb-${student.id}" type="checkbox" name="ids" value="${student.id}" rel="uniform">
														</td>
														<td>${student.stuNo}</td>
														<td>
															<c:choose>
																<c:when test="${student.avatar==null}">
																	${student.name}
																</c:when>
																<c:otherwise>
																	<span
																	style="cursor:pointer;"
																	data-toggle="popover"
																	data-html="true"
																	data-placement="top"
																	data-trigger="hover"
																	data-content="<img class='avatar' src='${ctx}${student.avatar}?x=<%=Math.random()%>'>" >
																		<i class="fa-icon-user"
																		style="font-size:14px;">
																		</i>
																		${student.name}
																	</span>
																</c:otherwise>
															</c:choose>
														</td>
														<td>${student.type.description}</td>
														<td>${student.major.name}</td>
														<td>${student.grade}</td>
														<td>${student.clazz>10?"":"0"}${student.clazz}</td>
														<td>${student.gender.description}</td>
														<td>${student.mentor}</td>
														<td><fmt:formatDate value="${student.birthday}" type="date" pattern="yyyy-MM-dd"/></td>
														<td>
															<div
															style="width:150px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;cursor:pointer;"
															data-toggle="popover"
															data-html="true"
															data-placement="top"
															data-content="<div>${student.description}</div>">
																${student.description}
															</div>
														</td>
														<td>
															<a class="btn btn-primary btn-mini btn-edit" student-id="${student.id}"><i class="icon-edit icon-white"></i>编辑</a>
															<a class="btn btn-danger btn-mini btn-delete-one" student-id="${student.id}" student-no="${student.stuNo}" student-name="${student.name}"><i class="icon-trash icon-white"></i>删除</a></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
										<button class="btn btn-primary" id="btn-del" disabled="disabled">删除</button>
									</form>


									<!-- start: 分页 -->
									<div class="pagination pagination-centered">
										<form id="queryform" target="_self" style="display: none;" method="get" action="${ctx}/data-manage/student">
											<input id="pageNum" type="hidden" value="${page.pageNo}" name="pageNum">
											<input id="pageSize" type="hidden" value="${page.pageSize}" name="pageSize">
											<input id="totalCount" type="hidden" value="${page.totalCount}" name="totalCount">
											<!-- 翻页时保留查询条件 和query form要一致-->
											<input type="hidden" value="${query.stuNo}" name="stuNo" />
											<input type="hidden" value="${query.name}" name="name" />
											<input type="hidden" value="${query.major.id}" name="major.id" />
											<input type="hidden" value="${query.grade}" name="grade" />
											<input type="hidden" value="${query.clazz}" name="clazz" />
											<input type="hidden" value="${query.mentor}" name="mentor" />
											<input type="hidden" value="${query.type}" name="type" />
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
							<form id="add-form" enctype="multipart/form-data" class="form-horizontal"
								action="${ctx}/data-manage/student/add" method="post">
								<fieldset>

									<div class="control-group">
										<label for="" class="control-label">学号</label>
										<div class="controls">
											<input name="stuNo" type="text" class="input-large required validate[required,ajax[isNoUsed]]" placeholder="请输入学生学号"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">姓名</label>
										<div class="controls">
											<input name="name" type="text" class="input-large validate[required]" placeholder="请输入学生姓名">
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
											<input type="text" name="birthday" yearRange="1970:2000" data-mask="9999-99-99" class="validate[custom[date]] input-large datepicker-dropdown-year-month" placeholder="格式 1983-01-02">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">专业</label>
										<div class="controls">
											<select name="major.id" class="input-mini validate[required]" rel="uniform">
												<c:forEach var="m" items="${allMajor}">
													<option value="${m.id}"
														<c:if test="${query.major.id==m.id}">selected="selected"</c:if>>${m.name}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">导师</label>
										<div class="controls"><input name="mentor" type="text" class="input-large validate[required]" placeholder="请输入导师姓名"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">年级</label>
										<div class="controls"><input name="grade" type="text" class="input-large validate[required]" placeholder="请输入年级" data-mask="9999"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">班级</label>
										<div class="controls"><input name="clazz" type="text" class="input-large validate[required]" placeholder="请输入班级" data-mask="99"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">类别</label>
										<div class="controls">
											<select name="type" id="" class="input-mini validate[required]" rel="uniform">
												<c:forEach var="t" items="${stuTypeEnums}">
													<option value="${t}">${t.description}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">照片</label>
										<div class="controls">
											<div class="fileupload fileupload-new" data-provides="fileupload">
											  	<div class="fileupload-new thumbnail tip-thumbnail">
											  		<img src="http://www.placehold.it/150x150/EFEFEF/AAAAAA" />
											 	</div>
											  	<div class="fileupload-preview fileupload-exists thumbnail"></div>
												<div>
													<span class="btn btn-file">
														<span class="fileupload-new">选择文件</span>
														<span class="fileupload-exists">修改</span>
														<input type="file" name="img" data-no-uniform="true"/>
													</span>
													<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">取消</a>
												</div>
											</div>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">描述</label>
										<div class="controls">
											<textarea name="description" maxlength="200" type="text" class="input-xlarge"></textarea></div>
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
				<strong>警告!</strong>&nbsp;&nbsp;删除学生将同时删除该学生的所有考勤记录！
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
		<form action="${ctx}/data-manage/student/update" method="post" class="form-horizontal" enctype="multipart/form-data" style="margin: 0">
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
										<label for="" class="control-label">学号</label>
										<div class="controls">
											<input value="<@=student.stuNo@>" name="stuNo" type="text" class="input-large required validate[required,ajax[isNoUsedWhenEdit]]" placeholder="请输入学生学号"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">姓名</label>
										<div class="controls">
											<input value="<@=student.name@>" name="name" type="text" class="input-large validate[required]" placeholder="请输入学生姓名">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">性别</label>
										<div class="controls">
											<select name="gender" rel="uniform" class="input-small">
												<!--这种数据字典下拉框基本不会变就从别的控件拷过来，不ajax请求了-->
												<@$('select[name=gender]').eq(0).find("option").each(function(i,e){@>
														<@==$.getJqueryOuterHtml($(e).removeAttr('selected').attr('selected',$(e).attr('value') == student.gender))@>
												<@});@>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">出生日期</label>
										<div class="controls">
											<input value="<@=moment(student.birthday).format('YYYY-MM-DD')@>" type="text" name="birthday" yearRange="1970:2000" data-mask="9999-99-99" class="validate[custom[date]] input-large datepicker-dropdown-year-month" placeholder="格式 1983-01-02">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">专业</label>
										<div class="controls">
											<select name="major.id" class="input-mini validate[required]" rel="uniform">
												<!--这种数据字典下拉框基本不会变就从别的控件拷过来，不ajax请求了-->
												<@$('#add-form select[name="major.id"]').eq(0).find("option").each(function(i,e){@>
														<@==$.getJqueryOuterHtml($(e).removeAttr('selected').attr('selected',$(e).attr('value') == student.major.id))@>
												<@});@>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">导师</label>
										<div class="controls"><input value="<@=student.mentor@>" name="mentor" type="text" class="input-large validate[required]" placeholder="请输入导师姓名"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">年级</label>
										<div class="controls"><input value="<@=student.grade@>" name="grade" type="text" class="input-large validate[required]" placeholder="请输入年级" data-mask="9999"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">班级</label>
										<div class="controls"><input value="<@=(student.clazz<10)?"0"+(student.clazz):student.clazz@>" name="clazz" type="text" class="input-large validate[required]" placeholder="请输入班级" data-mask="99"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">类别</label>
										<div class="controls">
											<select name="type" id="" class="input-mini validate[required]" rel="uniform">
												<!--这种数据字典下拉框基本不会变就从别的控件拷过来，不ajax请求了-->
												<@$('#add-form select[name=type]').eq(0).find("option").each(function(i,e){@>
														<@==$.getJqueryOuterHtml($(e).removeAttr('selected').attr('selected',$(e).attr('value') == student.type))@>
												<@});@>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">照片</label>
										<div class="controls">
											<div class="fileupload fileupload-new" data-provides="fileupload">
											  	<div class="fileupload-new thumbnail tip-thumbnail">
											  		<img src="<@=$.appCtx+student.avatar@>?x=<@=Math.random()@>" />
											 	</div>
											  	<div class="fileupload-preview fileupload-exists thumbnail"></div>
												<div>
													<span class="btn btn-file">
														<span class="fileupload-new">选择文件</span>
														<span class="fileupload-exists">修改</span>
														<input type="file" data-no-uniform="true"/>
													</span>
													<a href="#" class="btn fileupload-exists" data-dismiss="fileupload">取消</a>
												</div>
											</div>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">描述</label>
										<div class="controls">
											<textarea name="description" maxlength="200" type="text" class="input-xlarge"><@=student.description@></textarea>
										</div>
									</div>
									<input type="hidden" value="<@=student.id@>" name="id" id="idEdit"/>
			</fieldset>
	</script>

	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>

	<script type="text/javascript">
		$(function() {
			var baseUrl = $.appCtx + '/data-manage/student';
			// return url的设置。编辑和删除时要停留在当前页
			$("input[name=returnUrl]").val(window.location.href);
			// validationengine新增学生时的rule扩展
			$.extend($.validationEngineLanguage.allRules,{
				"isNoUsed" : {
					// remote json service location
					"url" : baseUrl + "/add/noCanUse",
					// error
					"alertText" : "该学号已被使用",
					"alertTextOk" : "该学号可以使用",
					// speaks by itself
					"alertTextLoad" : "<img src='${ctx}/static/img/validating.gif'/>"
				},
				"isNoUsedWhenEdit" : {
					// remote json service location
					"url" : baseUrl+ "/update/noCanUse",
					"extraDataDynamic" : [ '#idEdit' ],
					// error
					"alertText" : "该学号已被使用",
					"alertTextOk" : "该学号可以使用",
					// speaks by itself
					"alertTextLoad" : "<img src='${ctx}/static/img/validating.gif'/>"
				}
			});



			// 新增、编辑表单校验
			$("#add-form,#editModal form").validationEngine('attach');

			// 列表中多选时看情况dis/enable掉删除按钮
			$("#student-table input[type=checkbox]").change(function() {
				$('#btn-del').attr('disabled', true);
				$("#student-table input[type=checkbox]").each(function() {
					if ($(this).attr('checked'))
						$('#btn-del').removeAttr('disabled');
				});
			});

			// 弹出批量删除确认框
			$('#btn-del').click(function(e) {
				e.preventDefault();
				$('#del-tip').html("确定删除该<em>"+ $("#student-table tbody input[type=checkbox]:checked").length+ "</em>条记录？");
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
								+ $(this).attr('student-no') + "&nbsp;&nbsp;" + $(this).attr('student-name')
								+ "</em> 吗？");
				$('#confirmDel').modal();
				self = $(this);
				// 更新“确认”按钮的事件
				$('#btn-del-confirm').off('click').click(function() {
					// 取消表格中所有复选框的选中状态，选中当前记录。最后提交删除表单。
					var cbs = $('#del-form input[type=checkbox]:checked')
					cbs.removeAttr('checked');
					$('#cb-'+ self.attr('student-id')).attr('checked',true);
					$.uniform.update(cbs);
					$.uniform.update($('#cb-'+ self.attr('student-id')));
					$('#del-form').submit();
				});
			});

			// 弹出编辑框
			$('.btn-edit').click(function(e) {
				self = $(this);
				$.get($.appCtx+ "/data-manage/student/"+ self.attr('student-id'),function(data) {
						if (data) {
							$('#editModal .modal-body').empty().html(template.render('edit-modal-temp',{
								"student" : data,
								"$":$,
								"moment":moment,
								'Math':Math
							})).find('select[rel="uniform"],input:checkbox, input:radio, input:file')
								.not('[data-no-uniform="true"],#uniform-is-ajax')
								.uniform();// uniform化表单元素

							$('#editModal .datepicker-dropdown-year-month')
								.datepicker({changeYear:true,changeMonth:true,yearRange:$(e).attr('yearRange')}); // 日期选择

							// img upload, {'name':'img'} : Use this option instead of setting the name attribute on the <input> element to prevent it from being part of the post data when not changed
							$('#editModal .fileupload').fileupload({'name':'img'});

							$('#editModal').modal();
						}

				});

				});
		});
	</script>
	<!-- end: JavaScript-->
</body>
</html>
