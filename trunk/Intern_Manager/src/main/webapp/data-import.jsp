<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<c:set var="pageTitle" value="数据导入" scope="page"></c:set>
<c:set var="importTypes" value="<%=ImportTypeEnum.values()%>"/>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
	<%@ include file="/common/head-inner.jsp" %>

	<style type="text/css">
	#pct-num{
	font-family: Georgia;
	font-size: 17px;
	line-height: 15px;
	font-weight: bold;
	float: left;
	margin-left: 14px;
	}
	#upload-form{
	width:50%;float:left;
	}
	#alert-area{
		margin-left:50px;
		float:left;
		width:315px;
	}
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
			<div id="content" class="span11">
				<form id="upload-form" action="/data-import/import" class="form-horizontal">
					<fieldset>
						<div class="control-group">
							<label for="" class="control-label">选择文件</label>
							<div class="controls">
								<input type="file" id="file_upload" data-no-uniform="true">
							</div>
						</div>

						<div class="control-group">
							<label for="" class="control-label">数据类型</label>
							<div class="controls">
								<select name="type" id="" class="input-mini" rel="uniform">
									<c:forEach var="t" items="${importTypes}">
										<option value="${t}">${t.description}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="control-group" id="import-progress" style="display:none">
							<label for="" class="control-label">导入进度</label>
							<div class="controls" style="padding-top: 7px;">
								<div class="progress progress-striped active pull-left" style="height:17px;width: 300px;">
							        <div class="bar" id="bar" style="width: 0"></div>
							    </div>
							    <div style="" id="pct-num"></div>
							</div>
						</div>

						<div class="form-actions center-form-action"  style="text-align:left;">
							<input class="btn btn-primary" type="submit" value="确定">
						  </div>
					</fieldset>
				</form>
				<div id="alert-area" class="alert alert-error" style="display:none">
					<strong>错误信息</strong><br>
				</div>
			</div>
			<!-- end: Content -->
			<%@ include file="/common/footer.jsp"%>
		</div>
		<!--/.fluid-container-->
	</div>
	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp" %>
	<script type="text/javascript">
	$(function(){
		var it;
		function initUploadify(){
			$("#file_upload").uploadify({
				'auto':false,
				'multi':false,
				'queueSizeLimit':1,
				'removeTimeout':3600*24*7,
				'fileSizeLimit':'5MB',
				'fileObjName':'excel',
				'fileTypeExts':'*.xls; *.xlsx',
				'fileTypeDesc':'Excel文件',
				'buttonText':'选择文件 ...',
				'width':90,
				'height':30,
				'swf'      : $.appCtx + '/static/swf/uploadify.swf',
				'uploader' : $('#upload-form').attr('action'),
				'onSelect' : function(file) {
					//$(this.button[0]).text(file.name);
		        },
				'onQueueComplete':function(file,data,response){
					console.log(data);
					console.log(response);
					$('#import-progress').slideToggle();
					polling();
					it = setInterval(polling,1000);
				},
				'onUploadProgress':function(file,bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal){
				},
				'onUploadStart':function(file){
					$('#bar').css({'width':'0%'});
					$('.uploadify-queue .cancel').hide();
					$('#alert-area').html('<strong>错误信息</strong><br>').hide();
					// dynamic form data
					$("#file_upload").uploadify("settings", 'formData', $('#upload-form').serializeJson());

					$('#file_upload').uploadify('disable', true);
					$('#upload-form input[type=submit]').attr('disabled',true).text('导入中...');
					$('#upload-form select').attr('disabled',true);
					$.uniform.update();
				}
				// Put your options here
			});
		}

		initUploadify();

		$('#upload-form').submit(function(){
			$("#file_upload").uploadify('upload','*');
			return false;
		});

		//
		function polling(){
			$.get($.appCtx+"/data-import/query-process?"+Math.random(),function(data){
				console.log(data);
				var p = Math.round((data.importedCount/data.totalCount) * 100);
				$('#pct-num').text(p+'%');
				$('#bar').css({'width':p+'%'});
				if(data.importedCount == data.totalCount){
					noty({"text":"导入完成",type:"success",layout:"topCenter"});
					clearInterval(it);
					setTimeout(function(){
						$('#import-progress').slideToggle();
						$('#file_upload').uploadify('destroy');
						initUploadify();
					},1000);
					//
					$('#upload-form input[type=submit]').attr('disabled',false).text('确定');
					$('#upload-form select').attr('disabled',false);
					$.uniform.update();
				}
				if(data.errors.length > 0){
					$(data.errors).each(function(i,o){
						$('#alert-area').html($('#alert-area').html()+o+"<br/>").show();
					});
				}
			});
		}


	});
	</script>
	<!-- end: JavaScript-->
</body>
</html>