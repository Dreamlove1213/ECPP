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
		</ul>
	<form:form id="searchForm" modelAttribute="ecppStrformationCopyCopy" action="${ctx}/zzjg/ecppStrformationCopyCopy/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>单位</th>
				<th>提交时间</th>
				<!-- <th>备注</th> -->
				<shiro:hasPermission name="zzjg:ecppStrformationCopyCopy:view"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="ecppStrformationCopyCopy" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td class="alignCenter"><a href="${ctx}/zzjg/ecppStrformationCopyCopy/form?id=${ecppStrformationCopyCopy.id}">
					${ecppStrformationCopyCopy.unit.name}
				</a></td>
				<td class="alignCenter">
					<fmt:formatDate value="${ecppStrformationCopyCopy.createDate}" pattern="yyyy-MM-dd"/>
				</td>
				<%-- <td class="alignCenter">
					${ecppStrformationCopyCopy.remarks}
				</td> --%>
				<td class="alignCenter">
    				<a href="${ctx}/zzjg/ecppStrformationCopyCopy/form?id=${ecppStrformationCopyCopy.id}">查看</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>