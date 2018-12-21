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
					
					var patternhz = /[\u4e00-\u9fa5]/;
					var fzrnane=$("#fzrnane").val();			// 负责人姓名
					if(!patternhz.test(fzrnane)){
						alert("负责人姓名不正确，请重新输入！！！");
						return false;  
					}
					var fzrzhiwei=$("#fzrzhiwei").val();		// 负责人职位
					if(!patternhz.test(fzrzhiwei)){
						alert("负责人职位不正确，请重新输入！！！");
						return false;  
					}
					var llrnane1=$("#llrnane1").val();		// 联络人1姓名
					if(!patternhz.test(llrnane1)){
						alert("联络人1姓名不正确，请重新输入！！！");
						return false;  
					}
					var llrzhiwei1=$("#llrzhiwei1").val();		// 联络人1职位
					if(!patternhz.test(llrzhiwei1)){
						alert("联络人1职位不正确，请重新输入！！！");
						return false;  
					}
					var llrnane2=$("#llrnane2").val();		// 联络人2姓名
					if(llrnane2!=''){
						if(!patternhz.test(llrnane2)){
							alert("联络人2姓名不正确，请重新输入！！！");
							return false;  
						}
					}
					
					
					var llrzhiwei2=$("#llrzhiwei2").val();		// 联络人2职位
					if(llrzhiwei2!=''){
					if(!patternhz.test(llrzhiwei2)){
						alert("联络人2职位不正确，请重新输入！！！");
						return false;  
					}
					}
					var patternyx = /\w[-\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\.)+[A-Za-z]{2,14}/;
					var fzryouxiang=$("#fzryouxiang").val();	// 负责人邮箱
					if(!patternyx.test(fzryouxiang)){
						alert("负责人邮箱不正确，请重新输入！！！");
						return false;  
					}
					var llryouxiang1=$("#llryouxiang1").val();	// 联络人1邮箱
					if(!patternyx.test(llryouxiang1)){
						alert("联络人1邮箱不正确，请重新输入！！！");
						return false;  
					}
					var llryouxiang2=$("#llryouxiang2").val();	// 联络人2邮箱
					if(llryouxiang2!=''){
					if(!patternyx.test(llryouxiang2)){
						alert("联络人2邮箱不正确，请重新输入！！！");
						return false;  
					}
					}
					
					var patterndh = /[0-9-()（）]{7,18}/;
					var dh=$("#fzrdianhua").val();
					if(!patterndh.test(dh)){
						alert("负责人电话不正确，请重新输入！！！");
						return false;  
					}
					var dh1=$("#llrdianhua1").val();
					if(dh1!=''){
						if(!patterndh.test(dh1)){
							alert("联络人1电话不正确，请重新输入！！！");
							return false;  
						}
					}
					var dh2=$("#llrdianhua2").val();
					if(dh2!=''){
						if(!patterndh.test(dh2)){
							alert("联络人2电话不正确，请重新输入！！！");
							return false;  
						}
					}
					var patternsj = /[0-9-()（）]{7,18}/;
					var sj1=$("#llrshouji1").val();
					if(!patternsj.test(sj1)){
						alert("联络人1手机不正确，请重新输入！！！");
						return false;  
					}
					var sj2=$("#llrshouji2").val();
					if(sj!=''){
						if(!patternsj.test(sj2)){
							alert("联络人2手机不正确，请重新输入！！！");
							return false;  
						}
					}
					
					var stra=$("#statuss").val();
					if(stra=="0"){
						var gnl=confirm("确定要提交?");  
						if (gnl==true){
                            loadingTimeOut('正在提交，请稍等...',form);
						}else{  
							return false;  
						}  
					}else{
                        loadingTimeOut('正在保存，请稍等...',form);
					}
					
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
		<%-- <li><a href="${ctx}/zzjg/ecppStrformationCopy/">组织机构列表</a></li> --%>
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">通讯录<shiro:hasPermission name="zzjg:ecppStrformationCopy:edit">${not empty ecppStrformationCopy.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="zzjg:ecppStrformationCopy:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ecppStrformationCopy" action="${ctx}/zzjg/ecppStrformationCopy/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="statuss" path="statuss"/>
		<sys:message content="${message}"/>	
		<div class="control-group">
			<label class="control-label1">负责人：</label>
		</div>	
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<form:input path="fzrnane" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				<form:input path="fzrzhiwei" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				<form:input path="fzrdianhua" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				<form:input path="fzryouxiang" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label1">联络人1：</label>
			
		</div>	
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<form:input path="llrnane1" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">OA账号：</label>
			<div class="controls">
				<form:input path="oaaccount1" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				<form:input path="llrbumen1" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				<form:input path="llrzhiwei1" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				<form:input path="llrdianhua1" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机：</label>
			<div class="controls">
				<form:input path="llrshouji1" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				<form:input path="llryouxiang1" htmlEscape="false" maxlength="255" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label1">联络人2：</label>
		</div>	
		<div class="control-group">
			<label class="control-label">姓名：</label>
			<div class="controls">
				<form:input path="llrnane2" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">OA账号：</label>
			<div class="controls">
				<form:input path="oaaccount2" htmlEscape="false" maxlength="255" class="input-xlarge"/>
				<!-- <span class="help-inline"><font color="red">*</font> </span> -->
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">部门：</label>
			<div class="controls">
				<form:input path="llrbumen2" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				<form:input path="llrzhiwei2" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				<form:input path="llrdianhua2" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">手机：</label>
			<div class="controls">
				<form:input path="llrshouji2" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				<form:input path="llryouxiang2" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
	<%-- 	<div class="control-group">
			<label class="control-label">所属板块：</label>
			<div class="controls">
				<form:select path="remarks" class="input-xlarge ">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('belong_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge "/>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="zzjg:ecppStrformationCopy:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交" onclick="$('#statuss').val('0')"/>&nbsp;<input id="btnSubmit" class="btn btn-primary" type="submit" value="保存" onclick="$('#statuss').val('3')"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>