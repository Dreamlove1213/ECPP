<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>登录</title>
</head>
<script type="text/javascript">
	function post() {
		var PARAMS={username :'YOUKE',password:'123456'};
	    var temp = document.createElement("form");        
	    temp.action = "/a/login";        
	    temp.method = "post";        
	    temp.style.display = "none";        
	    for (var x in PARAMS) {        
	        var opt = document.createElement("textarea");        
	        opt.name = x;        
	        opt.value = PARAMS[x];        
	        temp.appendChild(opt);        
	    }        
	    document.body.appendChild(temp);        
	    temp.submit();        
	    return temp;        
	}  
</script>
<body onload="post()">
	<div>正在跳转。。。。。</div>
</body>
</html>