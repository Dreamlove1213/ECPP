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
            url : "${ctx}/gzdt/ecppInformationCopy/ajaxCount",
            data : {
                'id' :'${ecppInformationCopy.id}'
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
			$("#fileBox").append("<p style='padding-left:35px;line-height:16px;'><a href='"+decodeURIComponent(string[i])+"' download='"+decodeURIComponent(string[i])+"'>"+fileName[i]+"</a></p>");
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

		<li class="active"><a onclick="javascript:Foo();return false;" href="#">工作动态查看</a></li>

	</ul><br/>
	<div>
		<div class="textTitle">
			<h3>${ecppInformationCopy.informationtitle}</h3>
		</div>
		<div class="textf">
			<p>
				创建者：${ecppInformationCopy.user.name}&nbsp;&nbsp;&nbsp;&nbsp;创建时间：
				<fmt:formatDate value="${ecppInformationCopy.createDate}"
					pattern="yyyy-MM-dd" />&nbsp;&nbsp;&nbsp;&nbsp;浏览量：${ecppInformationCopy.attribute4}
			</p>
		</div>
		<div class="textContent">${ecppInformationCopy.informationcontent}</div>
		<input type="hidden" id="attachment" value="${ecppInformationCopy.attachment}" />
		<c:if test="${!empty ecppInformationCopy.attachment}">
		<div class="file" id="fileBox">
			附件：
		</div>
		</c:if>
		<div class="checkInfoStatus">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</div>
</body>
</html>