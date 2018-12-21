<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>统计管理</title>
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
		<li class="active"><a href="${ctx}/ecpp/statistics/">统计列表</a></li>
		<shiro:hasPermission name="ecpp:statistics:edit"><li><a href="${ctx}/ecpp/statistics/form">统计添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="statistics" action="${ctx}/ecpp/statistics/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>计划信息ID：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>公司名称：</label>
				<form:input path="officename" htmlEscape="false" maxlength="256" class="input-medium"/>
			</li>
			<li><label>公司类型：</label>
				<form:input path="officetype" htmlEscape="false" maxlength="1" class="input-medium"/>
			</li>
			<li><label>计划类型：</label>
				<form:input path="plantype" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>目标进度：</label>
				<form:input path="muprogress" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>负责人：</label>
				<form:input path="sjprogress" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>目标数量：</label>
				<form:input path="munum" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li><label>改进项数量：</label>
				<form:input path="gjxnum" htmlEscape="false" maxlength="10" class="input-medium"/>
			</li>
			<li><label>扩展字段3：</label>
				<form:input path="attribute3" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>扩展字段4：</label>
				<form:input path="attribute4" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>扩展字段5：</label>
				<form:input path="attribute5" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>扩展字段6：</label>
				<form:input path="attribute6" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>单位：</label>
				<form:input path="unit" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>创建者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${statistics.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>修改者：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>修改时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${statistics.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>删除标识：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>修改时间</th>
				<th>备注</th>
				<shiro:hasPermission name="ecpp:statistics:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="statistics">
			<tr>
				<td><a href="${ctx}/ecpp/statistics/form?id=${statistics.id}">
					<fmt:formatDate value="${statistics.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</a></td>
				<td>
					${statistics.remarks}
				</td>
				<shiro:hasPermission name="ecpp:statistics:edit"><td>
    				<a href="${ctx}/ecpp/statistics/form?id=${statistics.id}">修改</a>
					<a href="${ctx}/ecpp/statistics/delete?id=${statistics.id}" onclick="return confirmx('确认要删除该统计吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>