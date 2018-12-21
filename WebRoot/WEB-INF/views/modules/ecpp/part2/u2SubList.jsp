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
		<li class="active"><a href="${ctx}/ecpp/planinformation/u2List">目标列表</a></li>
		<shiro:hasPermission name="ecpp:planin:edit"><li><a href="${ctx}/ecpp/planinformation/u2Form">新建目标</a></li></shiro:hasPermission>
		<%-- <li><a href="${ctx}/ecpp/planinformation/Analysis">统计分析</a></li> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/u2List" method="post" class="breadcrumb form-search">
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
				<th>创建时间</th>
				<th>备注</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="planinformation" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td class="alignCenter">
					${planinformation.unit.name}
				</td>
				<td class="alignCenter">
				<%-- <a href="${ctx}/ecpp/planinformation/view?id=${planinformation.id}"> --%>
					${planinformation.plantitle}
				<!-- </a> -->
				</td>
				<td class="alignCenter">
					${fns:getDictLabel(planinformation.plantype, 'ecpp_plan_type', '')}
				</td>
				<td class="alignCenter">
					${planinformation.planprincipal}
				</td>
				
				<td class="alignCenter">
					<fmt:formatDate value="${planinformation.createDate}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td>
					${planinformation.remarks}
				</td>
				<td class="alignCenter">
   				<a href="${ctx}/ecpp/planinformation/view?id=${planinformation.id}">查看</a>&nbsp;
				<shiro:hasPermission name="ecpp:planin:edit">
    				<a href="${ctx}/ecpp/planinformation/u2Form?id=${planinformation.id}">修改</a>&nbsp;
					<a href="${ctx}/ecpp/planinformation/delete?id=${planinformation.id}" onclick="return confirmx('确认要删除该目标改进项吗？', this.href)">删除</a>
				</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>