<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>${fns:getConfig('productName')}</title>
<meta name="decorator" content="indexStyle" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<link rel="shortcut icon" type="image/x-icon"
	href="${ctxStatic}/indexStyle/img/favicon.ico" />
<c:set var="tabmode"
	value="${empty cookie.tabmode.value ? '0' : cookie.tabmode.value}" />
<c:if test="${tabmode eq '1'}">
	<link rel="Stylesheet"
		href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
	<script type="text/javascript"
		src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script>
</c:if>
    <script type="text/javascript"
            src="${ctxStatic}/Reporthtml/js/floatingAd.js"></script>
    <link rel="Stylesheet"
          href="${ctxStatic}/Reporthtml/css/ad.css" />
<script type="text/javascript">
	$(document).ready(function() {
        $.ajax({
			url:"${ctx}/ecpp/resultrecord/getAdvice",
			success:function(result){
				for(var i=0;i<result.length;i++){
                    var htmlString = "<a href='${ctx}/ecpp/planinformation/u3Form?id= "+result[i].planid+"&urlParmeter=adviceLook' target='mainFrame' class='list-group-item'>"+
                        "<div class='media-left pos-rel'>"+
                        "<img class='img-circle img-xs' src='${ctxStatic}/indexPageStyle/img/profile-photos/2.png' alt='Profile Picture'>"+
                        "<i class='badge badge-success badge-stat badge-icon pull-left'></i>"+
                        "</div>"+
                        "<div class='media-body'>"+
                        "<p class='mar-no'>改革小组建议</p>"+
                        "<small class='text-muted'>"+result[i].updateDate+"</small>"+
                        "</div>"+
                        "</a>";
				    $("#infomationContainar").append(htmlString);
				}
				var len = $("#hideListNews").children().length;
                if (len == 1 && result.length != 0){
                    $("#hideListNews").append("<span class='badge badge-header badge-danger'></span>");
                }
        }});
	    //--------------------------------------------------------------------分割线
						var hei = $(window).height() - 75;
						$("#mainFrame").load(function() {
							$(this).height(hei);
						});
						//鼠标点击当前菜单，给出当前所在的位置
						 $(document).on("click","li",function(e){
							 $(".active-link").each(function() {
							        $(this).removeClass("active-link");
								});
							 var obj = e.target;
							 if(!$(obj).parent().hasClass("active")){
								 $(obj).parent().addClass("active-link");
							 }
				            })

						// <c:if test="${tabmode eq '1'}"> 初始化页签
						$.fn.initJerichoTab({
							renderTo : '#right',
							uniqueId : 'jerichotab',
							contentCss : {
								'height' : $('#right').height()
										- tabTitleHeight
							},
							tabs : [],
							loadOnce : true,
							tabWidth : 110,
							titleHeight : tabTitleHeight
						});//</c:if>
						// 绑定菜单单击事件
						setTimeout("timerFun()",1000);
						$("#menu a.menu")
								.click(
										function() {
											// 一级菜单焦点
											$("#menu li.menu").removeClass(
													"active");
											$(this).parent().addClass("active");
											// 左侧区域隐藏
											if ($(this).attr("target") == "mainFrame") {
												$("#left,#openClose").hide();
												//wSizeWidth();
												// <c:if test="${tabmode eq '1'}"> 隐藏页签
												$(".jericho_tab").hide();
												$("#mainFrame").show();//</c:if>
												return true;
											}
											// 左侧区域显示
											$("#left,#openClose").show();
											if (!$("#openClose").hasClass(
													"close")) {
												$("#openClose").click();
											}
											// 显示二级菜单
											var menuId = "#menu-"
													+ $(this).attr("data-id");
											if ($(menuId).length > 0) {
												$("#left .accordion").hide();
												$(menuId).show();
												// 初始化点击第一个二级菜单
												if (!$(menuId + " .accordion-body:first").hasClass('in')) {
													$(menuId + " .accordion-heading:first a").click();
													$(menuId + " .accordion-heading:first").addClass("active");
												}
												if (!$(menuId + " .accordion-body li:first ul:first").is(":visible")) {
													$(menuId + " .accordion-body a:first i").click();
												}
												// 初始化点击第一个三级菜单
												$(menuId + " .accordion-body li:first li:first a:first i").click();
											} else {
												// 获取二级菜单数据
												$.get($(this).attr("data-href"),
													function(data) {
															if (data.indexOf("id=\"loginForm\"") != -1) {
																	alert('未登录或登录超时。请重新登录，谢谢！');
																	top.location = "${ctx}";
																	return false;
																}
																$("#left .accordion").hide();
																$("#left").append(data);
																// 链接去掉虚框
																$(menuId + " a").bind("focus", function() {
																					if (this.blur) {this.blur()};
																				});
																// 二级标题
																$(menuId + " .accordion-heading a").click(
																		function() {
																			$(menuId + " .accordion-toggle i").removeClass('icon-chevron-down').addClass('icon-chevron-right');
																			if (!$($(this).attr('data-href')).hasClass('in')) {
																				$(this).children("i").removeClass('icon-chevron-right').addClass('icon-chevron-down');
																			}
																		});
																// 二级内容
																$(menuId + " .accordion-body a").click(
																	function() {
																		$(menuId + " li").removeClass("active");
																		$(menuId + " li i").removeClass("icon-white");
																		$(this).parent().addClass("active");
																		$(this).children("i").addClass("icon-white");
																	});
																// 展现三级
																$(menuId + " .accordion-inner a").click(
																	function() {
																		var href = $(this).attr("data-href");
																					if ($(href).length > 0) {
																						$(href).toggle().parent().toggle();
																						return false;
																					}
																					// <c:if test="${tabmode eq '1'}"> 打开显示页签
																					return addTab($(this)); // </c:if>
																				});
																// 默认选中第一个菜单
																//$(menuId + " .accordion-body a:first i").click();
																//$(menuId + " .accordion-body li:first li:first a:first i").click();
																mainFrame.document.location = "/a/ecpp/information/"
															});
											}
											// 大小宽度调整
											//wSizeWidth();
											return false;
										});
						// 初始化点击第一个一级菜单
						$("#menu a.menu:first span").click();
						// <c:if test="${tabmode eq '1'}"> 下拉菜单以选项卡方式打开
						$("#userInfo .dropdown-menu a").mouseup(function() {
							return addTab($(this), true);
						});// </c:if>
						// 鼠标移动到边界自动弹出左侧菜单
						$("#openClose").mouseover(function() {
							if ($(this).hasClass("open")) {
								$(this).click();
							}
						});
						// 获取通知数目  <c:set var="oaNotifyRemindInterval" value="${fns:getConfig('oa.notify.remind.interval')}"/>
						function getNotifyNum() {
							$.get(
									"${ctx}/oa/oaNotify/self/count?updateSession=0&t="
											+ new Date().getTime(), function(
											data) {
										var num = parseFloat(data);
										if (num > 0) {
											$("#notifyNum,#notifyNum2").show()
													.html("(" + num + ")");
										} else {
											$("#notifyNum,#notifyNum2").hide()
										}
									});
						}
						getNotifyNum(); //<c:if test="${oaNotifyRemindInterval ne '' && oaNotifyRemindInterval ne '0'}">
						setInterval(getNotifyNum, ${oaNotifyRemindInterval}); //</c:if>
						$("#mainnav-menu a").unbind();
						
						
						//提醒框手动关闭
						$("#demo-btn-close-settings").on("click",function(){
							$("#messageBox").animate({bottom:'-151px'});
						});


        //动态广告效果
        $.floatingAd({
            //频率
            delay: 60,
            //超链接后是否关闭漂浮
            isLinkClosed: false,
            //漂浮内容
            ad:	[{
                //关闭区域背景透明度(0.1-1)
                headFilter: 0.3,
                //图片
                'img': '${ctxStatic}/Reporthtml/img/bk.jpg',
                //图片高度
                'imgHeight': 100,
                //图片宽度
                'imgWidth': 100,
                //图片链接
                'linkUrl': '${ctxStatic}/Reporthtml/report_month11.html',
                //浮动层级别
                'z-index': 100,
                //标题
                'title': '月报展示'
            }],
            //关闭事件
            onClose: function(elem){
                //alert('关闭');
            }
        });

        $("#aa").floatingAd({
            onClose:function(elem){}
        });
					}); 
	// <c:if test="${tabmode eq '1'}"> 添加一个页签
	function addTab($this, refresh) {
		$(".jericho_tab").show();
		$("#mainFrame").hide();
		$.fn.jerichoTab.addTab({
			tabFirer : $this,
			title : $this.text(),
			closeable : true,
			data : {
				dataType : 'iframe',
				dataLink : $this.attr('href')
			}
		}).loadData(refresh);
		return false;
	}// </c:if>
	/*连续点击 即可退出系统，并打开月报需要的统计数据*/
	var iCount = 0;
    function gotoReport() {
        iCount +=1;
        if(iCount == 10){
            //window.location.href = "${ctx}/logout";
            //window.open("${ctx}/ecpp/planinformation/monthReport");
            mainFrame.location.href = "${ctx}/ecpp/planinformation/getstatisticsData";
		}
		if(iCount == 15){
            window.location.href = "${ctx}/logout";
		}
    }
	function Foo() {
		location.reload();//页面刷新
	}
	$(document).click(function(event){
		        var _con = $('#aside');  // 设置目标区域
		        if(!_con.is(event.target) && _con.has(event.target).length === 0){ // Mark 1
		           //$('#divTop').slideUp('slow');  //滑动消失
		           $('#container').removeClass('aside-in')     //淡出消失
		        }else{$('#container').addClass('aside-in') }
		   });
