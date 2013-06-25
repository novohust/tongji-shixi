<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.hustsse.cloud.enums.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<c:set var="genderEnums" value="<%=GenderEnum.values()%>"/>
<c:set var="stuTypeEnums" value="<%=StuTypeEnum.values()%>"/>
<c:set var="weekEnums" value="<%=WeekEnum.values()%>"/>

