<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作计划管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/office/officeList">机构列表</a></li>
		<%--<li><a href="${ctx}/ecpp/planinformation/a3List2">目标列表</a></li>--%>
	</ul>
	<form:form id="searchForm" modelAttribute="Office" action="${ctx}/sys/office/officePlan2List" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>机构名称</th>
				<th>目标/改进项数量</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="office" varStatus="i">
			<tr>
				<td style="text-align:center;vertical-align:middle;">
					${i.index+1}
				</td>
				<td>
					${office.remarks}
				</td>
				<td>
					${office.numUnit}/${office.numUnitgjx}
				</td>
				<td style="text-align:center;vertical-align:middle;">
    				<a href="${ctx}/ecpp/planinformation/a2List?unit.id=${office.id}&unit.type=${office.type}">查 看</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>