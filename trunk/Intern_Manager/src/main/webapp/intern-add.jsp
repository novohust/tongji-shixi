<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageTitle" value="考勤录入" scope="page"></c:set>

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
			color:black!important;
		}
		.intern-table{
			margin-bottom: 0;
		}
		.intern-table i{
			font-size:14px;
		}
		.input-record-wrapper{
    /*background-color: #F4F4F4;
    border-color: #CCCCCC;
    border-radius: 0 0 5px 5px;
    border-width: medium 1px 1px;
    box-shadow: 3px 4px 4px #ECECEC;

    overflow: hidden;

    */padding: 15px 0 0;margin: -10px auto 7px;width: 500px;
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
	</style>
</head>

<body>
	<!-- start: Header -->
	<div class="navbar">
		<div class="navbar-inner">
			<div class="container-fluid">
				<a class="brand" href="index.html"><span>考勤管理系统</span></a>

				<!-- start: Header Menu -->
				<div class="nav-no-collapse header-nav">
					<ul class="nav pull-right">
						<!-- end: User Dropdown -->
						<li  rel="tooltip" title="退出登录">
							<a class="btn" href="#">
								<i class="halflings-icon white off"></i>
							</a>
						</li>
					</ul>
				</div>

				<div class=" pull-right" style="margin-top:10px;margin-right:10px;">
					<i class="halflings-icon white user" style="margin-top:3px;"></i>&nbsp;欢迎回来，admin
				</div>
				<!-- end: Header Menu -->

			</div>
		</div>
	</div>
	<!-- end: Header -->

	<div class="container-fluid">
		<div class="row-fluid">

			<!-- start: Main Menu -->
			<div id="sidebar-left" class="span1">
				<div class="nav-collapse sidebar-nav">
					<ul class="nav nav-tabs nav-stacked main-menu">
						<li><a href="intern-add.html"><i class="fa-icon-barcode"></i><span class="hidden-tablet"> 考勤录入</span></a></li>
						<li><a href="intern-query.html"><i class="fa-icon-search"></i><span class="hidden-tablet"> 考勤查询</span></a></li>
						<li><a href="barcode-print.html"><i class="fa-icon-print"></i><span class="hidden-tablet"> 条码打印</span></a></li>
						<li><a href="data-import.html"><i class="fa-icon-signin"></i><span class="hidden-tablet"> 数据导入</span></a></li>
						<li><a href="data-manage.html"><i class="fa-icon-align-justify"></i><span class="hidden-tablet"> 数据管理</span></a></li>
					</ul>
				</div>
			</div>
			<!-- end: Main Menu -->

			<!-- start: Content -->
			<div id="content" class="span11" style="border-top-left-radius:0;">
				<!--  start: 考勤录入教师区块 -->
				<div class="row-fluid intern-add-wrapper animated">
					<div class="box span12">
						<div class="box-header">
							<span class="label label-success record-num">4</span>
							<div class="teacher-select-wrapper">
								<label >科室</label>
								<select rel="uniform" name="">
									<option value="1">麻醉科</option>
									<option value="2">外科</option>
									<option value="3">内科</option>
								</select>
								<label >病区</label>
								<select name="" rel="uniform" >
									<option value="1">12楼东</option>
									<option value="2">病区一</option>
									<option value="3">病区二</option>
								</select>
								<label >教授组</label>
								<select name="" rel="uniform" >
									<option value="1">张教授组</option>
									<option value="2">里教授组</option>
									<option value="3">王教授组</option>
								</select>
								<label >老师</label>
								<select name=""  rel="uniform" >
									<option value="1">张三</option>
									<option value="2">李四</option>
									<option value="3">王二</option>
								</select>
							</div>
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
											<label for="" class="control-label">姓名</label>
											<div class="controls"><input type="text" class="input-large" placeholder="请输入学生姓名"></div>
										</div>
										<div class="control-group">
											<label for="" class="control-label">实习月份</label>
											<div class="controls">
												<select name="" id="" class="input-mini" rel="uniform">
													<option value="1">2011</option>
													<option value="2">2012</option>
													<option value="3">2013</option>
													<option value="4">2014</option>
													<option value="5">2015</option>
												</select>
												<select name="" id="" class="input-mini" rel="uniform">
													<option value="1">1</option>
													<option value="2">2</option>
													<option value="3">3</option>
													<option value="4">4</option>
													<option value="5">5</option>
													<option value="6">6</option>
													<option value="7">7</option>
													<option value="8">8</option>
													<option value="9">9</option>
													<option value="10">10</option>
													<option value="11">11</option>
													<option value="12">12</option>
												</select>
											</div>
										</div>
										<div class="control-group">
											<label for="" class="control-label">实习区间</label>
											<div class="controls">
												<select name="" id="" class="input-small" rel="uniform">
													<option value="1">整月</option>
													<option value="2">第1周</option>
													<option value="3">第2周</option>
													<option value="4">第3周</option>
													<option value="5">第4周</option>
												</select>
											</div>
										</div>
										<div class="form-actions" >
											<button class="btn btn-primary" type="submit">确定</button>
											<button class="btn switch-to-barcode" >取消</button>
										  </div>
									</fieldset>
								</form>
							</div>
							<!--start: 考勤记录列表 -->
							<table class="table intern-table">
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
									<tr>
										<td>Muhammad Usman</td>
										<td class="center">M20127512</td>
										<td class="center">2013-02</td>
										<td class="center">第1周</td>
										<td class="center"><a href="#"><i class="fa-icon-remove remove-tr"></i></a></td>
									</tr>
									<tr>
										<td>Muhammad Usman</td>
										<td class="center">M20127512</td>
										<td class="center">2013-02</td>
										<td class="center">第1周</td>
										<td class="center"><a href="#"><i class="fa-icon-remove remove-tr"></i></a></td>
									</tr>
									<tr>
										<td>Muhammad Usman</td>
										<td class="center">M20127512</td>
										<td class="center">2013-02</td>
										<td class="center">第1周</td>
										<td class="center"><a href="#"><i class="fa-icon-remove remove-tr"></i></a></td>
									</tr>
									<tr>
										<td>Muhammad Usman</td>
										<td class="center">M20127512</td>
										<td class="center">2013-02</td>
										<td class="center">第1周</td>
										<td class="center"><a href="#"><i class="fa-icon-remove remove-tr"></i></a></td>
									</tr>
								  </tbody>
						 	</table>
							<!--end: 考勤记录列表 -->
						</div>
					</div>
				</div>
				<!--  end 考勤录入教师区块 -->

				<!--start: form actions-->
				<div class="form-actions center-form-action" >
					<button class="btn btn-large" id="add-area">增加区块</button>
					<button class="btn btn-success btn-large" type="submit">全部提交</button>
					<a href="#" id="showcase-validate" style="display:block;">演示：提交时validate</a>
					<a href="#" id="showcase-repeatwithdb" style="display:block;">演示：新增时与后台记录重复</a>
					<a href="#" id="showcase-repeatwithcur" style="display:block;" class="noty" data-noty-options='{"text":"新增记录失败，与已有记录冲突！","timeout":2000,"layout":"topCenter","type":"warning"}'>演示：新增时与当前记录重复</a>
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
							<td>Muhammad Usman</td>
							<td class="center">M20127512</td>
							<td class="center">2013-02</td>
							<td class="center">第1周</td>
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
						  </tr>
					  </thead>
					  <tbody>
						<tr>
							<td>Muhammad Usman</td>
							<td class="center">M20127512</td>
							<td class="center">2013-02</td>
							<td class="center">第1周</td>
						</tr>
						<tr>
							<td>Muhammad Usman</td>
							<td class="center">M20127512</td>
							<td class="center">2013-02</td>
							<td class="center">第1周</td>
						</tr>
						<tr>
							<td>Muhammad Usman</td>
							<td class="center">M20127512</td>
							<td class="center">2013-02</td>
							<td class="center">第1周</td>
						</tr>
						<tr>
							<td>Muhammad Usman</td>
							<td class="center">M20127512</td>
							<td class="center">2013-02</td>
							<td class="center">第1周</td>
						</tr>
					  </tbody>
			 	</table>
			</div>
			<div class="modal-footer">
				<a href="#" class="btn" data-dismiss="modal">取消</a>
				<a href="#" class="btn btn-primary">继续</a>
			</div>
		</div>

		<div class="clearfix"></div>

		<footer>
			<p>
				<span style="text-align:left;float:left">&copy; <a href="" target="_blank">华中科技大学同济医学院</a> 2013</span>
				<span class="hidden-phone" style="text-align:right;float:right">Powered by: <a target="_blank" href="http://kruskal.diandian.com">Kruskal</a></span>
			</p>
		</footer>
	</div>
	<!--/.fluid-container-->

	<!-- start: JavaScript-->
	<%@ include file="/common/import-js.jsp"%>
	<!-- end: JavaScript-->

	<script type="text/javascript">

		$(function(){
			$('.intern-add-wrapper').live('click',function(e){
				$('.selected').removeClass('selected');
				$(this).addClass('selected');
			});

			//添加区块
			$('#add-area').click(function(){
				var lastArea = $('.intern-add-wrapper').last();
				var selectsInLastArea = lastArea.find('select');
				$.uniform.restore(selectsInLastArea);
				var area = lastArea.clone().hide().removeClass('selected');
				// header里元素的重置
				area.find('.box-header').find('.record-num').removeClass('label-success').addClass('label-important').html(0);
				area.find('.box-header').find('.btn-barcode').addClass('active');
				area.find('.box-header').find('.btn-input').removeClass('active');
				area.find('.box-header').find('.btn-minimize i').removeClass('chevron-up').addClass('chevron-down');
				// content的元素重置
				area.find('.box-content,.intern-table,.input-record-wrapper').hide();
				area.find('.box-content .intern-table tbody tr').remove();
				// 拷贝下拉框的值
				var selectsInArea = area.find('select');
				selectsInArea.each(function(i){
					$(this).find('option[value="'+$(selectsInLastArea.get(i)).val()+'"]').attr('selected',true);
				});
				console.log(lastArea.height());
				area.insertBefore($('.center-form-action')).slideToggle(function(){selectsInArea.uniform();});
				selectsInLastArea.uniform();
				$('.box-header .btn-close').fadeIn();
			});

			//考勤记录表格
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

			// 演示相关

			$('#showcase-validate').click(function(){
				$(".intern-add-wrapper").each(function(){
					if($(this).find('.record-num').html() == 0 && $(this).not('shake')){
						$(this).addClass('shake');
						setTimeout($.proxy(function(){this.removeClass('shake')},$(this)),1000);
					}
				});
			});
			$('#showcase-repeatwithcur').click(function(){
				$('.intern-table tbody tr.alert').removeClass("alert");
				var tr = $(".intern-table tbody tr").last();
				tr.addClass('alert');
				var btn = tr.closest('.intern-add-wrapper').find('.box-header .btn-minimize');
				btn.find('i').is('.chevron-down')?btn.click():null;
			});
			$('#showcase-repeatwithdb').click(function(){
				$('#myModal').modal();
			});
		});
	</script>
</body>
</html>
