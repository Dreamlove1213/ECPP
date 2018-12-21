<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信息管理</title>
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
		<li class="active"><a onclick="javascript:void(0)" href="#">归档列表</a></li>
	</ul>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="50" style="text-align:center">环节</th>
				<th>标题</th>
<%--			<!-- <th>归属部门/企业</th> -->
				<th>信息审核状态</th>
				<th>创建者</th>
				<th>创建时间</th>
				<shiro:hasPermission name="ecpp:information:edit"><th>操作</th></shiro:hasPermission>--%>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${ecppWorkprogrammeCompany}" var="ecppWorkprogrammeCompany" varStatus="k" end="1">
			<tr>
				<td style="text-align:center">
					第一环节
				</td>
				<td>
					<a href="${ctx}/ecpp/planinformation/a3ListWorkPlan?unit.id=${ecppWorkprogrammeCompany.unit.id}">[${ecppWorkprogrammeCompany.unit.name}][工作计划]</a>
				</td>
			</tr>
		</c:forEach>

		<c:forEach items="${list4}" var="list4">
			<tr>
				<td style="text-align:center;white-space: nowrap;">
					<c:choose>
						<c:when test="${list4.segment =='二'}">
							第${list4.segment}环节
						</c:when>
						<c:when test="${list4.segment =='三'}">
							第${list4.segment}环节
						</c:when>
						<c:when test="${list4.segment =='四'}">
							第${list4.segment}环节
						</c:when>
					</c:choose>
				</td>
				<td>
					<c:choose>
						<c:when test="${list4.segment =='二'}">
							<a href="${ctx}/ecpp/planinformation/a2List2?unit.id=${list4.unit.id}&unit.type=${list4.unit.type}">[${list4.unit.remarks}][问题目标和措施]</a>
						</c:when>
						<c:when test="${list4.segment =='三'}">
							<a href="${ctx}/ecpp/planinformation/a3List2?unit.id=${list4.unit.id}&unit.type=${list4.unit.type}">[${list4.unit.remarks}][问题目标和措施]</a>
						</c:when>
						<c:when test="${list4.segment =='四'}">
							<a href="${ctx}/ecpp/planinformation/a4List2?unit.id=${list4.unit.id}&unit.type=${list4.unit.type}">[${list4.unit.remarks}][问题目标和措施]</a>
						</c:when>
					</c:choose>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>