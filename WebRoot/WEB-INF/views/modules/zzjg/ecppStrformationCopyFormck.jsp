<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>组织机构管理</title>
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
	</script>
	<style type="text/css">
	.form-horizontal .form-actionssss {
	    padding-left: 15px;
	}
	.form-horizontal .control-label1 {
	    float: left;
	    width: 100px;
	    padding-top: 5px;
	    text-align: right;
	}
	.control-label1,.control-label{color:black !important;}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">通讯录查看</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ecppStrformationCopy" action="${ctx}/zzjg/ecppStrformationCopy/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>	
		<div class="form-actionssss">
			
		</div>
		<div class="control-group">
			<label class="control-label1"><a href="${ctx}/zzjg/ecppStrformationCopy/formck?id=${ecppStrformationCopy.id}">编辑&nbsp;&nbsp;&nbsp;&nbsp;</a></label>
		</div>	
		<div class="control-group">
			<label class="control-label1">负责人1：</label>
		</div>	
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				${ecppStrformationCopy.fzrnane}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				${ecppStrformationCopy.fzrzhiwei}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				${ecppStrformationCopy.fzrdianhua}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				${ecppStrformationCopy.fzryouxiang}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label1">联络人1：</label>
		</div>	
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				${ecppStrformationCopy.llrnane1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">OA账号：</label>
			<div class="controls">
				${ecppStrformationCopy.oaaccount1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				${ecppStrformationCopy.llrbumen1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				${ecppStrformationCopy.llrzhiwei1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				${ecppStrformationCopy.llrdianhua1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机：</label>
			<div class="controls">
				${ecppStrformationCopy.llrshouji1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				${ecppStrformationCopy.llryouxiang1}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label1">联络人2：</label>
			
		</div>	
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				${ecppStrformationCopy.llrnane2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">OA账号：</label>
			<div class="controls">
				${ecppStrformationCopy.oaaccount2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				${ecppStrformationCopy.llrbumen2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				${ecppStrformationCopy.llrzhiwei2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				${ecppStrformationCopy.llrdianhua2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机：</label>
			<div class="controls">
				${ecppStrformationCopy.llrshouji2}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				${ecppStrformationCopy.llryouxiang2}
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				${ecppStrformationCopy.remarks}
			</div>
		</div>
		<div class="form-actions">
		</div>
	</form:form>
</body>
</html>