<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>管理提升控制信息管理</title>
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
		<li class="active"><a href="${ctx}/config/ecppConfig/">管理提升控制信息列表</a></li>
		<shiro:hasPermission name="config:ecppConfig:edit"><li><a href="${ctx}/config/ecppConfig/form">管理提升控制信息添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ecppConfig" action="${ctx}/config/ecppConfig/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>名称：</label>
				<form:input path="name" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li><label>是否当前执行活动：</label>
				<form:select path="iscurrentactivity" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>活动是否开启：</label>
				<form:select path="isstart" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('yes_no')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>名称</th>
				<th>是否当前执行活动</th>
				<th>第一阶段名称</th>
				<th>第二阶段名称</th>
				<th>修改时间</th>
				<th>备注</th>
				<shiro:hasPermission name="config:ecppConfig:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ecppConfig">
			<tr>
				<td><a href="${ctx}/config/ecppConfig/form?id=${ecppConfig.id}">
					${ecppConfig.name}
				</a></td>
				<td>
					${fns:getDictLabel(ecppConfig.iscurrentactivity, 'yes_no', '')}
				</td>
				<td>
					${ecppConfig.firstname}
				</td>
				<td>
					${ecppConfig.secondname}
				</td>
				<td>
					<fmt:formatDate value="${ecppConfig.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${ecppConfig.remarks}
				</td>
				<shiro:hasPermission name="config:ecppConfig:edit"><td>
    				<a href="${ctx}/config/ecppConfig/form?id=${ecppConfig.id}">修改</a>
					<a href="${ctx}/config/ecppConfig/delete?id=${ecppConfig.id}" onclick="return confirmx('确认要删除该管理提升控制信息吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>