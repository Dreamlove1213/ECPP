<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
		function Foo() 
		{ 
			
		}
	</script>
	<style>
		.textTitle h3{
			text-align:center;
			line-height:40px;
			color:black;
		}
		.checkInfoStatus,.file,.textContent{
			padding:20px;
		}
		.textf p{
			line-height:30px;
		}
		.textf{
			text-align:center;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecpp/information/list">信息列表</a></li>
		<li class="active"><a onclick="javascript:Foo();return false;" href="#">查看信息</a></li>
	</ul>
	
	<div>
		<div class="textTitle"><h3>${information.informationtitle}</h3></div>
		<div class="textf">
			<p>审核状态：${information.status}&nbsp;&nbsp;创建者：
			&nbsp;&nbsp;创建时间：<fmt:formatDate value="${information.createDate}" pattern="yyyy-MM-dd"/></p>
		</div>
		<div class="textContent">${information.informationcontent}</div>
		<div class="file">附件：</div>
		<div class="checkInfoStatus">
			审核：<a class="btn-default" onclick="pass()">通过</a><a class="btn-dange" onclick="noPass()">驳回</a>
		</div>
	
	</div>
	
</body>
</html>