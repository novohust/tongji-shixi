if(typeof(ACME_LESS) === 'undefined'){
    var ACME_LESS = {};
}
(function($){
    ACME_LESS.paging = {
        dfConfigs : {},
        //初始化函数
        init:function(configs){
            this.dfConfigs = {
                CurPageNumObj : $('#pageNum'),   //获取当前页页码
                formObj : $('#queryform'),                    //需提交的 form 对象
                pagingObj : $('#pagination'),                 //分页对象
                pageSizeObj:$('#pageSize'),      //每个页面上显示的信息条数
                totalCountObj:$('#totalCount'),  //信息总条数
                total:100,                                    //分页总数
                onPagingCompleted:function(queryForm){        //点击分页后执行
                queryForm.submit();
                }
            }
            var dfConfigs = this.dfConfigs;
            dfConfigs = $.extend(dfConfigs,configs || {});
            dfConfigs.CurPageNum = dfConfigs.CurPageNumObj.attr('value')*1;
            dfConfigs.pageSize = dfConfigs.pageSizeObj.attr('value')*1;
            dfConfigs.totalCount = dfConfigs.totalCountObj.attr('value')*1;
            //获取各个节点
            var pagination = dfConfigs.pagination = dfConfigs.pagingObj.find('.page-detail').eq(0), //页码的父节点
                pagem = dfConfigs.pagem = dfConfigs.pagingObj.find('em').eq(0),                       //共几页
                pagenum = dfConfigs.pagenum = dfConfigs.pagingObj.find('input').eq(0),                //页码输入框
                pagesubmit = dfConfigs.pagesubmit = dfConfigs.pagingObj.find('button.btn').eq(0),     //确定按钮
                pnReg = /^[1-9]\d*$/,
                pnCache = '',
                num,// 当前页码
                max,// 最大值
                //输入框验证是否为数字
                vPn = function(){
                    if (this.value) {
                        if (pnReg.test(this.value)) {
                            pnCache = this.value;
                        }else{
                            this.value = pnCache;
                        }
                    }else{
                        pnCache = '';
                    }
                }
            dfConfigs.total = Math.ceil(dfConfigs.totalCount/dfConfigs.pageSize);
            //为输入框以及按钮绑定事件
            pagenum.bind('focus', function(){
                this.select();
            });
            pagenum.bind('keydown', function(e){
                if (e.keyCode && e.keyCode == 13) {
                    pagesubmit.click();
                    this.select();
                }
            });
            pagenum.bind('keyup', vPn);
            pagenum.bind('blur', vPn);
            //点击确定按钮时触发
            pagesubmit.bind('click', function(e){
                e.preventDefault();
                if (!pagenum.attr('value')){
                    return;
                }
                num = (pagenum.attr('value') || 0) * 1;
                max = dfConfigs.total * 1;
                if (num > max){
                    num = max;
                    pagenum.attr('value',max);
                }
                dfConfigs.CurPageNumObj.attr('value',num);
                //提交表单
                dfConfigs.onPagingCompleted(dfConfigs.formObj);
            });
            //初始化页码
            this.render(dfConfigs.CurPageNum,dfConfigs.total);
        },
        /*
        * 初始化页码
        * param{number}                  cur 当前页码
        * param{bumber}                  total 页码总数
        */
        render: function(cur,total){
            var html = [],                        //html片段
                pre,                              //前一页
                next,                             //后一页
                dfConfigs = this.dfConfigs,
                pagenum = dfConfigs.pagenum,      //input输入框的值
                i, page;                          //当前页码
            if (cur < 1){
                cur = 1;
            }
            if (total < 1){
                total = 1;
            }
            if (cur > total){
                cur = total;
            }
            dfConfigs.pagem.html(total);
            if (cur == 1) {
                html.push('<li class="disabled"><a href="javascript:;" target="_self"> 上一页 </a></li>');
                html.push('<li class="active"><a href="javascript:;" target="_self">1</a></li>');
            }else {
                html.push('<li><a href="javascript:;" page="' + (cur - 1) + '" target="_self">上一页 </a></li>');
                html.push('<li><a href="javascript:;" page="1">1</a></li>');
            }
            if (total > 1) {
                if (cur > 4 && total > 7)
                    html.push('<li><a class="omit" href="javascript:;" target="_self">...</a></li>');
                switch(true){
                    case cur < 3:
                        pre = 0;
                        next = cur == 1 ? 5 : 4;
                        if (cur + next > total){
                            next = total - cur;
                        }
                        break;
                    case cur == 3:
                        pre = 1;
                        next = 3;
                        if (cur + next > total){
                            next = total - cur;
                        }
                        break;
                    default:
                        pre = 2;
                        next = 2;
                        if (cur + next > total){
                            next = total - cur;
                        }
                        pre = 4 - next;
                        if (cur + 3 > total)
                            pre++;
                        if (cur - pre < 2){
                            pre = cur - 2;
                        }
                }
                //前一页页码
                for (i = pre; 0 < i; i--){
                    html.push('<li><a href="javascript:;" page="' + (cur - i) + '">' + (cur - i) + '</a></li>');
                }
                //当前页
                if (cur > 1){
                     html.push('<li class="active"><a  href="javascript:;" target="_self">' + cur + '</a></li>');
                }
                //当前页之后的页码
                for (i = 1; i < next + 1; i++){
                    html.push('<li><a href="javascript:;" page="' + (cur + i) + '">' + (cur + i) + '</a></li>');
                }
                if (cur + next < total - 1) {
                    html.push('<li><a class="omit" href="javascript:;" target="_self">...</a></li>');
                    html.push('<li><a href="javascript:;" page="' + total + '">' + total + '</a></li>');
                }
                if (cur + next == total - 1){
                    html.push('<li><a href="javascript:;" page="' + total + '">' + total + '</a></li>');
                }
            }
            if (cur === total)
                html.push('<li class="disabled"><a  href="javascript:;" target="_self">下一页</a></li>');
            else {
                html.push('<li><a  href="javascript:;" page="' + (cur + 1) + '" target="_self">下一页</a></li>');
            }
            dfConfigs.pagination.html(html.join(''));
            //set nomarl
            if (pagenum.attr('value') && pagenum.attr('value') * 1 > total){
                pagenum.attr('value',cur);

            }
            //鼠标点击分页提交表单
            dfConfigs.pagination.find('a[page]').bind('click',function(e){
                e.preventDefault();
                page = $(this).attr('page') * 1;
                if(page > total){
                    page = total;
                }
                dfConfigs.CurPageNumObj.attr('value',page);
                dfConfigs.onPagingCompleted(dfConfigs.formObj)
            });
        }
    }
    $(document).ready(function(){
    	if($('#queryform').length > 0){
    		ACME_LESS.paging.init();
    	}
    });
})(jQuery)

