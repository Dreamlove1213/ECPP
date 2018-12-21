<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>自评报告管理</title>
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
		<li class="active"><a href="${ctx}/selfevluate/selfevluate/">自评报告列表</a></li>
		<shiro:hasPermission name="selfevluate:selfevluate:edit"><li><a href="${ctx}/selfevluate/selfevluate/form">自评报告添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="selfevluate" action="${ctx}/selfevluate/selfevluate/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>计划信息ID：</label>
				<form:input path="id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>标题：</label>
				<form:input path="title" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>自评报告：</label>
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
					value="<fmt:formatDate value="${selfevluate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>修改者：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>修改时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${selfevluate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>删除标识：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>del_date：</label>
				<input name="delDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${selfevluate.delDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
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
				<th>自评报告</th>
				<th>状态</th>
				<th>审核状态</th>
				<th>扩展字段1</th>
				<th>扩展字段2</th>
				<th>扩展字段3</th>
				<th>扩展字段4</th>
				<th>扩展字段5</th>
				<th>单位</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>修改者</th>
				<th>修改时间</th>
				<th>删除标识</th>
				<th>del_date</th>
				<th>备注</th>
				<shiro:hasPermission name="selfevluate:selfevluate:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="selfevluate">
			<tr>
				<td><a href="${ctx}/selfevluate/selfevluate/form?id=${selfevluate.id}">
					${selfevluate.title}
				</a></td>
				<td>
					${selfevluate.attachement}
				</td>
				<td>
					${selfevluate.status}
				</td>
				<td>
					${selfevluate.shstatus}
				</td>
				<td>
					${selfevluate.attribute1}
				</td>
				<td>
					${selfevluate.attribute2}
				</td>
				<td>
					${selfevluate.attribute3}
				</td>
				<td>
					${selfevluate.attribute4}
				</td>
				<td>
					${selfevluate.attribute5}
				</td>
				<td>
					${selfevluate.unit}
				</td>
				<td>
					${selfevluate.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${selfevluate.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${selfevluate.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${selfevluate.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(selfevluate.delFlag, 'del_flag', '')}
				</td>
				<td>
					<fmt:formatDate value="${selfevluate.delDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${selfevluate.remarks}
				</td>
				<shiro:hasPermission name="selfevluate:selfevluate:edit"><td>
    				<a href="${ctx}/selfevluate/selfevluate/form?id=${selfevluate.id}">修改</a>
					<a href="${ctx}/selfevluate/selfevluate/delete?id=${selfevluate.id}" onclick="return confirmx('确认要删除该自评报告吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>