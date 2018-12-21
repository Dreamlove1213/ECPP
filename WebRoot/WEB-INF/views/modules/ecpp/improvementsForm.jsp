<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>进度记录管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:">改进项信息</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="improvements" action="${ctx}/ecpp/progressrecord/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">标题：</label>
			<div class="controls">
				<p class="con">${improvements.improvedtitle}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">权重：</label>
			<div class="controls">
				<p class="con">${improvements.weight}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">责任人：</label>
			<div class="controls">
				<p class="con">${improvements.principal}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">改进项进度：</label>
			<div class="controls">
				<c:choose>
					<c:when test = "${empty planinformation.plannedprogress}">
						<p class="con">0%</p>
					</c:when>
					<c:otherwise>
						<p class="con">${planinformation.plannedprogress}%</p>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">改进项内容：</label>
			<div class="controls">
				<p class="con">${improvements.content}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">完成时间：</label>
			<div class="controls">
				<p class="con"><fmt:formatDate value="${improvements.finishtime}" pattern="yyyy年 MM月 dd日  HH时:mm分"/></p>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<p class="con">${improvements.remarks}</p>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="ecpp:progressrecord:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>