<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工作动态管理</title>
	<meta name="decorator" content="default"/>
<%-- 	<link href="${ctxStatic}/indexStyle/css/font-awesome.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/ionicons.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/perfect-scrollbar.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/rickshaw.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctxStatic}/indexStyle/css/starlight.css">
	<link rel="stylesheet" href="${ctxStatic}/indexStyle/css/bootstrap.min.css">
	<script src="${ctxStatic}/indexStyle/jquery.min.js"></script>
	<script src="${ctxStatic}/indexStyle/bootstrap.min.js"></script> --%>
	<script src="${ctxStatic}/common/clearBoxRight.js" type="text/javascript"></script>
	
	<!-- 文件上传插件 -->
	<%-- <link href="${ctxStatic}/common/iconfont.css" rel="stylesheet" type="text/css"/>
    <link href="${ctxStatic}/common/fileUpload.css" rel="stylesheet" type="text/css">
    <script src="${ctxStatic}/common/fileUpload.js" type="text/javascript"></script>
	<script src="${ctxStatic}/common/iconfont.js" type="text/javascript"></script> --%>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var stra=$("#status").val();
					if(stra=="1"){
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
			})
			
			
			
			//------------------------------文件上传插件
			//初始化
			<%-- $("#fileUploadArea").initUpload({
		        "uploadUrl":"/a/ecpp/information/fileUpload",//上传文件信息地址
		        "progressUrl":"#",//获取进度信息地址，可选，注意需要返回的data格式如下（{bytesRead: 102516060, contentLength: 102516060, items: 1, percent: 100, startTime: 1489223136317, useTime: 2767}）
		        "selfUploadBtId":"selfUploadBt",//自定义文件上传按钮id
		        "isHiddenUploadBt":false,//是否隐藏上传按钮
		        "isHiddenCleanBt":false,//是否隐藏清除按钮
		        "isAutoClean":false,//是否上传完成后自动清除
		        "velocity":10,//进度上传数据
		        "autoCommit":false,
		        //"rememberUpload":true,//记住文件上传
		       // "showFileItemProgress":false,
		        //"showSummerProgress":false,//总进度条，默认限制
		        //"scheduleStandard":true,//模拟进度的方式，设置为true是按总进度，用于控制上传时间，如果设置为false,按照文件数据的总量,默认为false
		        //"size":350,//文件大小限制，单位kb,默认不限制
		        //"maxFileNumber":3,//文件个数限制，为整数
		        //"filelSavePath":"",//文件上传地址，后台设置的根目录
		        //"beforeUpload":beforeUploadFun,//在上传前执行的函数
		        "onUpload":onUploadFun,//在上传后执行的函数
		         //autoCommit:true,//文件是否自动上传
		        //"fileType":['png','jpg','docx','doc']，//文件类型限制，默认不限制，注意写的是文件后缀
		    });
		});
		
		function beforeUploadFun(opt){
	        opt.otherData =[{"name":"你要上传的参数","value":"你要上传的值"}];
	    }
	    function onUploadFun(opt,data){
	       	//alert(data);
	       	//console.log("sdfsfsf");
	       	$("#filepath").val(data);
	        uploadTools.uploadError(opt);//显示上传错误
	    }
	    function testUpload(){
	        var opt = uploadTools.getOpt("fileUploadArea");
	        uploadEvent.uploadFileEvent(opt);
	    }
	    function tt() {
	        var opt = uploadTools.getOpt("fileUploadArea");
	        uploadTools.uploadError(opt);//显示上传错误
	    }
	    //多文件需要自己进行循环
	    function deleteFileByMySelf(fileId){
	        alert("要删除文件了："+fileId);
	    }--%>

	</script>
	<style type="text/css">
	.changeMargin{margin-left:20px !important;}
	</style>
</head>
<body>
 <div id="ulContent">
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/gzdt/ecppInformationCopy/list">工作动态列表</a></li>
		<li class="active"><a href="javascript:;" data-toggle="tab">工作动态${!empty ecppInformationCopy.id ? '修改':'发布'}</a></li>
	</ul>
</div>
	<form:form id="inputForm" modelAttribute="ecppInformationCopy" action="${ctx}/gzdt/ecppInformationCopy/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="status" path="status"/>
		<sys:message content="${message}"/>	<br/>	
		<div class="control-group">
			<label class="control-label">信息标题：</label>
			<div class="controls">
				<form:input path="informationtitle" htmlEscape="false" maxlength="50" style="width:50%;" class="input-xlarge required" required="required"/>
			</div>
		</div>
		<div class="control-group" style="width:750px">
			<label class="control-label">信息内容：</label>
			<div class="controls changeMargin">
				<form:textarea id="informationcontent" htmlEscape="false" path="informationcontent" rows="4" maxlength="100" class="input-xxlarge"/>
				<sys:ckeditor replace="informationcontent" uploadPath="/cms/article" />
			</div>
		</div>
		
 		<div class="control-group">
			<div class="controls changeMargin">附件：</div>
			<div class="controls changeMargin">
				<form:hidden id="attachment" path="attachment" htmlEscape="false" maxlength="2000" class="input-xlarge"/>
				<sys:ckfinder input="attachment" type="files" uploadPath="/gzdt/ecppInformationCopy" selectMultiple="true"/>
			</div>
		</div> 
		
		
		<%--<div class="control-group">
			<input type="hidden" name="attachment" id="filepath" value="" />
			<!-- <label class="control-label">附件：</label> -->
			<div class="controls changeMargin">
				文件上传区域
			</div>
			<div class="controls changeMargin">
				<div id="fileUploadArea" class="fileUploadArea"></div>
			</div>
		</div>--%>
		
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="发 布" onclick="$('#status').val('1')"/>&nbsp;
			<input id="" class="btn btn-primary" type="submit" value="保存" onclick="$('#status').val('0')"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>