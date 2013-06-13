<%@ page contentType="text/html;charset=UTF-8"%>
<div id="data-man-nav-wapper">
	<div data-toggle="buttons-radio" class="btn-group">
	      			<a class="btn <c:if test="${dataManCurPage == 'student'}">btn-primary active</c:if>" href="${ctx}/data-manage/student">学生</a>
                    <a class="btn <c:if test="${dataManCurPage == 'teacher'}">btn-primary active</c:if>" href="${ctx}/data-manage/teacher">老师</a>
                    <a class="btn <c:if test="${dataManCurPage == 'major'}">btn-primary active</c:if>" href="${ctx}/data-manage/major">专业</a>
                    <a class="btn <c:if test="${dataManCurPage == 'department'}">btn-primary active</c:if>" href="${ctx}/data-manage/department">科室</a>
                    <a class="btn <c:if test="${dataManCurPage == 'area'}">btn-primary active</c:if>" href="${ctx}/data-manage/area">病区</a>
                    <a class="btn <c:if test="${dataManCurPage == 'teacherTeam'}">btn-primary active</c:if>" href="${ctx}/data-manage/teacher-team">教授组</a>
                    <a class="btn <c:if test="${dataManCurPage == 'secondarySubject'}">btn-primary active</c:if>" href="${ctx}/data-manage/secondary-subject">二级学科</a>
    </div>
</div>