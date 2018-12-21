<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信息管理</title>
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
		function Foo() 
		{ 
			
		}
	</script>
	<style type="text/css">
	.form-horizontal .control-label {
	    float: left;
	    width: 100px;
	    padding-top: 5px;
	    text-align: right;
	}
	.form-horizontal .controls {
    	margin-left: 100px;
    	margin-right: 100px;
	}
	
	.changeMargin{margin-left:20px !important;}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">资讯发布</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="information" action="${ctx}/ecpp/information/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<div class="controls changeMargin">信息标题：</div>
			<div class="controls changeMargin">
				<form:input path="informationtitle" htmlEscape="false" maxlength="50" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<div class="controls changeMargin">信息内容：</div>
			<div class="controls changeMargin">	
				<form:textarea id="informationcontent" htmlEscape="false" path="informationcontent" rows="4" maxlength="200" class="input-xxlarge"/>
				<sys:ckeditor replace="informationcontent" uploadPath="/cms/article" />
				
			</div>
		</div>
		<div class="control-group">
			<div class="controls changeMargin">附件：</div>
			<div class="controls changeMargin">
				<form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="attachment" type="files" uploadPath="/ecpp/information" selectMultiple="true"/>
			</div>
		</div>
		<%-- <div class="control-group">
			<div class="controls changeMargin">备注：</div>
			<div class="controls changeMargin">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge "/>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="ecpp:information:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>