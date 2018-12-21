<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>组织机构管理</title>
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
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">通讯录列表</a></li>
		<shiro:hasPermission name="zzjg:ecppStrformationCopy:edit"><li><a href="${ctx}/zzjg/ecppStrformationCopy/form">通讯录添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="ecppStrformationCopy" action="${ctx}/zzjg/ecppStrformationCopy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>负责人姓名</th>
				<th>职位</th>
				<th>电话</th>
				<th>邮箱</th>
				<th>创建时间</th>
				<shiro:hasPermission name="zzjg:ecppStrformationCopy:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ecppStrformationCopy" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td><a href="${ctx}/zzjg/ecppStrformationCopy/form?id=${ecppStrformationCopy.id}">
					${ecppStrformationCopy.fzrnane}
				</a></td>
				<td>
					${ecppStrformationCopy.fzrzhiwei}
				</td>
				<td>
					${ecppStrformationCopy.fzrdianhua}
				</td>
				<td>
					${ecppStrformationCopy.fzryouxiang}
				</td>
				<td>
					<fmt:formatDate value="${ecppStrformationCopy.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<shiro:hasPermission name="zzjg:ecppStrformationCopy:edit"><td>
    				<a href="${ctx}/zzjg/ecppStrformationCopy/form?id=${ecppStrformationCopy.id}">修改</a>
					<a href="${ctx}/zzjg/ecppStrformationCopy/delete?id=${ecppStrformationCopy.id}" onclick="return confirmx('确认要删除该组织机构吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>