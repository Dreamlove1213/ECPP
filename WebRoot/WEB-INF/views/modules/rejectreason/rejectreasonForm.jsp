<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>目标驳回原因管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
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
	</script>
</head>
<body>
<%--	<ul class="nav nav-tabs">
		<li><a href="${ctx}/rejectreason/rejectreason/">目标驳回原因列表</a></li>
		<li class="active"><a href="${ctx}/rejectreason/rejectreason/form?id=${rejectreason.id}">目标驳回原因<shiro:hasPermission name="rejectreason:rejectreason:edit">${not empty rejectreason.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="rejectreason:rejectreason:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>--%>
	<form:form id="inputForm" modelAttribute="rejectreason" action="${ctx}/rejectreason/rejectreason/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="unit.id"/>
		<form:hidden path="unit.type"/>
		<sys:message content="${message}"/>
		<%--<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<form:input path="title" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label">驳回原因描述：</label>
			<div class="controls">
				<form:textarea id="description" htmlEscape="false" path="description" rows="2" maxlength="180" class="input-xxlarge required"/>
				<sys:ckeditor replace="description" uploadPath="/cms/article" height="150px" />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="rejectreason:rejectreason:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>