<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作动态管理</title>
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
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">工作动态列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ecppInformationCopy" action="${ctx}/gzdt/ecppInformationCopy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>信息标题</th>
				<th>创建者</th>
				<th>创建时间</th>
				<c:if test="${isAllowDel == true}">
					<th>操作</th>
				</c:if>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ecppInformationCopy" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td><a href="${ctx}/gzdt/ecppInformationCopy/form1?id=${ecppInformationCopy.id}">
					${ecppInformationCopy.informationtitle}
				</a></td>
				<td style="text-align:center">
					${ecppInformationCopy.user.name}
				</td>
				<td style="text-align:center">
					<fmt:formatDate value="${ecppInformationCopy.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<c:if test="${isAllowDel == true}">
				<td style="text-align:center">
					<a href="${ctx}/gzdt/ecppInformationCopy/deleteecppinfo?id=${ecppInformationCopy.id}" onclick="return confirmx('确认要删除该工作动态吗？', this.href)">
						删除
					</a>
				</td>
				</c:if>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>