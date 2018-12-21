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
		<li class="active"><a href="${ctx}/ecpp/planinformation/a2ListWorkPlan?unit.id=${officeId}">工作计划列表</a></li>
		<li><a href="${ctx}/ecpp/planinformation/a2List2?unit.id=${ecppWorkprogramme.unit.id}&unit.type=${ecppWorkprogramme.unit.type}">目标列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="ecppWorkprogramme" action="${ctx}/ecppwork/ecppWorkprogramme/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>标题：</label>
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
				<th>工作计划标题</th>
				<th>创建者</th>
				<th>单位</th>
				<th>创建时间</th>
				<shiro:hasPermission name="ecppwork:ecppWorkprogramme:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ecppWorkprogramme" varStatus="i">
			<tr>
				<td style="text-align:center;vertical-align:middle;">
					${i.index+1}
				</td>
				<td><a href="${ctx}/ecppwork/ecppWorkprogramme/form?id=${ecppWorkprogramme.id}">
					${ecppWorkprogramme.informationtitle}
				</a></td>
				
				<td style="text-align:center;vertical-align:middle;">
					${ecppWorkprogramme.user.name}
				</td>
				<td style="text-align:center;vertical-align:middle;">
					${ecppWorkprogramme.unit.name}
				</td>
				<td style="text-align:center;vertical-align:middle;">
					<fmt:formatDate value="${ecppWorkprogramme.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<shiro:hasPermission name="ecppwork:ecppWorkprogramme:edit"><td style="text-align:center;vertical-align:middle;">
    				<a href="${ctx}/ecppwork/ecppWorkprogramme/form?id=${ecppWorkprogramme.id}">查 看</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>