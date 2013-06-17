<%@page import="org.hustsse.cloud.web.print.PrintController.InternRange"%>
<%@page import="java.util.List"%>
<%@page import="org.hustsse.cloud.entity.Student"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<c:set var="pageTitle" value="打印预览" scope="page"></c:set>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<style type="text/css">
	/*body {
        margin: 0;
        padding: 0;
        font: 12pt "微软雅黑";
        background-color:#f5f5f5;
    }
     * {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
	.a4-wrapper{overflow:hidden;width:21cm;height:29.7cm;
	margin: 1cm auto;
        border-radius: 5px;
        background: white;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);}

	.barcode{width:6.9cm;float:left;height:0.90cm;}
	.img-wrapper{padding:10px;}
	.desc{padding:5px 0 0 10px;}

	@page {
        size: A4;
        margin: 0;
    }
    @media print {
        .a4-wrapper {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after: always;
        }
    }*/


           body {
        margin: 0;
        padding: 0;
        background-color: #FAFAFA;
        font: 12pt "Tahoma";
    }
    * {
        box-sizing: border-box;
        -moz-box-sizing: border-box;
    }
    .page {
        width: 21cm;
        min-height: 29.7cm;
        margin: 1cm auto;
        border: 1px #D3D3D3 solid;
        border-radius: 5px;
        background: white;
        box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
        overflow:hidden;
    }
    .subpage {
        padding: 1cm;
        border: 5px red solid;
        height: 237mm;
        outline: 2cm #FFEAEA solid;
    }

    .barcode{width:33%;float:left;height:3.1%;}
    .desc{text-align:center;}

    @page {
        size: A4;
        margin: 0;
    }
    @media print {
        .page {
            margin: 0;
            border: initial;
            border-radius: initial;
            width: initial;
            min-height: initial;
            box-shadow: initial;
            background: initial;
            page-break-after: always;
        }
    }
</style>
</head>

<body>


	<div class="page">

		<%!
			String getHtml(String url,String desc){
				String html = "";
				html+="	<div class='barcode'>		";
				html+="		<div class='img-wrapper'>  		";
				html+="			<img src='"+url+"'>  		";
				html+="		</div>									";
				html+="		<div class='desc'>									";
				html+=desc;
				html+="		</div>									";
				html+="	</div>										";
				return html;
			}
		%>

		<% 	int barcodeNum = 0;
			String anotherPage = "</div><div class='page'>";
			List<Student> students = (List<Student>)request.getAttribute("students");
			for(int j = 0;j<students.size();j++){
				Student s = students.get(j);
				for(InternRange r :(List<InternRange>)request.getAttribute("ranges")){
					// 对每个打印范围生成条码

					// 如果月份选择全部，打印12张条码
					// 如果选择某个月份，看是否按周拆分：
						// 未勾选：打印1张条码
						// 勾选：看周的值
							// 周 == 全部：打印4张条码
							// 周 == 1|2|3|4：打印1张条码
					String desc = s.getName()+"&nbsp;&nbsp;"+s.getMajor().getName();
					if(r.getMonth() == null || r.getMonth() == 0){
						for(int i = 1;i<=12;i++){
							out.println(getHtml("",desc));
							barcodeNum ++;
							if(barcodeNum % 32 == 0) out.println(anotherPage);
						}
					}else{
						if(r.getSplitByWeek() == null || !r.getSplitByWeek()){
							out.println(getHtml("",desc));
							barcodeNum ++;
							if(barcodeNum % 32 == 0) out.println(anotherPage);
						}else{
							if(r.getWeek() == WeekEnum.All){
								for(WeekEnum w : WeekEnum.values()){
									if(w == WeekEnum.All) continue;
									out.println(getHtml("",desc));
									barcodeNum ++;
									if(barcodeNum % 32 == 0) out.println(anotherPage);
								}
							}else{
								out.println(getHtml("",desc));
								barcodeNum ++;
								if(barcodeNum % 32 == 0) out.println(anotherPage);
							}
						}
					}
				}
				if(PrintTypeEnum.PagedByStu == (PrintTypeEnum)request.getAttribute("printType") && barcodeNum % 32 != 0 && j != students.size() - 1){
					out.println(anotherPage);
					barcodeNum = 0;
				}
			} %>
	</div>




	<script type="text/javascript">
	</script>
</body>
</html>
