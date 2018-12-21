<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>进度记录管理</title>
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
		<li class="active"><a href="${ctx}/ecpp/progressrecord/">进度记录列表</a></li>
		<shiro:hasPermission name="ecpp:progressrecord:edit"><li><a href="${ctx}/ecpp/progressrecord/form">进度记录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="progressrecord" action="${ctx}/ecpp/progressrecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>改进项进度：</label>
				<form:input path="progress" htmlEscape="false" class="input-medium"/>
			</li>
			<li><label>变更时间：</label>
				<input name="changedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${progressrecord.changedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>扩展字段1：</label>
				<form:input path="attribute1" htmlEscape="false" maxlength="1024" class="input-medium"/>
			</li>
			<li><label>扩展字段2：</label>
				<form:input path="attribute2" htmlEscape="false" maxlength="1024" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>改进项进度</th>
				<th>变更时间</th>
				<th>扩展字段1</th>
				<th>创建者</th>
				<th>修改时间</th>
				<th>备注</th>
				<shiro:hasPermission name="ecpp:progressrecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="progressrecord">
			<tr>
				<td><a href="${ctx}/ecpp/progressrecord/form?id=${progressrecord.id}">
					${progressrecord.progress}
				</a></td>
				<td>
					<fmt:formatDate value="${progressrecord.changedate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${progressrecord.attribute1}
				</td>
				<td>
					${progressrecord.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${progressrecord.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${progressrecord.remarks}
				</td>
				<shiro:hasPermission name="ecpp:progressrecord:edit"><td>
    				<a href="${ctx}/ecpp/progressrecord/form?id=${progressrecord.id}">修改</a>
					<a href="${ctx}/ecpp/progressrecord/delete?id=${progressrecord.id}" onclick="return confirmx('确认要删除该进度记录吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>