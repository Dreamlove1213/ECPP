<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title></title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free HTML5 Template by FREEHTML5"/>
	<meta name="keywords" content="free html5, free template, free bootstrap, html5, css3, mobile first, responsive"/>
	<!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
	<!-- Animate.css -->
	<link rel="stylesheet" href="${ctxStatic}/monthReport/css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="${ctxStatic}/monthReport/css/icomoon.css">
	<!-- Simple Line Icons -->
	<link rel="stylesheet" href="${ctxStatic}/monthReport/css/simple-line-icons.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="${ctxStatic}/monthReport/css/bootstrap.css">
	<!-- Superfish -->
	<link rel="stylesheet" href="${ctxStatic}/monthReport/css/superfish.css">
	<!-- Flexslider  -->
	<link rel="stylesheet" href="${ctxStatic}/monthReport/css/flexslider.css">
	<link rel="stylesheet" href="${ctxStatic}/monthReport/css/style.css">
	<link rel="stylesheet" type="text/css" href="${ctxStatic}/monthReport/css/index.css"/>
	<!-- Modernizr JS -->
	<script src="${ctxStatic}/monthReport/js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="${ctxStatic}/monthReport/js/respond.min.js"></script>
	<![endif]-->
	<script src="${ctxStatic}/jquery/jquery-1.8.3.js"></script>

	<script>
        $(function(){
            $('#dowebok').fullpage({
                sectionsColor: ['#e2e2e2']
            });
        });
	</script>
</head>
<body>
<div id="dowebok">
	<div class="section">
		<div id="fh5co-wrapper">
			<div id="fh5co-page">
				<div id="fh5co-counter-section" class="fh5co-counters">
					<div class="container">
						<div class="row">
							<div class="col-md-6 col-md-offset-3 text-center fh5co-heading">
								<h2>月报展示</h2>
								<p>管理提升平台月报信息 </p>
							</div>
						</div>
						<div class="row">
							<div class="col-md-4 text-center">
                        <span class="fh5co-counter js-counter" data-from="0" data-to="${dataMap.get("fileNum")}" data-speed="5000"
							  data-refresh-interval="50"></span>
								<span class="fh5co-counter-label">文件数量</span>
							</div>
							<div class="col-md-4 text-center">
                        <span class="fh5co-counter js-counter" data-from="0" data-to="${dataMap.get("fuZenNum")}" data-speed="5000"
							  data-refresh-interval="50"></span>
								<span class="fh5co-counter-label">参与活动的负责人人数</span>
							</div>
							<div class="col-md-4 text-center">
                        <span class="fh5co-counter js-counter" data-from="0" data-to="${dataMap.get("zeRenNum")}" data-speed="5000"
							  data-refresh-interval="50"></span>
								<span class="fh5co-counter-label">参与活动的责任人人数</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<!-- jQuery -->
<script src="${ctxStatic}/monthReport/js/jquery.min.js"></script>
<script src="${ctxStatic}/fullpage/jquery.fullPage.js"></script>
<!-- jQuery Easing -->
<script src="${ctxStatic}/monthReport/js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="${ctxStatic}/monthReport/js/bootstrap.min.js"></script>
<!-- Waypoints -->
<script src="${ctxStatic}/monthReport/js/jquery.waypoints.min.js"></script>
<!-- Superfish -->
<script src="${ctxStatic}/monthReport/js/hoverIntent.js"></script>
<script src="${ctxStatic}/monthReport/js/superfish.js"></script>
<!-- Flexslider -->
<script src="${ctxStatic}/monthReport/js/jquery.flexslider-min.js"></script>
<!-- Stellar -->
<script src="${ctxStatic}/monthReport/js/jquery.stellar.min.js"></script>
<!-- Counters -->
<script src="${ctxStatic}/monthReport/js/jquery.countTo.js"></script>
<!-- Main JS (Do not remove) -->
<script src="${ctxStatic}/monthReport/js/main.js"></script>
</body>
</html>