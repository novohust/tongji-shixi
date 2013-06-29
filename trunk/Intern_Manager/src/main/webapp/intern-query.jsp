<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<c:set var="pageTitle" value="考勤查询" scope="page"></c:set>

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
			<div id="content" class="span11">
					<!-- start: query form 选择学生 -->
					<form action="" class="form-horizontal query-form float-form">
						<fieldset>
							<!-- start: 选择教授组和老师  -->
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

							<div class="control-group" style="margin-left:100px;">
								<label for="" class="control-label">带教老师</label>
								<div class="controls">
									<select name="teacher.id" id="" class="input-mini" rel="uniform">
										<option value=""></option>
										<c:forEach var="t" items="${allTeacher}">
											<option value="${t.id}"
												<c:if test="${query.teacher.id==t.id}">selected="selected"</c:if>>${t.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<!-- end: 选择教授组和老师  -->
							<div class="clearfix"></div>

							<!-- start: 学生查询条件  -->
							<div class="control-group">
								<label for="" class="control-label">类别</label>
								<div class="controls">
									<select name="student.type" rel="uniform" class="input-mini">
										<option value=""></option>
										<c:forEach var="t" items="${stuTypeEnums}">
											<option value="${t}"
												<c:if test="${query.student.type == t}">selected="selected"</c:if>
											>${t.description}</option>
										</c:forEach>
									</select>
								</div>
							</div>


							<div class="control-group">
								<label for="" class="control-label">专业</label>
								<div class="controls">
									<select name="student.major.id" class="input-mini" rel="uniform">
										<option value=""></option>
										<c:forEach var="m" items="${allMajor}">
											<option value="${m.id}"
												<c:if test="${query.student.major.id==m.id}">selected="selected"</c:if>>${m.name}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="control-group">
								<label for="" class="control-label">学号</label>
								<div class="controls">
									<input type="text" value="${query.student.stuNo}" name="student.stuNo" class="input-small" placeholder="请输入学生学号">
								</div>
							</div>

							<div class="control-group">
								<label for="" class="control-label">姓名</label>
								<div class="controls">
									<input type="text" value="${query.student.name}" name="student.name" class="input-small" placeholder="请输入学生姓名">
								</div>
							</div>

							<div class="control-group">
								<label for="" class="control-label">年级</label>
								<div class="controls">
									<input  data-mask="9999" value="${query.student.grade}" name="student.grade" type="text" class="input-mini" placeholder="格式:2013">
								</div>
							</div>

							<div class="control-group">
								<label for="" class="control-label">班级</label>
								<div class="controls">
									<input type="text" data-mask="99" value="${query.student.clazz}" name="student.clazz" class="input-mini" placeholder="格式: 02">
								</div>
							</div>

							<div class="control-group">
								<label for="" class="control-label">导师</label>
								<div class="controls">
									<input type="text" value="${query.student.mentor}" name="student.mentor" class="input-small" placeholder="请输入导师姓名">
								</div>
							</div>
							<!-- end: 学生查询条件  -->

							<div class="clearfix"></div>

							<!-- start: 起始结束时间查询条件 -->
							<div class="control-group">
								<label for="" class="control-label">起始时间</label>
								<div class="controls">
									<select name="startYear" id="" class="input-mini" rel="uniform">
										<option value=""></option>
										<c:forEach var="item" varStatus="status" begin="2013" end="2050">
											<option ${startYear == status.index? "selected='selected'":""} value="${status.index}">${status.index}</option>
										</c:forEach>
									</select>
									<select name="startMonth" id="" class="input-mini" rel="uniform">
										<option value=""></option>
										<c:forEach var="item" varStatus="status" begin="1" end="12">
											<option ${startMonth == status.index? "selected='selected'":""} value="${status.index}">${status.index}</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<div class="control-group">
								<label for="" class="control-label">结束时间</label>
								<div class="controls">
									<select name="endYear" id="" class="input-mini" rel="uniform">
										<option value=""></option>
										<c:forEach var="item" varStatus="status" begin="2013" end="2050">
											<option ${endYear == status.index? "selected='selected'":""} value="${status.index}">${status.index}</option>
										</c:forEach>
									</select>
									<select name="endMonth" id="" class="input-mini" rel="uniform">
										<option value=""></option>
										<c:forEach var="item" varStatus="status" begin="1" end="12">
											<option ${endMonth == status.index? "selected='selected'":""} value="${status.index}">${status.index}</option>
										</c:forEach>
									</select>
								</div>
							</div>
							<!-- end: 起始结束时间查询条件 -->

							<div class="float-form-actions" >
								<button class="btn btn-primary" type="submit">查询</button>
								<a href="#" id="export-excel" class="btn btn-success" ${page.result eq null || fn:length(page.result)==0?"disabled='disabled'":""}>导出</a>
							  </div>
						</fieldset>
					</form>
					<!--  end: query form 选择学生-->

					<c:choose>
						<c:when test="${page.result==null||fn:length(page.result)==0}">
							<div class="alert alert-info">没有符合查询条件的考勤记录</div>
						</c:when>
						<c:otherwise>
							<form id="del-form" action="${ctx}/intern-query/del" method="post">
								<input type="hidden" value="" name="returnUrl"/>
								<table class="table table-bordered table-striped" id="intern-table">
									<thead>
										<tr>
											<th style="width: 10px" class="center"><input type="checkbox" rel="uniform" class="check-all"></th>
											<th>学号</th>
											<th>姓名</th>
											<th>类别</th>
											<th>专业</th>
											<th>年级</th>
											<th>班级</th>
											<th>导师</th>
											<th>带教老师</th>
											<th>教授组</th>
											<th>病区</th>
											<th>科室</th>
											<th>二级学科</th>
											<th>实习时间</th>
											<th>操作</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="i" items="${page.result}">
											<tr>
												<td class="center">
													<input id="cb-${i.id}" type="checkbox" name="ids" value="${i.id}" rel="uniform">
												</td>
												<td>${i.student.stuNo}</td>
												<td><a href="#" title="点击查看详细信息" data-toggle="tooltip" class="stu-detail-link" stu-id="${i.student.id}">${i.student.name}</a></td>
												<td>${i.student.type.description}</td>
												<td>${i.student.major.name}</td>
												<td>${i.student.grade}</td>
												<td>${i.student.clazz}</td>
												<td>${i.student.mentor}</td>
												<td>${i.teacher.name}</td>
												<td>${i.teacherTeam.name}</td>
												<td>${i.teacherTeam.area.name}</td>
												<td>${i.teacherTeam.area.department.name}</td>
												<td>${i.teacherTeam.area.department.secondarySubject.name}</td>
												<td>${i.year}-${i.month}&nbsp;${i.weekType.description}</td>
												<td>
													<a class="btn btn-danger btn-mini btn-delete-one" intern-id="${i.id}" ><i class="icon-trash icon-white"></i>删除</a></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
								<button class="btn btn-primary" id="btn-del" disabled="disabled">删除</button>
							</form>


							<!-- start: 分页 -->
							<div class="pagination pagination-centered">
								<form id="queryform" target="_self" style="display: none;" method="get">
									<input id="pageNum" type="hidden" value="${page.pageNo}" name="pageNum">
									<input id="pageSize" type="hidden" value="${page.pageSize}" name="pageSize">
									<input id="totalCount" type="hidden" value="${page.totalCount}" name="totalCount">
									<!-- 翻页时保留查询条件 和query form要一致-->
									<input type="hidden" value="${query.teacherTeam.area.department.secondarySubject.id}" name="teacherTeam.area.department.secondarySubject.id" />
									<input type="hidden" value="${query.teacherTeam.area.department.id}" name="teacherTeam.area.department.id"/>
									<input type="hidden" value="${query.teacherTeam.area.id}" name="teacherTeam.area.id"/>
									<input type="hidden" value="${query.teacherTeam.id}" name="teacherTeam.id"/>

									<input type="hidden" value="${query.teacher.id}" name="teacher.id"/>

									<input type="hidden" value="${query.student.type}" name="student.type"/>
									<input type="hidden" value="${query.student.major.id}" name="student.major.id"/>
									<input type="hidden" value="${query.student.stuNo}" name="student.stuNo"/>
									<input type="hidden" value="${query.student.name}" name="student.name"/>
									<input type="hidden" value="${query.student.grade}" name="student.grade"/>
									<input type="hidden" value="${query.student.clazz}" name="student.clazz"/>
									<input type="hidden" value="${query.student.mentor}" name="student.mentor"/>

									<input type="hidden" value="${startYear}" name="startYear"/>
									<input type="hidden" value="${startMonth}" name="startMonth"/>

									<input type="hidden" value="${endYear}" name="endYear"/>
									<input type="hidden" value="${endMonth}" name="endMonth"/>
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
			<!-- end: Content -->
			<%@ include file="/common/footer.jsp"%>
		</div>
		<!--/.fluid-container-->
	</div>
	<div class="modal hide fade in" id="confirmDel">
		<div class="modal-header">
			<button data-dismiss="modal" class="close" type="button">×</button>
			<h3>提示</h3>
		</div>
		<div class="modal-body">
			<p id="del-tip"></p>
		</div>
		<div class="modal-footer">
			<a data-dismiss="modal" class="btn" href="#">取消</a> <a
				class="btn btn-primary" href="#" id="btn-del-confirm">确定</a>
		</div>
	</div>

	<div class="modal hide fade in" id="detailModal">
		<div class="modal-header">
			<button data-dismiss="modal" class="close" type="button">×</button>
			<h3>查看学生</h3>
		</div>
		<form style="margin: 0" class="form-horizontal">
			<div class="modal-body">
			</div>
		</form>
	</div>

	<!-- 查看学生详细信息内部模板 -->
	<script id="detail-modal-temp" type="text/html">
			<fieldset>
									<div class="control-group">
										<label for="" class="control-label">学号</label>
										<div class="controls">
											<input disabled="disabled" value="<@=student.stuNo@>" name="stuNo" type="text" class="input-large"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">姓名</label>
										<div class="controls">
											<input disabled="disabled" value="<@=student.name@>" name="name" type="text" class="input-large">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">性别</label>
										<div class="controls">
											<select disabled="disabled" rel="uniform" class="input-mini">
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
											<input disabled="disabled" value="<@=moment(student.birthday).format('YYYY-MM-DD')@>" type="text" class="input-large">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">专业</label>
										<div class="controls">
											<select disabled="disabled" class="input-mini" rel="uniform">
												<!--这种数据字典下拉框基本不会变就从别的控件拷过来，不ajax请求了-->
												<@$('select[name="student.major.id"]').eq(0).find("option").each(function(i,e){@>
														<@==$.getJqueryOuterHtml($(e).removeAttr('selected').attr('selected',$(e).attr('value') == student.major.id))@>
												<@});@>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">导师</label>
										<div class="controls">
											<input disabled="disabled" value="<@=student.mentor@>" name="mentor" type="text" class="input-large">
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">年级</label>
										<div class="controls"><input disabled="disabled" value="<@=student.grade@>" name="grade" type="text" class="input-large"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">班级</label>
										<div class="controls"><input disabled="disabled" value="<@=(student.clazz<10)?"0"+(student.clazz):student.clazz@>" name="clazz" type="text" class="input-large"></div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">类别</label>
										<div class="controls">
											<select disabled="disabled" id="" class="input-mini" rel="uniform">
												<!--这种数据字典下拉框基本不会变就从别的控件拷过来，不ajax请求了-->
												<@$('select[name=type]').eq(0).find("option").each(function(i,e){@>
														<@==$.getJqueryOuterHtml($(e).removeAttr('selected').attr('selected',$(e).attr('value') == student.type))@>
												<@});@>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">照片</label>
										<div class="controls">
											  	<div class="fileupload-new thumbnail tip-thumbnail">
											  		<img src="<@=$.appCtx+student.avatar@>?x=<@=Math.random()@>" />
											 	</div>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">描述</label>
										<div class="controls">
											<textarea disabled="disabled" name="description" maxlength="200" type="text" class="input-xlarge"><@=student.description@></textarea>
										</div>
									</div>
			</fieldset>
	</script>

	<div class="hide">
	<select name="type">
		<c:forEach var="t" items="${stuTypeEnums}">
			<option value="${t}">${t.description}</option>
		</c:forEach>
	</select>
	<select name="gender">
		<c:forEach var="g" items="${genderEnums}">
			<option value="${g}">${g.description}</option>
		</c:forEach>
	</select>
	</div>



	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>
	<!-- end: JavaScript-->

	<script type="text/javascript">
		$(function(){
			var baseUrl = $.appCtx + '/intern-query';
			// return url的设置。编辑和删除时要停留在当前页
			$("input[name=returnUrl]").val(window.location.href);

			// 列表中多选时看情况dis/enable掉删除按钮
			$("#intern-table input[type=checkbox]").change(function() {
				$('#btn-del').attr('disabled', true);
				$("#intern-table tbody input[type=checkbox]").each(function() {
					if ($(this).attr('checked'))
						$('#btn-del').removeAttr('disabled');
				});
			});

			// 弹出批量删除确认框
			$('#btn-del').click(function(e) {
				e.preventDefault();
				$('#del-tip').html("确定删除该<em>"+ $("#intern-table tbody input[type=checkbox]:checked").length+ "</em>条考勤记录？");
				$('#confirmDel').modal();
				// 更新“确认”按钮的事件
				$('#btn-del-confirm').off('click').click(function() {
							$('#del-form').submit();
				});
			});

			// 单个删除确认框
			$('.btn-delete-one').click(function(e) {
				e.preventDefault();
				$('#del-tip').html("确定删除该条考勤记录吗？");
				$('#confirmDel').modal();
				self = $(this);
				// 更新“确认”按钮的事件
				$('#btn-del-confirm').off('click').click(function() {
					// 取消表格中所有复选框的选中状态，选中当前记录。最后提交删除表单。
					var cbs = $('#del-form input[type=checkbox]:checked')
					cbs.removeAttr('checked');
					$('#cb-'+ self.attr('intern-id')).attr('checked',true);
					$.uniform.update(cbs);
					$.uniform.update($('#cb-'+ self.attr('intern-id')));
					$('#del-form').submit();
				});
			});

			// 查看学生详细信息
			$('.stu-detail-link').click(function(){
				self = $(this);
				$.get($.appCtx+ "/data-manage/student/"+ self.attr('stu-id'),function(data) {
						if (data) {
							$('#detailModal .modal-body').empty().html(template.render('detail-modal-temp',{
								"student" : data,
								"$":$,
								"moment":moment,
								'Math':Math
							})).find('select[rel="uniform"],input:checkbox, input:radio, input:file')
								.not('[data-no-uniform="true"],#uniform-is-ajax')
								.uniform();// uniform化表单元素

							$('#detailModal').modal();
						}
				});
			});

			// 导出excel
			$("#export-excel").click(function(e){
				e.preventDefault();
				if($(this).attr('disabled'))
					return;
				var url = $.appCtx + "/intern-query/export-excel";
				var form = $("#queryform");
				form.attr("action",url).attr("target","_blank").submit().removeAttr("action").attr('target','_self');
			});

			$(".query-form").submit(function(){
				var canSubmit = true;
				$("select[name=startYear],select[name=endYear]").closest(".controls").each(function(i,e){
					var s = $(this).find('select');
					var y = s.eq(0).find("option:selected").val();
					var m = s.eq(1).find("option:selected").val();
					if((y && !m) || (!y && m)){
						noty({"text":"日期错误：年月必须同时选择或同时不选",type:"error",layout:"topCenter"});
						canSubmit = false;
						return false;
					}
				});
				if(!canSubmit)
					return false;

				var startYear = parseInt($("select[name=startYear] option:selected").val());
				var startMonth = parseInt($("select[name=startMonth] option:selected").val());
				var endYear = parseInt($("select[name=endYear] option:selected").val());
				var endMonth = parseInt($("select[name=endMonth] option:selected").val());

				var timeError = false;
				if(startYear > endYear ||
					(startYear == endYear && startMonth > endMonth)){
					timeError = true;
				}

				if(timeError){
					canSubmit = false;
					noty({"text":"起始时间不得晚于结束时间",type:"error",layout:"topCenter"});
				}
				return canSubmit;
			});
		});
	</script>
</body>
</html>
