<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作计划管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
/* 			var attachment = $("#attachment").val();
			var string = new Array();
			var fileName = new Array();
			string = attachment.split("|");
			for(var i=0; i<string.length; i++){
				fileName[i] = decodeURIComponent(string[i].substring(string[i].lastIndexOf("/")+1));
				$("#fileBox").append("<p style='padding-left:35px;line-height:16px;'><a href='/"+string[i]+"'  download=\""+ fileName[i] +"\">"+fileName[i]+"</a></p>");
				console.log(fileName[i]);
			} */
			
			var attachment = $("#attachment").val();
			var string = new Array()
			var fileName = new Array()
			string = attachment.split("|");
			for(var i=1; i<string.length; i++){
				fileName[i] = decodeURIComponent(string[i].substring(string[i].lastIndexOf("/")+1));
				$("#fileBox").append("<p style='padding-left:35px;line-height:16px;'><a href='"+string[i]+"' download='"+string[i]+"'>"+fileName[i]+"</a></p>");
			}
			
		});
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
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">工作计划查看 </a></li>
	</ul><br/>
	<sys:message content="${message}"/>
	
	<div>
		<div class="textTitle">
			<h3>${ecppWorkprogramme.informationtitle}</h3>
		</div>
		<input type="hidden" id="attachment" value="${ecppWorkprogramme.attachment}" />
		<c:if test = "${!empty ecppWorkprogramme.attachment}">
		<div class="file" id="fileBox">
			<font style="color:black !important;">附件：</font>
		</div>
		</c:if>
	</div>
	<div class="form-actions">
		<c:if test="${ecppWorkprogramme.status == '0'}">
			<input class="btn btn-primary" type="button" value="提 交" onclick="location.href='${ctx}/ecppwork/ecppWorkprogramme/tijiao?id=${ecppWorkprogramme.id}'"/>
			<input class="btn btn-primary" type="button" value="编 辑" onclick="location.href='${ctx}/ecppwork/ecppWorkprogramme/formforedit?id=${ecppWorkprogramme.id}'"/>
		</c:if>
	</div>
</body>
</html>