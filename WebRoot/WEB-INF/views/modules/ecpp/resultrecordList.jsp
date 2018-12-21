<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>提升情况信息及小组建议管理</title>
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
		<li class="active"><a href="${ctx}/ecpp/resultrecord/">提升情况信息及小组建议列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="resultrecord" action="${ctx}/ecpp/resultrecord/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>变更时间：</label>
				<input name="reschangedate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${resultrecord.reschangedate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>成果：</label>
				<form:input path="situationandresults" htmlEscape="false" maxlength="2048" class="input-medium"/>
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
				<th>单位名称</th>
				<th>成果情况变更时间</th>
				<th>提升情况及成果</th>
				<th>小组意见变更时间</th>
				<th>改革小组意见</th>
				<th>修改时间</th>
				<shiro:hasPermission name="ecpp:resultrecord:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="resultrecord" varStatus="i">
			<tr>
				<td>
					${i.index+1}
				</td>
				<td><a href="${ctx}/ecpp/resultrecord/form?id=${resultrecord.id}">
					${resultrecord.unit.name}
				</a></td>
				<td>
					<fmt:formatDate value="${resultrecord.reschangedate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${resultrecord.situationandresults}
				</td>
				<td>
					<fmt:formatDate value="${resultrecord.opinionchangedate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${resultrecord.opinion}
				</td>
				<td>
					<fmt:formatDate value="${resultrecord.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="ecpp:resultrecord:edit"><td>
    				<a href="${ctx}/ecpp/resultrecord/form?id=${resultrecord.id}">查看</a>
					<%-- <a href="${ctx}/ecpp/resultrecord/delete?id=${resultrecord.id}" onclick="return confirmx('确认要删除该提升情况信息及小组建议吗？', this.href)">删除</a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>