<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>查看工作计划管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			/* var attachment = $("#attachment").val();
			var fileName = decodeURIComponent(attachment.substring(attachment.lastIndexOf("/")+1));
			var urlText = attachment.substring(1);
			console.log(urlText);
			$("#attachmentText").html(fileName);
			$("#attachmentText").attr("href",urlText); */
			
			
			var attachment = $("#attachment").val();
			var string = new Array()
			var fileName = new Array()
			string = attachment.split("|");
			for(var i=1; i<string.length; i++){
				fileName[i] = decodeURIComponent(string[i].substring(string[i].lastIndexOf("/")+1));
				$("#fileBox").append("<p style='padding-left:35px;line-height:16px;'><a href='"+string[i]+"'>"+fileName[i]+"</a></p>");
				console.log(fileName[i])
			}
			
		});
		function Foo() 
		{ 
			
		}
	</script>
	<style>
	.textTitle h3 {
		text-align: center;
		line-height: 40px;
		color: black;
	}
	
	.textContent {
		padding: 35px;
	}
	
	.checkInfoStatus,.file {
		padding: 35px;
	}
	
	.textf p {
		line-height: 30px;
	}
	
	.textf {
		text-align: center;
	}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecppwork/ecppWorkprogrammeCopy/list">查看工作计划列表</a></li>
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">查看工作计划</a></li>
	</ul><br/>
	
	<div>
		<div class="textTitle">
			<h3>${ecppWorkprogrammeCopy.informationtitle}</h3>
		</div>
		
		<%-- <div class="textContent">${ecppWorkprogrammeCopy.informationcontent}</div> --%>
		<input type="hidden" id="attachment" value="${ecppWorkprogrammeCopy.attachment}" />
		<%-- <div class="textContent">${ecppWorkprogramme.informationcontent}</div> --%>
		<div class="file" id="fileBox">
			附件：<%--  <a href="" id="attachmentText"></a>  --%>
		</div>
	</div>
	<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
	
	<%-- <form:form id="inputForm" modelAttribute="ecppWorkprogrammeCopy" action="${ctx}/ecppwork/ecppWorkprogrammeCopy/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">工作计划标题：</label>
			<div class="controls">
				${ecppWorkprogrammeCopy.informationtitle}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作计划内容：</label>
			<div class="controls">
				<form:textarea path="informationcontent" htmlEscape="false" rows="4" maxlength="2048" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">附件：</label>
			<div class="controls">
				<form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="200" class="input-xlarge"/>
				<sys:ckfinder input="attachment" type="files" uploadPath="/ecppwork/ecppWorkprogrammeCopy" selectMultiple="true"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">工作计划审核状态：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">扩展字段1：</label>
			<div class="controls">
				<form:input path="attribute1" htmlEscape="false" maxlength="1024" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">扩展字段2：</label>
			<div class="controls">
				<form:input path="attribute2" htmlEscape="false" maxlength="1024" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">扩展字段3：</label>
			<div class="controls">
				<form:input path="attribute3" htmlEscape="false" maxlength="1024" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">扩展字段4：</label>
			<div class="controls">
				<form:input path="attribute4" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单位：</label>
			<div class="controls">
				<form:input path="unit.id" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">del_date：</label>
			<div class="controls">
				<input name="delDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppWorkprogrammeCopy.delDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="ecppwork:ecppWorkprogrammeCopy:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form> --%>
</body>
</html>