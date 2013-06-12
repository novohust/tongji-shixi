<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="pageTitle" value="数据管理-专业" scope="page"></c:set>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/common/head-inner.jsp" %>
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
				<c:set var="dataManCurPage" value="major" scope="page"></c:set>
				<%@ include file="/common/data-man-nav.jsp" %>

				<!--  start: 所有专业 -->
				<div class="row-fluid">
					<div class="box span12">
						<div class="box-header">
							<h2><i class="halflings-icon search"></i><span class="break"></span>所有专业</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content">
						<c:choose>
							<c:when test="${allMajor==null||fn:length(allMajor)==0}">
								<div class="alert alert-info">暂无专业</div>
							</c:when>
							<c:otherwise>
							  <form id="del-form" action="${ctx}/data-manage/major/del" method="post">
								<table class="table table-bordered table-striped" id="major-table">
									  <thead>
										  <tr>
										  	<th style="width:10px" class="center"><input type="checkbox" rel="uniform" class="check-all"></th>
										  	<th>名称</th>
											<th>操作</th>
										  </tr>
									  </thead>
									  <tbody>
				                  		<c:forEach var="major" items="${allMajor}" varStatus="trackStatus">
											<tr>
												<td class="center"><input id="cb-${major.id}" type="checkbox" name="ids" value="${major.id}" rel="uniform"></td>
												<td >${major.name}</td>
												<td>
													<a class="btn btn-primary btn-mini btn-edit" major-id="${major.id}"><i class="icon-edit icon-white"></i>编辑</a>
													<a class="btn btn-danger btn-mini btn-delete-one" major-id="${major.id}" major-name="${major.name}"><i class="icon-trash icon-white"></i>删除</a>
												</td>
											</tr>
				                  		</c:forEach>
									  </tbody>
							 	</table>
					 			<button class="btn btn-primary" id="btn-del" disabled="disabled">删除</button>
							 	</form>
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
							<h2><i class="halflings-icon plus-sign"></i><span class="break"></span>新增</h2>
							<div class="box-icon">
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-up"></i></a>
							</div>
						</div>

						<div class="box-content" >
							<form id="add-form" class="form-horizontal" action="${ctx}/data-manage/major/add" method="post">
								<fieldset>
								  <div class="control-group">
										<label for="" class="control-label">名称</label>
										<div class="controls"><input name="name" type="text" class="input-large
										validate[required,ajax[isNameUsed]]
										" maxlength="20" placeholder="请输入专业名称" id="nameAdd"></div>
									</div>

								  <div class="form-actions">
									<button type="submit" class="btn btn-primary" >确定</button>
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

			<%@ include file="/common/footer.jsp" %>

		</div>
	</div>


	<div class="modal hide fade in" id="confirmDel">
            <div class="modal-header">
              <button data-dismiss="modal" class="close" type="button">×</button>
              <h3>提示</h3>
            </div>
            <div class="modal-body">
            	<p id="del-tip"></p>
				<p class="alert"><strong>警告!</strong>&nbsp;&nbsp;删除专业将同时该专业下的所有学生及其考勤记录！</p>
            </div>
            <div class="modal-footer">
              <a data-dismiss="modal" class="btn" href="#">取消</a>
              <a class="btn btn-primary" href="#" id="btn-del-confirm">确定</a>
            </div>
          </div>

	<div class="modal hide fade in" id="editModal">
			<div class="modal-header">
              <button data-dismiss="modal" class="close" type="button">×</button>
              <h3>编辑</h3>
            </div>
			<form action="${ctx}/data-manage/major/update" method="post" class="form-horizontal" style="margin:0">
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
			  <div class="control-group" style="margin:0">
					<label for="" class="control-label">名称</label>
					<div class="controls">
						<input name="name" type="text" id="nameEdit" class="input-large
										validate[required,ajax[isNameUsedWhenEdit]]
										" maxlength="20" placeholder="请输入专业名称" value="<@=major.name@>">
						<input type="hidden" value="<@=major.id@>" name="id" id="idEdit"/>
				</div>
			</fieldset>
	</script>

	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp" %>

	<script type = "text/javascript">
	$(function(){
		var baseUrl = $.appCtx + '/data-manage/major';
		// validationengine新增专业时的rule扩展
		$.extend($.validationEngineLanguage.allRules,{
			"isNameUsed":{
				// remote json service location
				"url":baseUrl + "/add/nameCanUse",
				// error
				"alertText":"该专业已存在",
				"alertTextOk":"该名称可以使用",
				// speaks by itself
				"alertTextLoad":"<img src='${ctx}/static/img/validating.gif'/>"
			}
		});

		// 新增表单校验
		$("#add-form").validationEngine('attach',{
			ajaxFormValidation: true,
			ajaxFormValidationURL:baseUrl + "/add/validate",
			onAjaxFormComplete:function(status, form, json, options){
				if (status === true) {
					 form.validationEngine('detach');
					 form.submit();
				}
			}
		});

		// 列表中多选时看情况dis/enable掉删除按钮
		$("#major-table input[type=checkbox]").change(function(){
			$('#btn-del').attr('disabled',true);
			$("#major-table input[type=checkbox]").each(function(){
				if($(this).attr('checked'))
					$('#btn-del').removeAttr('disabled');
			});
		});

		// 弹出批量删除确认框
		$('#btn-del').click(function(e){
			e.preventDefault();
			$('#del-tip').html("确定删除该<em>"+$("#major-table tbody input[type=checkbox]:checked").length+"</em>条记录？");
			$('#confirmDel').modal();
			// 更新“确认”按钮的事件
			$('#btn-del-confirm').off('click').click(function(){
				$('#del-form').submit();
			});
		});

		// 单个删除确认框
		$('.btn-delete-one').click(function(e){
			e.preventDefault();
			$('#del-tip').html("确定删除记录 <em>"+$(this).attr('major-name')+"</em> 吗？");
			$('#confirmDel').modal();
			self=$(this);
			// 更新“确认”按钮的事件
			$('#btn-del-confirm').off('click').click(function(){
				// 取消表格中所有复选框的选中状态，选中当前记录。最后提交删除表单。
				var cbs = $('#del-form input[type=checkbox]:checked')
				cbs.removeAttr('checked');
				$('#cb-'+self.attr('major-id')).attr('checked',true);
				$.uniform.update(cbs);
				$.uniform.update($('#cb-'+self.attr('major-id')));
				$('#del-form').submit();
			});
		});

		// 弹出编辑框
		$('.btn-edit').click(function(e){
			$.get($.appCtx + "/data-manage/major/"+$(this).attr('major-id'),function(data){
				if(data){
					$('#editModal .modal-body').html(template.render('edit-modal-temp',{"major":data}))
					.find('select[rel="uniform"],input:checkbox, input:radio, input:file')
					.not('[data-no-uniform="true"],#uniform-is-ajax').uniform();// uniform化表单元素

					// 编辑时name的ajax验证
					$.extend($.validationEngineLanguage.allRules,{
						"isNameUsedWhenEdit":{
							// remote json service location
							"url":baseUrl + "/update/nameCanUse",
							"extraDataDynamic":['#idEdit'],
							// error
							"alertText":"该专业已存在",
							"alertTextOk":"该名称可以使用",
							// speaks by itself
							"alertTextLoad":"<img src='${ctx}/static/img/validating.gif'/>"
						}
					});

					// 编辑表单的验证
					$('#editModal form').validationEngine('attach',{
						ajaxFormValidation: true,
						ajaxFormValidationURL:baseUrl + "/update/validate",
						onAjaxFormComplete:function(status, form, json, options){
							if (status === true) {
								 form.validationEngine('detach');
								 form.submit();
							}
						}
					});

					$('#editModal').modal();
				}
			});
		});
	});
	</script>
	<!-- end: JavaScript-->
</body>
</html>
