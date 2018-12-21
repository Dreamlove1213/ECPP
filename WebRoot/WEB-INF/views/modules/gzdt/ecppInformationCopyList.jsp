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
		<li class="active"><a onclick="javascript:Foo();return false;" href="#"">工作动态列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ecppInformationCopy" action="${ctx}/gzdt/ecppInformationCopy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>信息标题：</label>
				<form:input path="informationtitle" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>归属部门/企业</th>
				<th>信息标题</th>
				<th>状态</th>
				<th>创建者</th>
				<th>创建时间</th>
				<shiro:hasPermission name="gzdt:ecppInformationCopy:edit1"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ecppInformationCopy" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td style="text-align:center">
					${ecppInformationCopy.unit.name}
				</td>
				<td>
				<a href="${ctx}/gzdt/ecppInformationCopy/form1?id=${ecppInformationCopy.id}">
					${ecppInformationCopy.informationtitle}
				</a>
				</td>
				
				<td class="alignCenter">
					${fns:getDictLabel(ecppInformationCopy.status, 'oa_notify_status', '')}
				</td>
				
				<td class="alignCenter">
					${ecppInformationCopy.user.name}
				</td>
				<td class="alignCenter">
					<fmt:formatDate value="${ecppInformationCopy.createDate}" pattern="yyyy-MM-dd HH:ss"/>
				</td>
				<shiro:hasPermission name="gzdt:ecppInformationCopy:edit1"><td class="alignCenter">
    				<a href="${ctx}/gzdt/ecppInformationCopy/form?id=${ecppInformationCopy.id}">修改</a>
					<a href="${ctx}/gzdt/ecppInformationCopy/deleteVie?id=${ecppInformationCopy.id}" onclick="return confirmx('确认要删除该工作动态吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>