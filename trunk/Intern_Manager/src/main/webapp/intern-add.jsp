<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageTitle" value="考勤录入" scope="page"></c:set>
<c:set var="weekEnums" value="<%=WeekEnum.values()%>"/>
<!DOCTYPE html>
<html lang="en">
<head>
	<%@ include file="/common/head-inner.jsp"%>
	<style type="text/css">
		.intern-add-wrapper .box{
			margin:10px 0;
		}
		.intern-add-wrapper .record-num{
			float:left;
			margin-right:10px;
			margin-top:-2px;
		}
		.teacher-select-wrapper{
		}
		.teacher-select-wrapper *{
			float:left;
		}
		.teacher-select-wrapper label{
			margin: 0 4px 0 0;
		}
		.teacher-select-wrapper .selector{margin-top: -4px;margin-right:10px;}
		.teacher-select-wrapper select{
			width:90px;
		}

		.selected .box{
			box-shadow: 0 0 10px rgba(0, 61, 255,0.4);
		}

		.selected .teacher-select-wrapper label,.selected .teacher-select-wrapper span,.selected .teacher-select-wrapper select{
			font-weight: bold;
			color:black;
		}
		.intern-table{
			margin-bottom: 0;
		}
		.intern-table i{
			font-size:14px;
		}
		.input-record-wrapper{
		padding: 15px 0 0;margin: -10px auto 7px;width: 500px;
        overflow: hidden;
		}
		.input-record-wrapper .control-group{
			margin-bottom: 13px;
		}
		.input-record-wrapper  form{
			margin:0 0 29px
		}
		.input-record-wrapper .form-actions{
			margin:10px -10px -30px -10px;
			padding:0px 20px 10px 170px;
			border-top:none;
			background: transparent;
		}
		.box-title-err{float:left;}
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
			<div id="content" class="span11" style="border-top-left-radius:0;">
				<!--  start: 考勤录入教师区块 -->
				<div class="row-fluid intern-add-wrapper animated selected">
					<div class="box span12">
						<div class="box-header">
							<span class="label label-important record-num">0</span>
							<div class="teacher-select-wrapper">
								<form>
								<label >科室</label>
								<select rel="uniform" name="" class="select-dept required">
									<c:forEach var="dept" items="${allDept}">
										<option value="${dept.id}">${dept.name}</option>
									</c:forEach>
								</select>

								<label >病区</label>
								<select name="" rel="uniform" class="select-area required">
								</select>

								<label >教授组</label>
								<select name="" rel="uniform" class="select-team required">
								</select>

								<label >老师</label>
								<select name=""  rel="uniform" class="select-teacher required">
								</select>

								</form>
							</div>
							<span class="box-title-err label label-important"></span>

							<div class="box-icon">
								<div data-toggle="buttons-radio" class="btn-group">
							                    <button class="btn  btn-primary btn-mini  btn-barcode active">条码扫描</button>
							                    <button class="btn  btn-primary btn-mini btn-input">手动添加</button>
							             </div>
								<a href="" class="btn-minimize"><i class="halflings-icon  chevron-down"></i></a>
								<a href="" class="btn-close"  style="display:none;"><i class="halflings-icon remove"></i></a>
							</div>
						</div>

						<div class="box-content" style="display:none">
							<div class="input-record-wrapper hide">
								<form action="" class="form-horizontal">
									<fieldset>
										<div class="control-group">
											<label for="" class="control-label">学号</label>
											<div class="controls"><input type="text" name="stuNo" class="input-large input-stuNo" placeholder="请输入学生学号"><span class="help-inline" style="color:#b94a48;display:none"></span></div>
										</div>
										<div class="control-group">
											<label for="" class="control-label">实习月份</label>
											<div class="controls">
												<select name="year" id="" class="input-mini" rel="uniform">
													<c:forEach var="item" varStatus="status" begin="2013" end="2050">
													<option value="${status.index}">${status.index}</option>
													</c:forEach>
												</select>
												<select name="month" id="" class="input-mini" rel="uniform">
													<c:forEach var="item" varStatus="status" begin="1" end="12">
													<option value="${status.index}">${status.index}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="control-group">
											<label for="" class="control-label">实习区间</label>
											<div class="controls">
												<select name="weekIndex" id="" class="input-small" rel="uniform">
													<c:forEach var="w" items="${weekEnums}">
													<option  value="${w.value}">${w.description}</option>
													</c:forEach>
												</select>
											</div>
										</div>
										<div class="form-actions" >
											<a href="#" class="btn btn-primary input-barcode-submit" >确定</a>
											<a href="#" class="btn switch-to-barcode" >取消</a>
										  </div>
									</fieldset>
								</form>
							</div>
							<!--start: 考勤记录列表 -->
							<table class="table intern-table" style="display:none">
								  <thead>
									  <tr>
										  <th>姓名</th>
										  <th>学号</th>
										  <th>实习月份</th>
										  <th>实习时间</th>
										  <th>操作</th>
									  </tr>
								  </thead>
								  <tbody>
								  </tbody>
						 	</table>
							<!--end: 考勤记录列表 -->
						</div>
					</div>
				</div>
				<!--  end 考勤录入教师区块 -->

				<!--start: form actions-->
				<div class="form-actions center-form-action" >
					<form id="add-form" method="post" target="_self" action="/intern-add/add">
					<input type="hidden" name="internsAdd" id="internsAdd"/>
					<input type="hidden" name="internsDel" id="internsDel"/>

					<a href="#" class="btn btn-large" id="add-area">增加区块</a>
					<input class="btn btn-success btn-large" type="submit"" value="全部提交"/>
					</form>
				  </div>
				  <!--end: form actions-->
			</div>
			<!-- end: Content -->

		<div class="alert alert-error no-record-error hide">
			<button data-dismiss="alert" class="close" type="button">×</button>
			尚未添加考勤记录！
		</div>

		<div class="modal hide fade" id="myModal">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">x</button>
				<h3>警告</h3>
			</div>
			<div class="modal-body">
				<!-- 被模板填充 -->
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">取消</a>
				<a href="#" id="proceed-anyway" class="btn btn-primary">继续</a>
			</div>
		</div>

		<%@ include file="/common/footer.jsp"%>
	</div>
	<!--/.fluid-container-->

	<script id="tr-template" type="text/html">
		<tr class="animated fadeIn intern-tr">
			<td><@=data.student.name@></td>
			<td><@=data.student.stuNo@></td>
			<td><@=data.year@>-<@=data.month@></td>
			<td><@=data.week.desc@></td>
			<td>
				<a href="#"><i class="fa-icon-remove remove-tr"></i></a>
				<form class="hide intern-record">
					<input type="hidden" name="student.id" value="<@=data.student.id@>"/>
					<input type="hidden" name="teacher.id"/>
					<input type="hidden" name="teacherTeam.id"/>
					<input type="hidden" name="year" value="<@=data.year@>"/>
					<input type="hidden" name="month" value="<@=data.month@>"/>
					<input type="hidden" name="weekType" value="<@=data.week.enum@>"/>
				</form>
			</td>
		</tr>
	</script>

	<script id="conflicted-modal-body-tmp" type="text/html">
				<p>当前考勤记录：</p>
				<table class="table table-bordered table-striped">
					  <thead>
						  <tr>
							  <th>姓名</th>
							  <th>学号</th>
							  <th>实习月份</th>
							  <th>实习时间</th>
						  </tr>
					  </thead>
					  <tbody>
						<tr>
							<td><@=cur.student.name@></td>
							<td class="center"><@=cur.student.stuNo@></td>
							<td class="center"><@=cur.year@>-<@=cur.month@></td>
							<td class="center"><@=cur.week.desc@></td>
						</tr>
					  </tbody>
			 	</table>
			 	<p></p>
			 	<p>与下列已入库的记录冲突，<b>继续将删除下列记录</b>，是否继续？</p>
				<table class="table table-bordered table-striped">
					  <thead>
						  <tr>
							  <th>姓名</th>
							  <th>学号</th>
							  <th>实习月份</th>
							  <th>实习时间</th>
							  <th>带教老师</th>
							  <th>教授组</th>
							  <th>病区</th>
							  <th>科室</th>
						  </tr>
					  </thead>
					  <tbody>
						<@ $(conflicted).each(function(i,e){ @>
							<tr>
								<td><@=cur.student.name@></td>
								<td><@=cur.student.stuNo@></td>
								<td><@=e.year@>-<@=e.month@></td>
								<td><@=weekDescs[e.weekType]@></td>
								<td><@=e.teacher.name@></td>
								<td><@=e.teacherTeam.name@></td>
								<td><@=e.teacherTeam.area.name@></td>
								<td><@=e.teacherTeam.area.department.name@></td>
							</tr>
						<@ }); @>
					  </tbody>
			 	</table>
	</script>

	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>
	<!-- end: JavaScript-->

	<script type="text/javascript">
		var weekEnums = [
           {"enum":"All","desc":"整月"},
           {"enum":"First","desc":"第1周"},
           {"enum":"Second","desc":"第2周"},
           {"enum":"Third","desc":"第3周"},
           {"enum":"Fourth","desc":"第4周"}
		];

		var weekDescs = {
				"All":"整月",
				"First":"第1周",
				"Second":"第2周",
				"Third":"第3周",
				"Fourth":"第4周"
		};

		$(function(){
			// 条码中的week是WeekEnum的value

			// 扫描条码添加实习记录
			var intern = [];
			$('body').on('keydown',function(e){
				var key = e.which;
				if(key == 13){
					if($('div.selected').length == 0){
						warn("请先选择区块再扫描条码");
						return;
					}
					// 如果当前选择的方式是手动输入，返回，不做响应
					if($('div.selected .btn-input').is('.active')){
						return;
					}
					// 解析条码，格式为"id year month week"
					console.log(intern);
					var a = intern.join("").split(",");
					if(a.length<4){
						intern = [];
						return;
					}
					var stuId = a[0];
					var year = a[1];
					var month = a[2];
					var weekIndex = a[3];

					// 和当前扫描的其他记录判定
					if(valConflictWithInputted(stuId,year,month,weekIndex)){
						//清空数组
						intern = [];
						return false;
					}

					//查询学生信息
					$.get($.appCtx+ "/data-manage/student/"+ stuId,function(data) {
						if (data) {
							valConflictWithServer(data,year,month,weekIndex);
						}else{
							warn("该学生不存在");
						}
					});

					//清空数组
					intern = [];
				}else{
					if(key == 188)
						intern.push(",");
					else if(48<=key && key <= 57)	//数字
						intern.push(String(key-48));
				}
			});

			// 和当前已输入的其他记录做冲突验证，返回是否冲突 true|false
			function valConflictWithInputted(stuId,year,month,weekIndex){
				$('.intern-table tr.alert').removeClass("alert");
				var conflicted = false;
				$(".intern-tr").each(function(i,e){
					var tr = $(this);
					var intern = tr.data("intern");
					if(intern.student.id == stuId && intern.year == year && intern.month == month &&	// 同一个人同一年同一月
							(weekEnums[weekIndex]["enum"] == intern.week["enum"] ||	// 同一周
							weekEnums[weekIndex]["enum"] == "All" ||	// 或者 任意一条实习记录的范围是“整月”
							intern.week["enum"] == "All")
						){
						conflicted = true;
						showConflictedRecord(tr);
					}
				});
				if(conflicted){
					warn("新增实习记录失败，与其他记录冲突");
				}
				return conflicted;
			}

			// 和后台记录做冲突验证，如果不冲突，添加一条记录；如果冲突，弹出对话框提示
			function valConflictWithServer(student,year,month,weekIndex){
				$.get($.appCtx+ "/intern-add/find-by-month/",{
					"stuId":student.id,
					"year":year,
					"month":month
				},function(array) {
					// 得到冲突的所有记录
					var conflictedArray = [];
					if(array){
						$(array).each(function(i,e){
							if(e.weekType == weekEnums[weekIndex]["enum"] || weekEnums[weekIndex]["enum"] == "All" || e.weekType == "All"){
								conflictedArray.push(e);
							}
						});
					}
					// 弹框提示
					if(conflictedArray.length > 0){
						var rowData = {"student":student,"year":year,"month":month,"week":weekEnums[weekIndex],"conflicted":conflictedArray};
						$('#myModal .modal-body').html(template.render("conflicted-modal-body-tmp",{
							'cur':rowData,
							'conflicted':conflictedArray,
							'weekDescs':weekDescs,
							'$':$
						}));
						// 将待添加的实习记录和冲突的实习记录保存到确认框的“确定”按钮。
						$("#proceed-anyway").data({
							'rowData':rowData,
							'conflicted':conflictedArray
						});
						$("#myModal").modal('show');
					}else{
						addRow({
							"student":student,
							"year":year,
							"month":month,
							"week":weekEnums[weekIndex]
						});
					}
				});
			}

			// 即使和后台记录冲突，仍然继续
			$("#proceed-anyway").click(function(e){
				addRow($(this).data('rowData'));
				$('#myModal').modal('hide');
			});

			function showConflictedRecord(tr){
				tr.addClass('alert');
				var btn = tr.closest('.intern-add-wrapper').find('.box-header .btn-minimize');
				btn.find('i').is('.chevron-down')?btn.click():null;
			}
			function warn(text){
				noty({"text":text,type:"warning",layout:"topCenter"});
			}

			function openBox(box){
				var btn = box.find('.box-header .btn-minimize');
				btn.find('i').is('.chevron-down')?btn.click():null;
			}
			function setBoxLabel(label,num){
				label.html(num);
				num==0?label.removeClass('label-success').addClass('label-important'):
					label.addClass('label-success').removeClass('label-important');
			}
			function boxLabelInc(box){
				var label = box.find('.box-header .record-num');
				setBoxLabel(label,parseInt(label.html())+1);
			}
			function boxLabelDec(box){
				var label = box.find('.box-header .record-num');
				setBoxLabel(label,parseInt(label.html())-1);
			}
			function setTitleErr(box,text){
				box.find('.box-title-err').text(text).show();
			}
			function hideTitleErr(box){
				box.find('.box-title-err').hide();
			}
			function shakeBox(box){
				if(box.not('shake')){
					box.addClass('shake');
					setTimeout($.proxy(function(){this.removeClass('shake')},box),1000);
				}
			}
			function shakeErrorBoxes(){
				$('.box-title-err:visible').each(function(i,e){
					shakeBox($(e).closest('.intern-add-wrapper'));
				});
			}
			// 增加一条记录，添加一个tr
			function addRow(data){
				console.log(data);
				var box = $("div.selected");
				var tr = $(template.render('tr-template',{"data" : data})).data("intern",data);
				var table = box.find(".intern-table").show();
				openBox(box);
				tr.appendTo(table);
				boxLabelInc(box);
			}

			// 手动输入的提交
			$('.input-barcode-submit').live('click',function(e){
				e.preventDefault();
				var form = $(this).closest('form');
				var stuNo = form.find('input[name=stuNo]');
				var errTip = stuNo.next().hide();
				var internSubmitted = form.serializeJson();
				// 学号不能为空
				if(!stuNo.val()){
					errTip.text('学号不能为空').show();
					return;
				}
				// 学号必须存在
				$.get($.appCtx + "/data-manage/student/stuNo/"+stuNo.val(),function(data){
					if(!data){
						errTip.text('学号不存在').show();
						return;
					}
					// 和已扫描的记录的冲突判定
					if(valConflictWithInputted(data.id,internSubmitted.year,internSubmitted.month,internSubmitted.weekIndex)){
						return;
					}
					// 和后台的记录的冲突判定
					valConflictWithServer(data,internSubmitted.year,internSubmitted.month,internSubmitted.weekIndex);
				});

			});

			// 总表单的提交
			$('#add-form').submit(function(e){
				// 必须选择老师
				$('.intern-add-wrapper').each(function(i,box){
					if(!$(box).find('.select-teacher option:selected').val()){
						setTitleErr($(box),'请选择老师');
					}else{
						$(box).find('.box-title-err').hide();
					}
				});
				shakeErrorBoxes();
				if($('.box-title-err:visible').length > 0) return false;

				// 老师不能重复
				var teachers = {};
				$('.intern-add-wrapper').each(function(i,box){
					var teacherId = $(box).find('.select-teacher option:selected').val();
					if(teachers[teacherId]){
						setTitleErr($(box),'不能重复选择老师');
					}else{
						teachers[teacherId] = true;
						$(box).find('.box-title-err').hide();
					}
				});
				shakeErrorBoxes();
				if($('.box-title-err:visible').length > 0) return false;

				// 表格不能为空
				$(".intern-add-wrapper").each(function(i,box){
					if($(box).find('.record-num').html() == 0){
						setTitleErr($(box),'未录入考勤记录');
					}else{
						$(box).find('.box-title-err').hide();
					}
				});
				shakeErrorBoxes();
				if($('.box-title-err:visible').length > 0) return false;


				// 收集要提交的数据并设置form中对应input的值
				var interns = [];
				var conflicted = {};
				$(".intern-record").each(function(i,e){
					// 收集所有待添加的记录
					$(e).find('input[name="teacher.id"]').val($(e).closest('.intern-add-wrapper').find('.select-teacher option:selected').val());
					$(e).find('input[name="teacherTeam.id"]').val($(e).closest('.intern-add-wrapper').find('.select-team option:selected').val());
					var obj = $(e).serializeJson();
					obj["student"] = {"id":obj["student.id"]};
					delete obj["student.id"];
					obj["teacherTeam"] = {"id":obj["teacherTeam.id"]};
					delete obj["teacherTeam.id"];
					obj["teacher"] = {"id":obj["teacher.id"]};
					delete obj["teacher.id"];
					interns.push(obj);
					// 收集所有待删除的记录id
					var tr = $(e).closest('tr');
					$(tr.data('intern')['conflicted']).each(function(i,e){
						conflicted[String(e.id)] = true;
					});
				});
				$('#internsAdd').val(JSON.stringify(interns));
				var allConflictedIds = [];
				$.each(conflicted,function(k,v){
					allConflictedIds.push(k);
				});
				$('#internsDel').val(JSON.stringify(allConflictedIds));
			});

			// 选中某个区块
			$('.intern-add-wrapper').live('click',function(e){
				$('.selected').removeClass('selected');
				$(this).addClass('selected');
			});

			//添加区块
			$('#add-area').click(function(){
				if($(this).attr('disabled'))
					return;
				$(this).attr('disabled',true);
				var lastArea = $('.intern-add-wrapper').last();
				var selectsInLastArea = lastArea.find('select');
				$.uniform.restore(selectsInLastArea);
				var area = lastArea.clone().hide().removeClass('selected');
				// header里元素的重置
				area.find('.box-header').find('.record-num').removeClass('label-success').addClass('label-important').html(0);
				area.find('.box-header').find('.btn-barcode').addClass('active');
				area.find('.box-header').find('.btn-input').removeClass('active');
				area.find('.box-header').find('.btn-minimize i').removeClass('chevron-up').addClass('chevron-down');
				area.find('.box-header').find('.box-title-err').hide();
				// content的元素重置
				area.find('.box-content,.intern-table,.input-record-wrapper').hide();
				area.find('.box-content .intern-table tbody tr').remove();
				// 拷贝下拉框的值
				var selectsInArea = area.find('select');
				selectsInArea.each(function(i){
					$(this).find('option[value="'+$(selectsInLastArea.get(i)).val()+'"]').attr('selected',true);
				});
				area.insertBefore($('.center-form-action')).slideToggle(function(){
					selectsInArea.uniform();
					$('#add-area').removeAttr('disabled');
				});
				selectsInLastArea.uniform();
				$('.box-header .btn-close').fadeIn();
			});

			//考勤记录表格记录的删除
			$(".intern-table i.remove-tr").live('click',function(e){
				$(e.target).closest('.intern-add-wrapper').trigger('click');
				// 删除最后一行时隐藏表单，如果手动添加的表单也是隐藏的，则收缩box
				if($(e.target).closest('tbody').find('tr').length==1){
					$(e.target).closest('table').hide();
					$(e.target).closest('.intern-add-wrapper').find('.box-header .record-num').html(0).removeClass('label-success').addClass('label-important');
					if(!$(e.target).closest('.box-content').find('.input-record-wrapper').is(':visible'))
						$(e.target).closest('.intern-add-wrapper').find('.box-header .btn-minimize').click();
					$(e.target).closest('tr').remove();
				}else{
					var ele = $(e.target).closest('.intern-add-wrapper').find('.box-header .record-num');
					ele.html(ele.html() - 1);
					$(e.target).closest('tr').remove();
				}
			});

			// 输入方式切换
			$('.box-icon .btn-group .btn-barcode').live('click',function(e){
				var wrapper = $(e.target).closest('.intern-add-wrapper');
				// 切换到条码扫描时，如果考勤记录表为空且box是展开状态则全部收起
				if(!wrapper.find('.intern-table').is(':visible') && wrapper.find('.box-header .btn-minimize i').is('.chevron-up'))
					wrapper.find('.box-header .btn-minimize').click();
				wrapper.find('.input-record-wrapper').slideUp();
			});
			$('.box-icon .btn-group .btn-input').live('click',function(e){
				var wrapper = $(e.target).closest('.intern-add-wrapper');
				// 切换到手动输入时，如果box是收缩状态则把它展开
				if(!wrapper.find('.box-content').is(":visible")){
					$(e.target).closest('.intern-add-wrapper').find('.input-record-wrapper').show();
					wrapper.find('.box-header .btn-minimize').click();
				}else{
					$(e.target).closest('.intern-add-wrapper').find('.input-record-wrapper').slideDown();
				}
			});

			// 手动输入记录表格
			$('.input-record-wrapper .form-actions .switch-to-barcode').live('click',function(e){
				e.preventDefault();
				$(e.target).closest('.intern-add-wrapper').find('.box-header .btn-barcode').click();
			});
		});
	</script>
</body>
</html>