</script>
<script src="${ctxStatic}/indexPageStyle/layer/layer.js"></script>
	<script>
        ;!function(){

	//页面一打开就执行，放入ready是为了layer所需配件（css、扩展模块）加载完毕
            layer.ready(function(){
				<c:if test="${isRead == '1'}">
					<c:if test="${not empty stringlist}">
					layer.open({
						type: 2,
						title: '倒计时通知',
						maxmin: true,
                        closeBtn: 0,
						area: ['800px', '500px'],
						content: '${ctx}/config/ecppConfig/layerNotice1',
						btn: ['知道了'],yes:function (index) {
                            $.post('${ctx}/oa/oaNotify/changeSession',function(){
                                layer.close(index);
                            })
						}
					});
					</c:if>
				</c:if>

//-------------------------------------------------------------------------------------------------------------------------------------

				<c:if test="${not empty oanatifylist}">
                layer.open({
                    type: 2,
                    title: '群发通知',
                    maxmin: true,
                    closeBtn: 0,
                    area: ['800px', '500px'],
                    content: '${ctx}/config/ecppConfig/layerNotice2',
                    btn: ['知道了'],yes:function(index){
                        $.post('${ctx}/oa/oaNotify/viewLook',{id:'${idString}'},function(){
                            layer.close(index);
                        })
                    }
                });
				</c:if>
            });

        }();
	</script>
