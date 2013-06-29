<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageTitle" value="考勤录入" scope="page"></c:set>
<c:set var="weekEnums" value="<%=WeekEnum.values()%>"/>
<c:set var="printTypeEnums" value="<%=PrintTypeEnum.values()%>"/>
<c:set var="notPagedEnum" value="<%=PrintTypeEnum.NotPaged%>"/>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/common/head-inner.jsp"%>
	<style type="text/css">
		.intern-range{margin:0}
		#range-wrapper:last-child{margin-bottom:20px;}
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
			<div id="content" class="span11">

				<div class="widget">
					<h2><span class="glyphicons chevron-right"><i></i></span>选择学生</h2>
					<hr>
					<div class="content">
						<!-- start: query form -->
							<form action="${ctx}/barcode-print" class="form-horizontal query-form float-form" id="query-form">
								<input type="hidden" name="printType" value="${printType}"/>
								<input type="hidden" name="ranges" value="${ranges}"/>
								<input type="hidden" name="checkQueryAll"/>
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
										<div class="check-all-page">
											<label class="checkbox inline">
												<input type="checkbox" id="check-query-all" rel="uniform"} value="true">
												勾选所有符合查询条件的&nbsp;<b>${page.totalCount}</b>&nbsp;个学生
								  			</label>
										</div>
									<form id="del-form">
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
															<a href="#">${student.name}</a>
														</td>
														<td>${student.type.description}</td>
														<td>${student.major.name}</td>
														<td>${student.grade}</td>
														<td>${student.clazz>10?"":"0"}${student.clazz}</td>
														<td>${student.gender.description}</td>
														<td>${student.mentor}</td>
														<td><fmt:formatDate value="${student.birthday}" type="date" pattern="yyyy-MM-dd"/></td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</form>
									<!-- start: 分页 -->
									<div class="pagination pagination-centered">
										<form id="queryform" target="_self" style="display: none;" action="${ctx}/barcode-print">
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

											<!-- 翻页时保留实习区间和打印方式 -->
											<input type="hidden" name="printType" value="${printType}"/>
											<input type="hidden" name="ranges" value="${ranges}"/>

											<!-- 打印时提交的额外信息 -->
											<input type="hidden" name="checkQueryAll"/>
											<input type="hidden" name="stuIds"/>
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




					<div class="widget">
						<h2><span class="glyphicons chevron-right"><i></i></span>选择实习区间
							<button class="btn btn-small" style="margin-left:10px;font-size:14px" onclick="javascript:addRange();"><i class="fa-icon-plus"></i></button></h2>
						<hr>
						<div class="content" id="range-wrapper">
							<!-- start: 选择实习区间表单 -->
							<c:forEach var="range" items="${rangesList}">
							<form action="" class="form-horizontal float-form intern-range">
								<fieldset>
									<div class="control-group">
										<label for="" class="control-label">年</label>
										<div class="controls">
											<select name="year" id="" class="input-mini" rel="uniform">
												<c:forEach var="item" varStatus="status" begin="2013" end="2023">
													<option ${range.year==status.index?"selected='selected'":""} value="${status.index}">${status.index}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group">
										<label for="" class="control-label">月</label>
										<div class="controls">
											<select name="month" id="" class="input-mini" rel="uniform">
												<option ${range.month==0?"selected='selected'":""} value="0">全部</option>
												<c:forEach var="item" varStatus="status" begin="1" end="12">
													<option ${range.month==status.index?"selected='selected'":""} value="${status.index}">${status.index}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group week" ${range.month==0 || range.splitByWeek eq null?"style='display:none'":""}>
										<label for="" class="control-label">周</label>
										<div class="controls">
											<select name="week" id="" class="input-mini" rel="uniform">
												<c:forEach var="w" items="${weekEnums}">
													<option ${range.week==w?"selected='selected'":""} value="${w}">${w.description}</option>
												</c:forEach>
											</select>
										</div>
									</div>

									<div class="control-group split-by-week" ${range.month==0?"style='display:none'":""} >
										<div class="controls" style="margin-left:0;">
											<label class="checkbox inline" data-toggle="tooltip" data-original-title="勾选后每周一个条码" data-placement="top">
												<input type="checkbox" name="splitByWeek" rel="uniform" ${range.splitByWeek?"checked='checked'":""} value="true">
												按周拆分
								  			</label>
										</div>
									</div>

									<div class="control-group" style="padding: 3px 0 0 13px;">
										<a class="btn btn-danger btn-mini btn-del-range"><i class="icon-trash icon-white"></i>删除</a>
									</div>
								</fieldset>
							</form>
							</c:forEach>
							<!--  end: 选择实习区间表单-->
						</div>
					</div>
					<div class="widget">
						<h2><span class="glyphicons chevron-right"><i></i></span>选择打印方式</h2>
						<hr>
						<form action="" class="form-horizontal float-form">
							<div class="control-group" >
								<label for="" class="control-label">打印方式</label>
								<div class="controls">
									<select onchange="$('#print-type-tip').toggle();" name="printType" id="" class="input-small" rel="uniform">
										<c:forEach var="w" items="${printTypeEnums}">
											<option value="${w}" ${w==printType?"selected='selected'":""}>${w.description}</option>
										</c:forEach>
									</select>
									<label id="print-type-tip" class="checkbox inline" style='cursor:default;color:#aaa;padding-top:2px;
									${printType == notPagedEnum?"display:none;":""}  '><i class="fa-icon-bell" style="font-size: 14px;margin-right:2px;"></i>
									保证一页纸上只打印一个学生的条码</label>
								</div>
							</div>
						</form>
					</div>

				<div class="clearfix"></div>
				<div class="form-actions center-form-action" >
					<button class="btn btn-success btn-large" onclick="javascript:print();">打印预览</button>
				  </div>
			</div>
			<!-- end: Content -->

		<%@ include file="/common/footer.jsp"%>
		</div>
	<!--/.fluid-container-->
	</div>
	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>
	<!-- end: JavaScript-->

	<script type="text/javascript">

	function addRange(){
		var lastArea = $('form.intern-range').last();
		var selectsInLastArea = lastArea.find('select');
		var cbInLastArea = lastArea.find("input[type=checkbox]");
		$.uniform.restore(selectsInLastArea);
		$.uniform.restore(cbInLastArea);
		var area = lastArea.clone().hide();
		selectsInLastArea.uniform();
		cbInLastArea.uniform();
		// 拷贝下拉框的值
		var selectsInArea = area.find('select');
		var cbInArea = area.find('input[type=checkbox]');
		selectsInArea.each(function(i){
			$(this).find('option[value="'+$(selectsInLastArea.get(i)).val()+'"]').attr('selected',true);
		});
		cbInArea.attr('checked',cbInLastArea.attr('checked'));
		area.appendTo($('#range-wrapper')).slideToggle(function(){
			selectsInArea.uniform();
			cbInArea.uniform();
			area.find('*[data-toggle=tooltip]').tooltip();
		});
	}

	function print(){
		var selectedNum = $("#student-table tbody input[type=checkbox]:checked").length;
		// 是否选择了所有学生
		var checkAll = $("#check-query-all").attr('checked')?true:false;
		var form = $("#queryform");
		form.find('input[name=checkQueryAll]').val(checkAll);
		if(selectedNum == 0 && !checkAll){
			noty({text:"未选择学生！",layout:"topCenter",type:"error",timeout:2000});
			return;
		}
		//	收集勾选学生的id
		form.find('input[name=stuIds]').val(JSON.stringify($("#del-form").serializeJson()["ids"]));
		// query在翻页或查询时已经赋值
		//打印方式和区间在submit事件触发时收集

		// 提交
		var action = form.attr('action');
		form.attr('action',$.appCtx + "/barcode-print/preview").attr("target","preview").submit();
		//还原分页form属性
		actiom.attr({'action':action,'target':'_self'});
	}

		$(function(){
			$('select[name=month]').live('change',function(){
				if($(this).find('option:selected').val() == 0){
					$(this).closest('form').find('.week,.split-by-week').hide();
					$(this).closest('form').find('input[type=checkbox]').attr('checked',false).uniform();
				}else{
					$(this).closest('form').find('.split-by-week').show()
				}
			});
			$('.split-by-week input[type=checkbox]').live('click',function(){
				$(this).closest('form').find('.week').toggle($(this).attr('checked')?true:false);
			});

			$('.btn-del-range').live('click',function(){
				if($('.intern-range').length==1)return;
				$(this).closest('form').slideToggle(function(){$(this).remove();});
			});

			$('#queryform,#query-form').on('submit',function(){
				// 收集打印方式
				$(this).find('input[name=printType]').val($('select[name=printType] option:selected').val());
				// 收集区间
				var ranges = [];
				$('.intern-range').each(function(i,e){
					ranges.push($(e).serializeJson());
				});
				$(this).find('input[name=ranges]').val(JSON.stringify(ranges));
			});
		});
	</script>
</body>
</html>
