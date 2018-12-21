<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>信息管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
		$(document).ready(function() {
            //统计浏览量
            $.ajax({
                type : "post",
                url : "${ctx}/ecpp/information/ajaxCount",
                data : {
                    'id' :'${information.id}'
                },
                dataType : "json",
                success : function(msg) {
                    if(msg != undefined){
                        // $.jBox.alert("人员编码重复！");
                        //$(a).val("");
                    }
                },
            });
			
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

.file,.textContent {
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
		<%-- <li><a href="${ctx}/ecpp/information/list">信息列表</a></li> --%>
		<li class="active"><a onclick="javascript:Foo();return false;"
			href="#">查看信息</a></li>
	</ul>
	<div>
		<div class="textTitle">
			<h3>${information.informationtitle}</h3>
		</div>
		<div class="textf">
			<%-- <p>
				审核状态：${fns:getDictLabel(information.status, 'ecpp_info_status', '')}&nbsp;&nbsp;&nbsp;&nbsp;创建者：${information.user.name}
				&nbsp;&nbsp;创建时间：
				<fmt:formatDate value="${information.createDate}"
					pattern="yyyy-MM-dd" />
			</p> --%>
			<p>
				<font style="color:black;">创建者</font>：${information.unit.name} &nbsp;&nbsp;<font style="color:black;">创建时间：</font>
				<fmt:formatDate value="${information.createDate}"
					pattern="yyyy-MM-dd" />&nbsp;&nbsp;&nbsp;&nbsp;浏览量：${information.attribute3}
			</p>
		</div>
		<div class="textContent">${information.informationcontent}</div>
		<input type="hidden" id="attachment" value="${information.attachment}" />
		<c:if test="${!empty information.attachment}">
		<div class="file" id="fileBox">
			<font style="color:black !important;">附件：</font>
		</div>
		</c:if>
		<c:if test="${information.status == '2'}">
			<div class="file">
				<font style="color:black;">驳回原因：</font><p>${information.attribute1}</p>
			</div>
		</c:if>
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="javascript :history.back(-1);" />
		</div>
	</div>
</body>
</html>