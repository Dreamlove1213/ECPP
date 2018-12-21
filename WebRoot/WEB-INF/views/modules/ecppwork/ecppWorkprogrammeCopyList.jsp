<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>查看工作计划管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
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
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">查看工作计划列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ecppWorkprogrammeCopy" action="${ctx}/ecppwork/ecppWorkprogrammeCopy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>工作计划标题</th>
				<th>单位</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ecppWorkprogrammeCopy" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td class="alignCenter">
					${ecppWorkprogrammeCopy.informationtitle}
				</td>
				<td class="alignCenter">
					${ecppWorkprogrammeCopy.unit.name}
				</td>
				<td class="alignCenter">
					<fmt:formatDate value="${ecppWorkprogrammeCopy.createDate}" pattern="yyyy-MM-dd HH:ss"/>
				</td>
				<td class="alignCenter">
    				<a href="${ctx}/ecppwork/ecppWorkprogrammeCopy/form?id=${ecppWorkprogrammeCopy.id}">查看</a>
    				<a href="${ctx}/ecppwork/ecppWorkprogrammeCopy/delete?id=${ecppWorkprogrammeCopy.id}" onclick="return confirmx('确认要删除该工作计划吗？', this.href)">删除</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>