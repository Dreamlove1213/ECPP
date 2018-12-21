<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建通讯录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $("#btnExport").click(function(){
                $.jBox.confirm("确认要导出通讯录数据吗？","系统提示",function(v,h,f){
                    if(v=="ok"){
                        $("#searchForm").attr("action","${ctx}/stion/strformation/export");
                        $("#searchForm").submit();
                    }
                },{buttonsFocus:1});
                $('.jbox-body .jbox-icon').css('top','55px');
            });
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
		<li class="active"><a href="${ctx}/stion/strformation/stionList">通讯录列表</a></li>
		<%--<shiro:hasPermission name="stion:strformation:edit"><li><a href="${ctx}/stion/strformation/form">新建通讯录添加</a></li></shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="strformation" action="${ctx}/stion/strformation/stionList" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<%-- <li><label>职位：</label>
				<form:input path="zhiwei" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>电话：</label>
				<form:input path="dianhua" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li> --%>
			<li><label>单位：</label>
				<sys:treeselect id="unit" name="unit.id" value="${strformation.unit.id}" labelName="unit.name" labelValue="${strformation.unit.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li class="btns">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
				<input id="btnExport" class="btn btn-primary" type="button" value="导出"/>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>序号</th>
				<th>单位</th>
				<th>负责人姓名</th>
				<th>职位</th>
				<th>电话</th>
				<th style="width:280px;">邮箱</th>
				<shiro:hasPermission name="stion:strformation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="strformation" varStatus="i">
			<tr>
				<td>
					${i.index+1}
				</td>
				<td><%-- <a href="${ctx}/stion/strformation/form?id=${strformation.id}"> --%>
					${strformation.unit.name}
				<!-- </a> --></td>
				<td>
					${strformation.name}
				</td>
				<td>
					${strformation.zhiwei}
				</td>
				<td>
					${strformation.dianhua}
				</td>
				<td>
					${strformation.youxiang}
				</td>
				<td>
					<a href="${ctx}/stion/strformation/formWriterOrShow?id=${strformation.id}&&todo=true">查看</a>&nbsp;&nbsp;
					<shiro:hasPermission name="delstioneors:strformation:view">
    				<c:if test="${fns:getUser().name !='游客'}">
						<a href="${ctx}/stion/strformation/delete?id=${strformation.id}" onclick="return confirmx('确认要删除该新建通讯录吗？', this.href)">删除</a>
					</c:if>
					</shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>