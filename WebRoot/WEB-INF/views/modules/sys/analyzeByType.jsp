<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>类型统计</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
         *{
             margin: 0;
             padding: 0;
         }
         .main{
             width: 100%;
             height: 100%;
             position: absolute;
         }
         .quarter-div{
             width: 50%;
             height: 50%;
             float: left;
         }
     </style>
</head>
   <body>
     <div class="main">
         <div class="quarter-div"><c:import url="./page1.jsp"></c:import></div>
         <div class="quarter-div"><c:import url="./page2.jsp"></c:import></div>
		<iframe id="chartPage" name=""
			src="${ctx}/sys/office/typeEchartChildren?flag=1"
			style="overflow:visible;height:600px;" scrolling="no"
			frameborder="no" onload="iFrameHeight();" width="100%"></iframe>
	</div>
   </body>
</html>