<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>目标驳回原因管理</title>
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
		<li class="active"><a href="${ctx}/rejectreason/rejectreason/">目标驳回原因列表</a></li>
		<shiro:hasPermission name="rejectreason:rejectreason:edit"><li><a href="${ctx}/rejectreason/rejectreason/form">目标驳回原因添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="rejectreason" action="${ctx}/rejectreason/rejectreason/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>计划信息ID：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>驳回原因描述：</label>
				<form:input path="description" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>审核状态：</label>
				<form:input path="shstatus" htmlEscape="false" maxlength="32" class="input-medium"/>
			</li>
			<li><label>扩展字段1：</label>
				<form:input path="attribute1" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>扩展字段2：</label>
				<form:input path="attribute2" htmlEscape="false" class="input-medium"/>
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
			<li><label>单位：</label>
				<form:input path="unit" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>创建者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${rejectreason.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>修改者：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>修改时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${rejectreason.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>删除标识：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>del_date：</label>
				<input name="delDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${rejectreason.delDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="1024" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>标题</th>
				<th>修改时间</th>
				<th>备注</th>
				<shiro:hasPermission name="rejectreason:rejectreason:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="rejectreason">
			<tr>
				<td><a href="${ctx}/rejectreason/rejectreason/form?id=${rejectreason.id}">
					${rejectreason.title}
				</a></td>
				<td>
					<fmt:formatDate value="${rejectreason.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${rejectreason.remarks}
				</td>
				<shiro:hasPermission name="rejectreason:rejectreason:edit"><td>
    				<a href="${ctx}/rejectreason/rejectreason/form?id=${rejectreason.id}">修改</a>
					<a href="${ctx}/rejectreason/rejectreason/delete?id=${rejectreason.id}" onclick="return confirmx('确认要删除该目标驳回原因吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>