<style type="text/css">
#btnMenu,#menuContent {  display: none !important;  }
 *{ font-size:16px !important;  }
.demo-pli-view-list{font-size:22px !important;}
.bgColor{background-color: #FF710F;color: #e2e2e2}
.fontStyle{color: #0a0903;font-weight: 700; font-size: 23px !important;}
.dropdown.bgColor:hover a div span{color: white;}
</style>
</head>
<body onclick="hideListNews()" style="overflow:hidden;">
	<div id="container" class="effect aside-float aside-bright mainnav-lg">
		<header id="navbar">
			<div id="navbar-container" class="boxed">
				<div class="navbar-header"
					style="display:<%-- <c:if test="${fns:getUser().name =='游客'}">none !important;</c:if> --%>">
					<a href="${ctx}?login" class="navbar-brand widthSmall">
						 <img src="${ctxStatic}/indexStyle/img/logo.png" alt="Nifty Logo"
						class="brand-icon">
						<div class="brand-title">
							<span class="brand-text">管理提升信息系统</span>
						</div>
					</a>
				</div>
				<div class="navbar-content clearfix">
					<ul class="nav navbar-top-links pull-left">
						<li class="tgl-menu-btn"><a class="mainnav-toggle" href="#">
								<i class="demo-pli-view-list"></i>
						</a></li>
					</ul>
					<ul class="nav navbar-top-links pull-right">
                        <li class="dropdown bgColor">
                            <a href="${ctxStatic}/Reporthtml/report_month11.html" target="_blank" class="dropdown-toggle text-right">
                                <div class="username hidden-xs"><span class="fontStyle">月报展示</span></div>
							</a>
                        </li>
						<c:if test="${fns:getUser().name !='游客'}">
							<li class="dropdown">
								<a href="${ctx}?login" class="dropdown-toggle text-right">
									<c:set var="isRead" value="${sessionScope.isRead}"/>
									<div class="username hidden-xs">首页</div>
								</a>
							</li>
						</c:if>

						<li id="dropdown-user" class="dropdown">
							<a href="#" data-toggle="dropdown" class="dropdown-toggle text-right">
								<span class="pull-right">
									<img class="img-circle img-user media-object" src="${ctxStatic}/indexPageStyle/img/profile-photos/1.png" alt="Profile Picture">
								</span>
								<div class="username hidden-xs" onclick="gotoReport()">您好, ${fns:getUser().name}</div>
							</a>
						</li>

						<li>
							<a href="#" id="hideListNews" data-toggle="dropdown" class="aside-toggle"> <i class="demo-pli-bell"></i>
								<c:if test="${newslist.size() != 0}">
									<span class="badge badge-header badge-danger"></span>
								</c:if>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</header>
		<div class="boxed">
			<div id="content-container">
				<div id="page-content">
					<iframe id="mainFrame" name="mainFrame" src="" style="overflow:visible;" scrolling="yes" frameborder="no" width="100%"></iframe>
				</div>
			</div>
			<aside id="aside-container">
				<div id="aside">
					<div class="nano">
						<div class="nano-content">
							<ul class="nav nav-tabs nav-justified">
								<li class="active"><a href="#demo-asd-tab-1"
									data-toggle="tab"> <i class="demo-pli-speech-bubble-7"></i>&nbsp;&nbsp;&nbsp;消息
								</a></li>
                                <li>
                                    <a href="#demo-asd-tab-2" data-toggle="tab">
                                        <i class="demo-pli-information icon-fw"></i> 历史消息
                                    </a>
                                </li>
							</ul>
							<div class="tab-content">
								<div class="tab-pane fade in active" id="demo-asd-tab-1">
									<p class="pad-hor mar-top text-semibold text-main">消息</p>
									<div class="list-group bg-trans" id="infomationContainar">
										<c:forEach items="${newslist}" var="news">
											<a href="${ctx}${news.url}" target="mainFrame" class="list-group-item">
												<div class="media-left pos-rel">
													<img class="img-circle img-xs"
														src="${ctxStatic}/indexPageStyle/img/profile-photos/2.png"
														alt="Profile Picture"> <i
														class="badge badge-success badge-stat badge-icon pull-left"></i>
												</div>
												<div class="media-body">
													<p class="mar-no">${news.name}</p>
													<small class="text-muted"><fmt:formatDate
															value="${news.createDate}"
															pattern="yyyy-MM-dd HH:mm:ss" /></small>
												</div>
											</a>
										</c:forEach>
									</div>
								</div>
								<div class="tab-pane fade" id="demo-asd-tab-2">
									<p class="pad-hor text-semibold text-main">历史消息</p>
									<div class="list-group bg-trans">
                                        <c:forEach items="${newslisHository}" var="newsHository">
                                            <a href="${ctx}/ecpp/information/hositoryList"
                                                    target="mainFrame" class="list-group-item">
                                                <div class="media-left pos-rel">
                                                    <img class="img-circle img-xs"
                                                         src="${ctxStatic}/indexPageStyle/img/profile-photos/2.png"
                                                         alt="Profile Picture"> <i
                                                        class="badge badge-success badge-stat badge-icon pull-left"></i>
                                                </div>
                                                <div class="media-body">
                                                    <p class="mar-no">${newsHository.informationtitle}</p>
                                                    <small class="text-muted"><fmt:formatDate
                                                            value="${newsHository.createDate}"
                                                            pattern="yyyy-MM-dd HH:mm:ss" /></small>
                                                </div>
                                            </a>
                                        </c:forEach>
									</div>
								</div>
								<div class="tab-pane fade" id="demo-asd-tab-3">
									<ul class="list-group bg-trans">
										<li class="pad-top list-header">
											<p class="text-semibold text-main mar-no">Account
												Settings</p>
										</li>
										<li class="list-group-item">
											<div class="pull-right">
												<input class="toggle-switch" id="demo-switch-1"
													type="checkbox" checked> <label for="demo-switch-1"></label>
											</div>
											<p class="mar-no">Show my personal status</p> <small
											class="text-muted">Lorem ipsum dolor sit amet,
												consectetuer adipiscing elit. </small>
										</li>
										<li class="list-group-item">
											<div class="pull-right">
												<input class="toggle-switch" id="demo-switch-2"
													type="checkbox" checked> <label for="demo-switch-2"></label>
											</div>
											<p class="mar-no">Show offline contact</p> <small
											class="text-muted">Aenean commodo ligula eget dolor.
												Aenean massa. </small>
										</li>
										<li class="list-group-item">
											<div class="pull-right">
												<input class="toggle-switch" id="demo-switch-3"
													type="checkbox"> <label for="demo-switch-3"></label>
											</div>
											<p class="mar-no">Invisible mode</p> <small
											class="text-muted">Cum sociis natoque penatibus et
												magnis dis parturient montes, nascetur ridiculus mus. </small>
										</li>
									</ul>
									<hr>
									<ul class="list-group pad-btm bg-trans">
										<li class="list-header"><p
												class="text-semibold text-main mar-no">Public Settings</p></li>
										<li class="list-group-item">
											<div class="pull-right">
												<input class="toggle-switch" id="demo-switch-4"
													type="checkbox" checked> <label for="demo-switch-4"></label>
											</div> Online status
										</li>
										<li class="list-group-item">
											<div class="pull-right">
												<input class="toggle-switch" id="demo-switch-5"
													type="checkbox" checked> <label for="demo-switch-5"></label>
											</div> Show offline contact
										</li>
										<li class="list-group-item">
											<div class="pull-right">
												<input class="toggle-switch" id="demo-switch-6"
													type="checkbox" checked> <label for="demo-switch-6"></label>
											</div> Show my device icon
										</li>
									</ul>
									<hr>
									<p class="pad-hor text-semibold text-main mar-no">Task
										Progress</p>
									<div class="pad-all">
										<p>Upgrade Progress</p>
										<div class="progress progress-sm">
											<div class="progress-bar progress-bar-success"
												style="width: 15%;">
												<span class="sr-only">15%</span>
											</div>
										</div>
										<small class="text-muted">15% Completed</small>
									</div>
									<div class="pad-hor">
										<p>Database</p>
										<div class="progress progress-sm">
											<div class="progress-bar progress-bar-danger"
												style="width: 75%;">
												<span class="sr-only">75%</span>
											</div>
										</div>
										<small class="text-muted">17/23 Database</small>
									</div>

								</div>
							</div>
						</div>
					</div>
				</div>
			</aside>
			<c:if test="${fns:getUser().name }"></c:if>
			<nav id="mainnav-container"
				style="display:<%-- <c:if test="${fns:getUser().name =='游客'}">none !important;</c:if> --%>">
				<div id="mainnav">
					<div id="mainnav-menu-wrap">
						<div class="nano">
							<div class="nano-content">
								<ul id="menu" style="display:none !important;">
									<c:set var="firstMenu" value="true" />
									<c:forEach items="${fns:getMenuList()}" var="menu"
										varStatus="idxStatus">
										<c:if test="${menu.parent.id eq '1'&&menu.isShow eq '1'}">
											<li
												class="menu ${not empty firstMenu && firstMenu ? ' active' : ''}">
												<c:if test="${empty menu.href}">
													<a class="menu" href="javascript:"
														data-href="${ctx}/sys/menu/tree?parentId=${menu.id}"
														data-id="${menu.id}"><span>${menu.name}</span></a>
												</c:if> <c:if test="${not empty menu.href}">
													<a class="menu"
														href="${fn:indexOf(menu.href, '://') eq -1 ? ctx : ''}${menu.href}"
														data-id="${menu.id}" target="mainFrame"><span>${menu.name}</span></a>
												</c:if>
											</li>
											<c:if test="${firstMenu}">
												<c:set var="firstMenuId" value="${menu.id}" />
											</c:if>
											<c:set var="firstMenu" value="false" />
										</c:if>
									</c:forEach>
								</ul>

								<ul id="mainnav-menu" class="list-group">
									<c:set var="menuList" value="${fns:getMenuList()}" />
									<c:set var="firstMenu" value="true" />

									<c:forEach items="${menuList}" var="menu" varStatus="idxStatus">

										<c:if
											test="${menu.parentId eq '79fe4bc46c3f41ffa7cfe3d057525ed3' &&menu.isShow eq '1'}">
											<li><a href="#"> <i class="demo-psi-file-html"></i>
													<strong>&nbsp;&nbsp;${menu.name}</strong> 
													<!-- <i class="arrow"></i> -->
											</a> <!--Submenu二级菜单-->
												<ul class="collapse in">
													<c:forEach items="${menuList}" var="menu2">
														<c:if
															test="${menu2.parent.id eq menu.id&&menu2.isShow eq '1'}">
															<li><a data-href=".menu3-${menu2.id}"
																href="${fn:indexOf(menu2.href, '://') eq -1 ? ctx : ''}${not empty menu2.href ? menu2.href : '/404'}"
																target="${not empty menu2.target ? menu2.target : 'mainFrame'}">
																	<%-- <i class="icon-${not empty menu2.icon ? menu2.icon : 'circle-arrow-right'}"> --%>
																	<i class="demo-psi-receipt-4"> </i>&nbsp;${menu2.name}
															</a></li>
															<c:set var="firstMenu" value="false" />
														</c:if>
													</c:forEach>
												</ul></li>
										</c:if>
									</c:forEach>
									<li class="list-divider"></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</div>
		<footer id="footer">
			<p class="pad-lft">&#0169; 2018 管理提升信息系统</p>
		</footer>
		<button class="scroll-top btn">
			<i class="pci-chevron chevron-up"></i>
		</button>
	</div>
</body>
<!-- iframe 高度调整-->
<script type="text/javascript">
	var hei = $(window).height() - 75;
	$("#mainFrame").load(function() {
		$(this).height(hei);
	});
</script>
</html>
