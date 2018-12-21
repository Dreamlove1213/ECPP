<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>组织机构管理</title>
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
	
	.form-horizontal .control-label1 {
	    float: left;
	    width: 100px;
	    padding-top: 5px;
	    text-align: right;
	}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/zzjg/ecppStrformationCopyCopy/list">通讯录列表</a></li>
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">通讯录<shiro:hasPermission name="zzjg:ecppStrformationCopyCopy:edit">${not empty ecppStrformationCopyCopy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="zzjg:ecppStrformationCopyCopy:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ecppStrformationCopyCopy" action="${ctx}/zzjg/ecppStrformationCopyCopy/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="control-group">
			<label class="control-label1">负责人：</label>
		</div>	
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.fzrnane}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.fzrzhiwei}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.fzrdianhua}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.fzryouxiang}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label1">联络人1：</label>
		</div>
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrnane1}
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">OA账号：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.oaaccount1}
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrbumen1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrzhiwei1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrdianhua1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrshouji1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llryouxiang1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label1">联络人2：</label>
		</div>
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrnane2}
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">OA账号：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.oaaccount2}
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrbumen2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrzhiwei2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrdianhua2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llrshouji2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.llryouxiang2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				${ecppStrformationCopyCopy.remarks}
			</div>
		</div>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>