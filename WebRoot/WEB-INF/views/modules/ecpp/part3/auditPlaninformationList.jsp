<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>目标改进项管理</title>
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
		<li class="active"><a href="${ctx}/ecpp/planinformation/a3List?unit.id=${planinformation.unit.id}&unit.type=${planinformation.unit.type}">目标列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/a3List?unit.id=${planinformation.unit.id}&unit.type=${planinformation.unit.type}" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>目标标题：</label>
				<form:input path="plantitle" htmlEscape="false" maxlength="50" class="input-medium"/>
			</li>
			<li><label>目标类型：</label>
				<form:select path="plantype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('ecpp_plan_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>负责人：</label>
				<form:input path="planprincipal" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="50" style="text-align:center">序号</th>
				<th>归属部门/企业</th>
				<th>目标标题</th>
				<th>目标类型</th>
				<th>负责人</th>
				<th>目标进度</th>
				<th>目标完成时间</th>
				<!-- <th>备注</th> -->
				<shiro:hasPermission name="ecpp:planinformation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="planinformation" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${planinformation.unit.name}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${planinformation.plantitle}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${fns:getDictLabel(planinformation.plantype, 'ecpp_plan_type', '')}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${planinformation.planprincipal}
				</td>
				<td class="alignCenter">
					<div class="progress clearMar">
						<c:choose>
							<c:when test = "${empty planinformation.plannedprogress}">
								<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 0%;">
							   		 0%
							  	</div>
							</c:when>
							<c:otherwise>
								<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${planinformation.plannedprogress}%;">
							   		 ${planinformation.plannedprogress}%
							  	</div>
							</c:otherwise>
						</c:choose>
					</div>
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					<fmt:formatDate value="${planinformation.endDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <td>
					${planinformation.remarks}
				</td> --%>
				<shiro:hasPermission name="ecpp:planinformation:edit"><td class="alignCenter" style="white-space: nowrap;">
    				<a href="${ctx}/ecpp/planinformation/a3View?id=${planinformation.id}">查看</a>&nbsp;
    				<c:if test="${!empty planinformation.situationandeffect}">
    				</c:if>
    				<c:if test="${fns:getUser().name !='游客'}">
    					<a href="${ctx}/ecpp/planinformation/a3Form?id=${planinformation.id}">目标跟踪</a>
    				</c:if>
					<%-- <a href="${ctx}/ecpp/planinformation/delete?id=${planinformation.id}" onclick="return confirmx('确认要删除该目标改进项吗？', this.href)">删除</a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>