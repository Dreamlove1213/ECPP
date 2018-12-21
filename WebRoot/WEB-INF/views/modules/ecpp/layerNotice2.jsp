<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信息管理</title>
    <link href="${ctxStatic}/indexStyle/css/font-awesome.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/ionicons.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/perfect-scrollbar.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/rickshaw.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctxStatic}/indexStyle/css/starlight.css">
	<link rel="stylesheet" href="${ctxStatic}/indexStyle/css/bootstrap.min.css">
	<script src="${ctxStatic}/indexStyle/jquery.min.js"></script>
	<script src="${ctxStatic}/indexStyle/bootstrap.min.js"></script>
	<script src="${ctxStatic}/common/clearBoxRight.js" type="text/javascript"></script>
</head>
<body>
<div class="panel panel-default">
	<c:forEach items="${oanatifylist}" var="oanatifylist" varStatus="i">
		<div class="panel-heading">${i.index+1}、标题：${oanatifylist.title}</div>
		<div class="panel-body">
			<p><strong>内容：</strong>${oanatifylist.content}</p>
		</div>
	</c:forEach>
</div>
</body>
</html>