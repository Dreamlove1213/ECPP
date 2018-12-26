<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(document).ready(function() {});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/office/list?id=${office.id}&parentIds=${office.parentIds}">机构列表</a></li>
		<shiro:hasPermission name="sys:office:edit"><li><a href="${ctx}/sys/office/form?parent.id=${office.id}">机构添加</a></li></shiro:hasPermission>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>机构名称</th><th>归属区域</th><th>机构编码</th><th>机构类型</th><th>备注</th><shiro:hasPermission name="sys:office:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody>
		<c:forEach items="${list}" var="office">
			<tr>
				<td><a href="${ctx}/sys/office/form?id={{row1.id}}">${office.name}</a></td>
				<td>${office.area.name}</td>
				<td>${office.code}</td>
				<td>${office.type}</td>
				<td>${office.remarks}</td>
				<shiro:hasPermission name="sys:office:edit"><td>
					<a href="${ctx}/sys/office/form?id=${office.id}">修改</a>
					<a href="${ctx}/sys/office/delete?id=${office.id}" onclick="return confirmx('要删除该机构及所有子机构项吗？', this.href)">删除</a>
					<a href="${ctx}/sys/office/form?parent.id=${office.id}">添加下级机构</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
</body>
</html>