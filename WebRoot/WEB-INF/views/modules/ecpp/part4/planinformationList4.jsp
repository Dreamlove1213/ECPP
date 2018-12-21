<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>目标改进项管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $("#inputForm").validate({
                submitHandler: function(form){
                    loadingTimeOut('正在提交，请稍等...',form);
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
	<style type="text/css">
		.btn.btn-success{display: none;}
		.btn.btn-warning{display: none;}
		#attachementPreview,ol{margin-bottom: 0 !important;}
		#attachementPreview li a:last-child{display: none;}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecpp/planinformation/a4ListWorkPlan?unit.id=${planinformation.unit.id}&unit.type=${planinformation.unit.type}">工作计划列表</a></li>
		<li class="active"><a href="${ctx}/ecpp/planinformation/a4List2?unit.id=${planinformation.unit.id}&unit.type=${planinformation.unit.type}">目标列表</a></li>
		<%-- <shiro:hasPermission name="ecpp:planinformation:edit">
		<li><a href="${ctx}/ecpp/planinformation/planForm">执行目标</a></li>
		</shiro:hasPermission> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/u4List" method="post" class="">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="50" style="text-align:center">序号</th>
				<th>归属部门</th>
				<th>目标标题</th>
				<th>目标类型</th>
				<th>负责人</th>
				<th>目标进度</th>
				<th>总分</th>
				<th>平均分</th>
				<th>创建时间</th>
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
				<td>
					${planinformation.unit.name}
				</td>
				<td>
					${planinformation.plantitle}
				</td>
				<td>
					${fns:getDictLabel(planinformation.plantype, 'ecpp_plan_type', '')}
				</td>
				<td>
					${planinformation.planprincipal}
				</td>
				<td>
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
				<td>
					${planinformation.selfevaluationscore}
				</td>
				<td>
					${planinformation.averagescore}
				</td>
				<td>
					<fmt:formatDate value="${planinformation.createDate}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<%-- <td>
					${planinformation.remarks}
				</td> --%>
				<shiro:hasPermission name="ecpp:planinformation:edit"><td>
    				<a href="${ctx}/ecpp/planinformation/u4View?id=${planinformation.id}">查看</a>&nbsp;
					<%-- <a href="${ctx}/ecpp/planinformation/delete?id=${planinformation.id}" onclick="return confirmx('确认要删除该目标改进项吗？', this.href)">删除</a> --%>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<c:if test="${fns:getUser().name !='游客'}">
	<form:form id="inputForm" modelAttribute="selfevluate" action="${ctx}/selfevluate/selfevluate/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">自评报告：</label>
			<div class="controls">
				<form:hidden id="attachement" path="attachement" htmlEscape="false" class="input-xlarge"/>
				<sys:ckfinder input="attachement" type="files" uploadPath="/selfevluate/selfevluate" selectMultiple="true"/>
			</div>
		</div>
	</form:form>
	</c:if>
	<div class="pagination">${page}</div>
</body>
</html>