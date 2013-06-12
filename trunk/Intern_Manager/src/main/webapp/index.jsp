
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp" %>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <meta charset="utf-8">
    <title>Cloud|在云中</title>
    <link href="${ctx}/static/css/bootstrap-readable.css" rel="stylesheet">
    <link href="${ctx}/static/css/cloud-global.css" rel="stylesheet">
    <link href="${ctx}/static/jplayer/skin/blue.monday/jplayer.blue.monday.css" rel="stylesheet" type="text/css" />
	<style type="text/css">
		#fap-meta-wrapper p{margin:0;padding:0;}
		#fap-meta-wrapper{
			height:60px;
			width: 530px;
			position:absolute;
			left:0;
			padding-top:10px;
		}
		#fap-current-cover{
			text-align: center;
			font-size: 18px;
			float: left;
			-webkit-border-radius: 2px;
			-moz-border-radius: 2px;
			border-radius: 2px;
			-webkit-box-shadow: 0px 2px 3px 0px rgba(0, 0, 0, 0.5);
			-moz-box-shadow: 0px 2px 3px 0px rgba(0, 0, 0, 0.5);
			box-shadow: 0px 2px 3px 0px rgba(0, 0, 0, 0.5);
		}
		#fap-current-title {
			font-weight: bold;
			font-size: 12px;
			line-height: 18px;
			padding-right: 10px;
		}
		#fap-current-meta {
			font-size: 10px;
		}
		img.poster-small{
			text-align: center;
			float: left;
			width: 24px;
			height: 24px;
			border: 1px solid #e0e0e0;
			margin-right:10px;
		}
		#xiabao-player{
			box-shadow: 0 -3px 6px rgba(0, 0, 0, 0.3);
			position:fixed;
			bottom:0;
			width:100%;
			z-index:100;
			background-color: #F0F0F0;
			border-top: solid 1px #E0E0E0;
		}
		div.jp-audio{
			margin:0 auto;
		}
	</style>
    <!-- Le styles -->


    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="${ctx}/static/ico/favicon.png">

  </head>

  <body>
	<a style="display:none" id="context-path" href="${ctx}"></a>

	 <!-- 上导航条  begin -->
      <div id="nav-top" class="navbar navbar-fixed-top navbar-inverse">
         <div id="nav-inner" class="navbar-inner">
           <div class="container">
            <!-- <a id="logo" href="#"><img src="static/img/logo.png"></a> -->
             <a class="brand" href="${ctx}">Cloud | 在云中</a>
             <div class="nav-collapse collapse" id="main-menu">
              <form class="navbar-search pull-right" action="">
                <input id="search-input" type="text" class="search-query span2" placeholder="请输入关键字搜索" href="${ctx}/track/query?k=">
              </form>

              <ul class="nav pull-right" id="main-menu-right">
                <li><a href="${ctx}/index-content">首页</a></li>
                <li><a id="latest-tracks-nav" href="${ctx}/latest">最新音乐</a></li>
                <li><a href="${ctx}/category">歌曲分类</a></li>
                <li><a href="${ctx}/popular">排行榜</a></li>
              </ul>
             </div>
           </div>
         </div>
       </div>
    <!-- 上导航条  end -->

    <div class="containter" id="content-wrapper">

    </div>


    <!-- Le javascript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->

    <script src="${ctx}/static/js/jquery.js"></script>
    <script src="${ctx}/static/js/bootstrap.min.js"></script>
    <script src="${ctx}/static/js/jquery.rotate.js"></script>
    <script src="${ctx}/static/js/jquery.grab.js"></script>
    <script src="${ctx}/static/js/zen.js"></script>
    <script src="${ctx}/static/js/jquery-ui-slider.js"></script>
    <script src="${ctx}/static/js/jquery.form.js"></script>
    <script src="${ctx}/static/js/moment.min.js"></script>
    <script src="${ctx}/static/js/lrc.js"></script>


	<script src="${ctx}/static/jplayer/jquery.jplayer.min.js"></script>
	<script src="${ctx}/static/jplayer/jplayer.playlist.js"></script>

	<script type="text/javascript" src="${ctx}/static/noty/jquery.noty.js"></script>
	<script type="text/javascript" src="${ctx}/static/noty/layouts/top.js"></script>
	<script type="text/javascript" src="${ctx}/static/noty/layouts/topCenter.js"></script>
	<script type="text/javascript" src="${ctx}/static/noty/themes/default.js"></script>

	<!-- player -->
	<div id="xiabao-player">
			<div id="jquery_jplayer_1" class="jp-jplayer"></div>
			<div id="jp_container_1" class="jp-audio">
				<div class="jp-type-playlist">
					<div class="jp-gui jp-interface">

						<!-- meta -->
						<div id="fap-meta-wrapper" class="clearfix" style="height: 60px; ">
							<img src="${ctx}/static/img/headphones.png" id="fap-current-cover" style="width: 50px; height: 50px; border: 1px solid rgb(224, 224, 224); ">
							<p id="fap-current-title" style="color: rgb(60, 60, 60); margin-left: 60px; ">未选择歌曲</p>
							<p id="fap-current-meta" style="color: rgb(102, 102, 102); margin-left: 60px; "></p>
							<p class="jp-lrc" style="font-weight: bold;margin-left: 60px; color:#006DDA;">
						</div>

						<ul class="jp-controls">
							<li><a href="javascript:;" class="jp-previous" tabindex="1" data-toggle="tooltip" title="上一首">previous</a></li>
							<li><a href="javascript:;" class="jp-play" tabindex="1" data-toggle="tooltip" title="播放">play</a></li>
							<li><a href="javascript:;" class="jp-pause" tabindex="1" data-toggle="tooltip" title="暂停">pause</a></li>
							<li><a href="javascript:;" class="jp-next" tabindex="1" data-toggle="tooltip" title="下一首">next</a></li>
							<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
							<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute" >mute</a></li>
							<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
							<li><a href="javascript:;" class="jp-volume-max" tabindex="1" data-toggle="tooltip" title="最大音量">max volume</a></li>
						</ul>
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-volume-bar">
							<div class="jp-volume-bar-value"></div>
						</div>
						<div class="jp-time-holder">
							<div class="jp-current-time"></div>
							<div class="jp-duration"></div>
						</div>

						<a href="javascript:;" class="jp-playlist-handler" data-toggle="tooltip" title="列表" tabindex="1" ></a>
					</div>

					<div class="jp-seperator">
					</div>

					<div class="jp-playlist">
						<ul>
							<li>列表没有歌曲。</li>
						</ul>
					</div>
					<div class="jp-no-solution">
						<span>Update Required</span>
						To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
					</div>
				</div>
			</div>
		</div>


	<!-- 评论弹出框 -->
      <div class="modal hide fade" id="comment-modal">
      	  <a href="" style="display:none" id="comment-area-id"></a>
          <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">×</button>
          <h4>发表评论</h4>
          </div>
          <div class="modal-body">
                <form class="form-horizontal" id="comment-form" action="${ctx}/comment/add" method="post">
                      <input type="hidden" id="comment-input-track-id" name="track.id">
                <fieldset>
                  <div class="control-group">
                    <label for="input01" class="control-label">邮箱</label>
                    <div class="controls">
                      <input type="text" id="input01" name="email">
                    </div>
                  </div>

                  <div class="control-group">
                    <label for="input02" class="control-label">用户名</label>
                    <div class="controls">
                      <input type="text" id="input02" name="name" >
                    </div>
                  </div>

                  <div class="control-group">
                    <label for="textarea" class="control-label">评论内容</label>
                    <div class="controls">
                      <textarea  style="height: 170px;" id="textarea" name="content"></textarea>
                    </div>
                  </div>

                </fieldset>
              </form>
          </div>
          <div class="modal-footer">
          <a href="javascript:" class="btn btn-primary btn-mini" onclick="postComment();">确定</a>
          <a href="javascript:" class="btn btn-mini" data-dismiss="modal" id="dismiss-comment-modal-btn">取消</a>
          </div>
      </div>

    <script type="text/javascript">
       	var ctx = $("#context-path").attr('href');

       	$.noty.defaults = {
       			layout: 'topCenter',
       			theme: 'default',
       			type: 'success',
       			text: '',
       			dismissQueue: true, // If you want to use queue feature set this true
       			template: '<div class="noty_message"><span class="noty_text"></span><div class="noty_close"></div></div>',
       			animation: {
       				open: {opacity: 'show'},
       				close: {height: 'toggle'},
       				easing: 'linear',
       				speed: 200 // opening & closing animation speed
       			},
       			force: false, // adds notification to the beginning of queue when set to true
       			modal: false,
       			closeWith: ['click'], // ['click', 'button', 'hover']
       			callback: {
       				onShow: function() {},
       				afterShow: function() {},
       				onClose: function() {},
       				afterClose: function() {}
       			},
       			buttons: false, // an array of buttons
       			timeout: 600 // delay for closing event. Set false for sticky notifications
       		};

        $(function(){
        	$('*[data-toggle="tooltip"]').tooltip();

        	var contentWrapper = $("#content-wrapper");
			$("#main-menu-right a").click(function(event){
				event.preventDefault();
				$("#main-menu-right li").removeClass('active');
				$(this).parent().addClass("active");
				$("#content-wrapper").load($(this).attr('href'));
        	});

			$("#search-input").keydown(function(e){if(e.keyCode == 13) return false;}).keyup(function(e){
				if(e.keyCode == 13){
					$("#main-menu-right li").removeClass('active');
					$("#content-wrapper").load($(this).attr('href')+encodeURIComponent($(this).val()));
				}
			});

			/**
			* 歌曲列表。
				1. 展开时的css切换；
				2. 歌曲详情的ajax load；
			*/
			$('.track-list .accordion-body').live('hidden show',function(event){
                $(event.target).parent().toggleClass('white-panel').toggleClass('accordion-group');
            });

			 $('.list-track-name a').live('click',function(event){
	            	event.stopPropagation();
	            	event.preventDefault();
	            	var collapseBody = $($(this).attr('href'));
	            	if(collapseBody.height()>0){
	            		collapseBody.collapse('hide');
	            	}else{
		            	collapseBody.find('.accordion-inner').load(ctx+'/track/'+$(this).attr('track-id'),{},function(){
		            		collapseBody.collapse('show');
		            	});
	            	}
	            });

			// 歌曲列表翻页
			$('.track-list-pagination a').live("click",function(event){
				if($(event.target).closest('li').is('.disabled'))
					return;
				$(event.target).closest('.track-list').load($(event.target).attr('link'));
			});

			// 载入首页
			$('#main-menu-right a:first').click();

			// 播放器
			xbPlayer = new jPlayerPlaylist({
				jPlayer: "#jquery_jplayer_1",
				cssSelectorAncestor: "#jp_container_1"
			}, [], {
				swfPath: ctx+"/static/jplayer",
				supplied: "mp3",
				solution: 'flash,html',
				preload: 'metadata',
				 volume: 0.8,
				 muted: false,
				playlistOptions:{
					enableRemoveControls:true
				}
			});
			$(".jp-playlist-handler").click(function(){
				$('.jp-playlist').slideToggle('fast',function(){
					$('.jp-seperator').toggle();
				});
			});

			 function getDataForPlayer(a){
					return {
						title:a.attr("name"),
						artist:a.attr("artist"),
						mp3:ctx+a.attr("mp3"),
						poster:ctx+a.attr("album-img"),
						album:ctx+a.attr("album"),
						lrc:ctx+a.attr('lrc'),
						free:true,
						id:a.attr("trackId")
					};
				}

			$("i.icon-play, .popular-track a.play").live('click',function(event){
				var a = $(event.target);
				var t = getDataForPlayer(a);
				xbPlayer.add(t,true);
				noty({text:'已开始播放!'});
				$.get(ctx+"/track/inc-play-times/"+t.id);
			});

			$("i.icon-plus").live('click',function(event){
				var a = $(event.target);
				xbPlayer.add(getDataForPlayer(a),false);
				noty({text:'添加成功!'});
			});

			$("i.icon-download,a.jp-playlist-item-free").live('click',function(event){
				var a = $(event.target);
				$.get(ctx+"/track/inc-download-times/"+a.attr("trackId"));
			});

			// 播放所有歌曲、加入播放列表
			$(".add-list-btn").live('click',function(e){
				$(e.target).next().find("i.icon-plus").each(function(){
					xbPlayer.add(getDataForPlayer($(this)),false);
				});
				noty({text:'添加成功!'});
			});
			$(".play-list-btn").live('click',function(e){
				var e = $(e.target).next().next().find("i.icon-play");
				e.each(function(i){
					xbPlayer.add(getDataForPlayer($(this)),(i == 0)?true:false);
				});
				noty({text:'已开始播放!'});
			});

        });

        /**
         	发表评论
        */
        function postComment(){
        	var trackId = $('#comment-input-track-id').val();
			$("#comment-form").ajaxSubmit({
				resetForm:true,
				beforeSubmit:function(){
					// TODO 校验
					//$('#upload-track-form input').attr('disabled','disabled');
					//$('#btn-add-track').addClass('disabled');
					//$('#uploading-tip').text("上传中...").show();
				},
				success:function(data){
					/*$('#upload-track-form input').removeAttr('disabled');
					$('#upload-track-form .file-name').text('');
					$('#btn-add-track').removeClass('disabled');
					$('#uploading-tip').text("上传成功！").show();*/

					var c = eval(data).result;
					$('#dismiss-comment-modal-btn').click();
					var a = $('#'+$('#comment-area-id').attr('href'));

					//已有评论列表
					if(a.children('ul.comment-list').length > 0){
						var n = $(
								'<li class="comment" style="display:none;">'+
						          '<img alt="" src="http://www.gravatar.com/avatar/'+c.emailHash+'/?s=50">'+
						          '<span class="comment-nick">'+c.name+'</span>'+
						          '<span class="comment-post-time">'+moment(c.postTime).format('YYYY/MM/DD HH:mm')+'</span>'+
						          '<div class="comment-content"></div>'+
						        '</li>'
								);
						n.find(".comment-content").text(c.content);
						a.children('ul.comment-list').prepend(n);
						n.slideDown('1000');
					}
					//没有评论
					else{
						var ele = $(
						'<div class="comment-title">'+
						'<h6>最新评论</h6>'+
						'<button class="btn btn-mini" data-target="#comment-modal" data-toggle="modal" onclick="prepareCommentForm('+trackId+');">发表评论</button>'+
						'</div>'+
						'<ul class="comment-list">'+
						'<li class="comment">'+
				          '<img alt="" src="http://www.gravatar.com/avatar/'+c.emailHash+'/?s=48">'+
				          '<span class="comment-nick">'+c.name+'</span>'+
				          '<span class="comment-post-time">'+moment(c.postTime).format('YYYY/MM/DD HH:mm')+'</span>'+
				          '<div class="comment-content">'+c.content+'</div>'+
				        '</li>'+
						'</ul>'
						).hide();
						a.html('').prepend(ele);
						ele.fadeIn('slow');
					}
				}
			});
        }

        function prepareCommentForm(trackId){
        	$('#comment-input-track-id').val(trackId);
        	$('#comment-area-id').attr('href','comment-area-'+trackId);
        }
    </script>

  </body>

  </body>
</html>
