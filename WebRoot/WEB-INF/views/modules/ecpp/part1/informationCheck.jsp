<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>信息管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		var attachment = $("#attachment").val();
		var fileName = decodeURIComponent(attachment.substring(attachment.lastIndexOf("/")+1));
		var urlText = attachment.substring(1);
		console.log(urlText);
		$("#attachmentText").html(fileName);
		$("#attachmentText").attr("href",urlText);
		
		
		var attachment = $("#attachment").val();
		var string = new Array()
		var fileName = new Array()
		string = attachment.split("|");
		for(var i=1; i<string.length; i++){
			fileName[i] = decodeURIComponent(string[i].substring(string[i].lastIndexOf("/")+1));
			$("#fileBox").append("<p style='padding-left:35px;line-height:16px;'><a href='"+string[i]+"' download='"+string[i]+"'>"+fileName[i]+"</a></p>");
		}
		
		
	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
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
		<li><a href="${ctx}/ecpp/information/checkInfoList">信息列表</a></li>
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">查看信息</a></li>
	</ul>
	<div>
		<div class="textTitle">
			<h3>${information.informationtitle}</h3>
		</div>
		<div class="textf">
			<p>
				<font style="color:black;">审核状态：</font>${fns:getDictLabel(information.status, 'ecpp_info_status', '')}&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:black;">创建者：</font>${information.user.name}
				&nbsp;&nbsp;&nbsp;&nbsp;<font style="color:black;">创建时间：</font>
				<fmt:formatDate value="${information.createDate}"
					pattern="yyyy-MM-dd" />
			</p>
		</div>
		<div class="textContent">${information.informationcontent}</div>
		<div class="file">
		<c:if test="${!empty information.attachment}">	 
			<div class="file" id="fileBox">
				<font style="color:black !important;">附件：</font>
			</div>	
		</c:if>
			<input type="hidden" id="attachment" value="${information.attachment}" />
		</div>
		<c:choose>
			<c:when test="${information.status == '2'}">
				<div class="file">
					<font style="color:black;">驳回原因：</font>${information.attribute1}
				</div>
			</c:when>
			<c:when test="${information.status == '1'}">
			</c:when>
			<c:otherwise>
				<div class="file">
					<font style="color:black;">驳回原因：</font> <input type="text" id="bh" name="attribute1" placeholder="如果驳回，请填写" style="width:500px;" />
				</div>
			</c:otherwise>
		</c:choose>
		<div class="checkInfoStatus">
			<c:choose>
				<c:when test="${information.status eq '0'}">
				<font style="color:black;">审核：</font>
					<button class="btn btn-primary" onclick="pass('${information.id}')">通过</button>
					&nbsp;
					<button class="btn btn-danger" onclick="noPass('${information.id}')">驳回</button>
				</c:when>
				<c:otherwise>
					<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
				</c:otherwise>
			</c:choose>
		</div>

	</div>
	<script type="text/javascript">
		function noPass(e) {
			var reason = $("#bh").val();
			if(reason.length != 0){
				var status = confirm("确定要驳回此条上报信息吗?"); 
				if(status == true){
					var id = e;
					var bh =  $("#bh").val();
					$.ajax({
								type : "post",
								url : "${ctx}/ecpp/information/noPass",
								data : {
									'id' : id,
									'status' : '2',
									'attribute1':bh
								},
								dataType : "json",
								success : function(msg) {
	
									$.jBox.alert("操作完成！");
									if (msg == "1") {
										$.jBox.alert("操作完成！");
										window.location.href = "${ctx}/ecpp/information/checkInfoList";
									}
								},
								error : function(json) {
									$.jBox.alert("网络异常！");
								}
							});
				}
			}else{
				$.jBox.tip("请填写驳回原因！","warning",{persistent:false,opacity:0.5});
			}
		}
		function pass(e) {
			var status = confirm("确定要通过此条上报信息吗?"); 
			if(status == true){
				var id = e;
				$.ajax({
							type : "post",
							url : "${ctx}/ecpp/information/pass",
							data : {
								'id' : id,
								'status' : '1'
							},
							dataType : "json",
							success : function(msg) {
								$.jBox.alert("操作完成！");
								if (msg == "1") {
									$.jBox.alert("操作完成！");
									window.location.href = "${ctx}/ecpp/information/checkInfoList";
								}
							},
							error : function(json) {
								$.jBox.alert("网络异常！");
							}
						});
			}
			
		}
	</script>
</body>
</html>