<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>信息管理</title>
    <link href="${ctxStatic}/indexStyle/css/font-awesome.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/ionicons.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/perfect-scrollbar.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/rickshaw.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${ctxStatic}/indexStyle/css/starlight.css">
    <link rel="stylesheet" href="${ctxStatic}/indexStyle/css/bootstrap.min.css">
    <script src="${ctxStatic}/indexStyle/jquery.min.js"></script>
    <script src="${ctxStatic}/indexStyle/bootstrap.min.js"></script>
    <script src="${ctxStatic}/common/clearBoxRight.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var liWidth = $("#myTabContent li").width() - 160;
            var searchBox = $("#myTab").width() - 340;
            var searchBox1 = $("#myTab").width();
            $("#ulContent").width(searchBox1);
            $("#myTabContent a").width(liWidth);

            var boxHeight = $("#textCont").height();
            $("#indexCarousel img").css("height", boxHeight);
            var userAgent = navigator.userAgent; //取得浏览器的userAgent字符串
        });
        function iFrameHeight() {
            var ifm = document.getElementById("chartPage");
            var subWeb = document.frames ? document.frames["chartPage"].document : ifm.contentDocument;
            if (ifm != null && subWeb != null) {
                ifm.height = subWeb.body.scrollHeight;
            }
        }
    </script>
    <style type="text/css">
        .quire {
            width: auto;
            height: 100px;
            background-color: #eeeeee;
            text-align: center;
            line-height: 25px;
            padding-top: 15px;
        }

        .glyphicon {
            top: 40%;
            left: 40%;
        }

        .carouselwww {
            display: block;
            width: 100%;
            max-width: 100%;
        }

        p {
            margin: 0 0 0px;
        }

        #jiduan {
            height: 60px;
            padding-top: 8px;
        }

        .heightChange {
            height: 36px;
        }

        .row.clearMargin {
            margin: 0 !important
        }

        #first, #second, #third, #four, #five {
            margin-top: 10px;
        }

        .clearMargin {
            margin-bottom: 0px;
        }

        #myTabContent a {
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
            display: inline-block;
        }

        @media (min-width: 1200px) {
            #realBox {
                display: none;
            }
        }
    </style>
</head>
<body>
<div class="analysisBox">
    <div class="sl-pagebody">

        <div class="banner">
            <div id="myCarousel" class="carousel slide">
                <!-- 轮播（Carousel）项目 -->
                <div class="carousel-inner">
                    <div class="item active">
                        <img src="${ctxStatic}/indexStyle/img/ban_001.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_002.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_003.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_004.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_005.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_006.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_007.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_008.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_009.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_010.png" alt="First slide">
                    </div>
                    <div class="item">
                        <img src="${ctxStatic}/indexStyle/img/ban_011.png" alt="First slide">
                    </div>
                </div>
                <!-- 轮播（Carousel）导航 -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>
        </div>
    </div>
</div>

<!--  -->
<div class="analysisBox">
    <div class="row clearMargin">
        <div class="col-xs-6 col-sm-6" style="padding-left:0 !important;">
            <div class="banner">
                <div id="indexCarousel" class="carousel slide">
                    <!-- 轮播（Carousel）指标 -->
                    <ol class="carousel-indicators">
                        <!-- <li data-target="#indexCarousel" data-slide-to="0" class="active"></li>
                        <li data-target="#indexCarousel" data-slide-to="1"></li> -->
                        <!-- <li data-target="#indexCarousel" data-slide-to="2"></li>
                        <li data-target="#indexCarousel" data-slide-to="3"></li>
                        <li data-target="#indexCarousel" data-slide-to="4"></li> -->
                    </ol>
                    <!-- 轮播（Carousel）项目 -->
                    <div class="carousel-inner">
                        <%-- <div class="item active">
                            <img src="${ctxStatic}/indexStyle/img/work_1.JPG" class="carouselwww" alt="First slide">
                        </div> --%>
                        <div class="item active" style="height:310px;">
                            <a href="${ctx}/gzdt/ecppInformationCopy/form1?id=afad7b11b378464ca9514fc1e4e51dae"><img
                                    src="${ctxStatic}/indexStyle/img/index_pic.jpg" class="carouselwww"
                                    alt="First slide"></a>
                        </div>
                        <%-- <div class="item">
                            <img src="${ctxStatic}/indexStyle/img/work_2.png" class="carouselwww" alt="Second slide">
                        </div> --%>
                        <%-- <div class="item">
                            <img src="${ctxStatic}/indexStyle/img/banner_img1-3.jpg" class="carouselwww" alt="Third slide">
                        </div>
                        <div class="item">
                            <img src="${ctxStatic}/indexStyle/img/banner_img1-4.jpg" class="carouselwww" alt="Third slide">
                        </div>
                        <div class="item">
                            <img src="${ctxStatic}/indexStyle/img/banner_img1-5.jpg" class="carouselwww" alt="Third slide">
                        </div> --%>
                    </div>
                    <!-- 轮播（Carousel）导航 -->
                    <!-- <a class="left carousel-control" href="#indexCarousel" role="button" data-slide="prev">
                        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="right carousel-control" href="#indexCarousel" role="button" data-slide="next">
                        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a> -->
                </div>
            </div>

        </div><!-- col-3 -->
        <div class="col-xs-6 col-sm-6" id="textCont">
            <div style="display:inline-block;margin-bottom:5px;" id="realBox">
                <form:form id="searchForm" style="margin-bottom:0 !important;"
                           modelAttribute="information"
                           action="${ctx}/ecpp/information/sousuo" method="post">
                    <input id="pageNo" name="pageNo" type="hidden"
                           value="${page.pageNo}"/>
                    <input id="pageSize" name="pageSize" type="hidden"
                           value="${page.pageSize}"/>
                    <div class="input-group">
                        <form:input path="informationtitle" placeholder="新闻标题"
                                    htmlEscape="false" maxlength="50"
                                    class="form-control heightChange"/>
                        <span class="input-group-btn">
								<button class="btn btn-default" id="btnSubmit" type="submit">搜索</button>
							</span>
                    </div>
                </form:form>
            </div>

            <div id="ulContent">
                <ul class="nav nav-tabs">
                    <li class="active"><a href="#first" data-toggle="tab">工作动态</a></li>
                    <li><a href="#second" data-toggle="tab">部门信息</a></li>
                    <li><a href="#third" data-toggle="tab">企业信息</a></li>
                    <li><a href="#four" data-toggle="tab">部门归档</a></li>
                    <li><a href="#five" data-toggle="tab">企业归档</a></li>


                    <%-- <li style="float:right;position:relative;margin-left:12px;">
                        <div style="display:inline-block;" id="realBox">
                            <form:form id="searchForm" style="margin-bottom:0 !important;"
                                modelAttribute="information"
                                action="${ctx}/ecpp/information/sousuo" method="post">
                                <input id="pageNo" name="pageNo" type="hidden"
                                    value="${page.pageNo}" />
                                <input id="pageSize" name="pageSize" type="hidden"
                                    value="${page.pageSize}" />
                                <div class="input-group">
                                    <form:input path="informationtitle" placeholder="新闻标题"
                                        htmlEscape="false" maxlength="50"
                                        class="form-control heightChange" />
                                    <span class="input-group-btn">
                                        <button class="btn btn-default" id="btnSubmit" type="submit">搜索</button>
                                    </span>
                                </div>
                            </form:form>
                        </div>
                    </li> --%>


                </ul>
            </div>
            <div id="myTabContent" class="tab-content">
                <div class="tab-pane fade in active" id="first">
                    <ul class="list-group clearMargin">
                        <c:forEach items="${list1}" var="list1" varStatus="i" end="3">
                            <li class="list-group-item">
                                <span class="badge"><fmt:formatDate value="${list1.createDate}"
                                                                    pattern="yyyy-MM-dd"/></span>
                                <c:if test="${list1.remarks == '1'}">
                                    <span class="badge" style="color:red;background-color:#fff;">new</span>
                                </c:if>
                                <a href="${ctx}/gzdt/ecppInformationCopy/form1?id=${list1.id}">${i.index+1}、${list1.informationtitle}</a>
                            </li>
                            <c:if test="${i.last}">
                                <li class="list-group-item changeHeight">
                                    <i class="text-center"><p><a href="${ctx}/gzdt/ecppInformationCopy/list1">更多>>></a>
                                    </p></i>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <div class="tab-pane fade" id="second">
                    <ul class="list-group clearMargin">
                        <c:forEach items="${list2}" var="list2" varStatus="j" begin="0" end="3">
                            <li class="list-group-item">
                                <span class="badge"><fmt:formatDate value="${list2.createDate}"
                                                                    pattern="yyyy-MM-dd"/></span>
                                <c:if test="${list2.remarks == '1'}">
                                    <span class="badge" style="color:red;background-color:#fff;">new</span>
                                </c:if>
                                <a href="${ctx}/ecpp/information/informationDetails?id=${list2.id}">${list2.unit.remarks}:${list2.informationtitle}</a>
                            </li>
                            <c:if test="${j.last}">
                                <li class="list-group-item changeHeight">
                                    <i class="text-center"><p><a href="${ctx}/ecpp/information/list2">更多>>></a></p></i>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <div class="tab-pane fade" id="third">
                    <ul class="list-group clearMargin">
                        <c:forEach items="${list3}" var="list3" varStatus="k" end="3">
                            <li class="list-group-item">
                                <span class="badge blue"><fmt:formatDate value="${list3.createDate}"
                                                                         pattern="yyyy-MM-dd"/></span>
                                <c:if test="${list3.remarks == '1'}">
                                    <span class="badge" style="color:red;background-color:#fff;">new</span>
                                </c:if>
                                <a href="${ctx}/ecpp/information/informationDetails?id=${list3.id}">${list3.unit.remarks}：${list3.informationtitle}</a>
                            </li>
                            <c:if test="${k.last}">
                                <li class="list-group-item changeHeight">
                                    <i class="text-center"><p><a href="${ctx}/ecpp/information/list3">更多>>></a></p></i>
                                </li>
                            </c:if>
                        </c:forEach>
                    </ul>
                </div>
                <div class="tab-pane fade" id="four">
                    <ul class="list-group clearMargin">
                        <c:forEach items="${list4}" var="list4" varStatus="k" end="2">
                            <li class="list-group-item">
                                <span class="badge blue"><fmt:formatDate value="${list4.createDate}" pattern="yyyy-MM-dd"/></span>

                                <c:choose>
                                    <c:when test="${list4.segment =='二'}">
                                        <a href="${ctx}/ecpp/planinformation/a2List2?unit.id=${list4.unit.id}&unit.type=${list4.unit.type}">[第${list4.segment}环节][${list4.unit.remarks}][问题目标和措施]</a>
                                    </c:when>
                                    <c:when test="${list4.segment =='三'}">
                                        <a href="${ctx}/ecpp/planinformation/a3List2?unit.id=${list4.unit.id}&unit.type=${list4.unit.type}">[第${list4.segment}环节][${list4.unit.remarks}][问题目标和措施]</a>
                                    </c:when>
                                    <c:when test="${list4.segment =='四'}">
                                        <a href="${ctx}/ecpp/planinformation/a4List2?unit.id=${list4.unit.id}&unit.type=${list4.unit.type}">[第${list4.segment}环节][${list4.unit.remarks}][问题目标和措施]</a>
                                    </c:when>
                                </c:choose>

                                <%--<a href="${ctx}/ecpp/planinformation/a3List1?remarks=${list4.unit.id}">[第${list4.segment}环节]${list4.unit.remarks}：问题、目标和措施归档</a>--%>
                            </li>
                        </c:forEach>
                        <c:forEach items="${ecppWorkprogrammeCompany}" var="ecppWorkprogrammeCompany" varStatus="k" end="1">
                            <li class="list-group-item">
                                <span class="badge blue"><fmt:formatDate value="${ecppWorkprogrammeCompany.createDate}"
                                                                         pattern="yyyy-MM-dd"/></span>
                                <a href="${ctx}/ecpp/planinformation/a3ListWorkPlanCompany?unit.id=${ecppWorkprogrammeCompany.unit.id}">[第一环节][${ecppWorkprogrammeCompany.unit.name}][工作计划]</a>
                            </li>
                        </c:forEach>
                        <c:if test="${not empty list4 || not empty ecppWorkprogrammeCompany}">
                            <li class="list-group-item changeHeight">
                                <i class="text-center"><p><a href="${ctx}/ecpp/information/guidangbumenlist">更多>>></a></p>
                                </i>
                            </li>
                        </c:if>
                    </ul>
                </div>
                <div class="tab-pane fade" id="five">
                    <ul class="list-group clearMargin">
                        <c:forEach items="${list5}" var="list5" varStatus="k" end="1">
                            <li class="list-group-item">
                                <span class="badge blue"><fmt:formatDate value="${list5.createDate}"
                                                                         pattern="yyyy-MM-dd"/></span>
                                    <%--<a href="${ctx}/ecpp/planinformation/a3List2?remarks=${list5.unit.id}">[第X环节][${list5.unit.remarks}][问题目标和措施]</a>--%>
                                <c:choose>
                                    <c:when test="${list5.segment =='二'}">
                                        <a href="${ctx}/ecpp/planinformation/a2List2?unit.id=${list5.unit.id}&unit.type=${list5.unit.type}">[第${list5.segment}环节][${list5.unit.remarks}][问题目标和措施]</a>
                                    </c:when>
                                    <c:when test="${list5.segment =='三'}">
                                        <a href="${ctx}/ecpp/planinformation/a3List2?unit.id=${list5.unit.id}&unit.type=${list5.unit.type}">[第${list5.segment}环节][${list5.unit.remarks}][问题目标和措施]</a>
                                    </c:when>
                                    <c:when test="${list5.segment =='四'}">
                                        <a href="${ctx}/ecpp/planinformation/a4List2?unit.id=${list5.unit.id}&unit.type=${list5.unit.type}">[第${list5.segment}环节][${list5.unit.remarks}][问题目标和措施]</a>
                                    </c:when>
                                </c:choose>

                            </li>
                        </c:forEach>
                        <c:forEach items="${ecppWorkprogrammeList}" var="ecppWorkprogrammeList" varStatus="k" end="1">
                            <li class="list-group-item">
                                <span class="badge blue"><fmt:formatDate value="${ecppWorkprogrammeList.createDate}"
                                                                         pattern="yyyy-MM-dd"/></span>
                                <a href="${ctx}/ecpp/planinformation/a3ListWorkPlan?unit.id=${ecppWorkprogrammeList.unit.id}">[第一环节][${ecppWorkprogrammeList.unit.name}][工作计划]</a>
                            </li>
                        </c:forEach>
                        <c:if test="${not empty list5 || not empty ecppWorkprogrammeList}">
                            <li class="list-group-item changeHeight">
                                <i class="text-center"><p><a href="${ctx}/ecpp/information/guidangqiyelist">更多>>></a></p></i>
                                    <%--<i class="text-center"><p><a href="${ctx}/ecpp/planinformation/a3ListWorkPlan">更多>>></a></p></i>--%>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="analysisBox">
    <div class="row clearMargin" id="jiduan">

        <div class="col-xs-6 col-sm-3" style="text-align:center;">
            <p><%-- ${ecppConfig.firstname} --%>第一阶段&nbsp;&nbsp;&nbsp;</p>
            <p><fmt:formatDate value="${ecppConfig.firstenddate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;&nbsp;</p>
        </div>
        <div class="col-xs-6 col-sm-3" style="text-align:center;">
            <p><%-- ${ecppConfig.secondname} --%>第二阶段&nbsp;&nbsp;&nbsp;</p>
            <p><fmt:formatDate value="${ecppConfig.secondenddate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;&nbsp;</p>
        </div>
        <div class="clearfix visible-xs-block"></div>
        <div class="col-xs-6 col-sm-3" style="text-align:center;">
            <p><%-- ${ecppConfig.thirdname} --%>第三阶段&nbsp;&nbsp;&nbsp;</p>
            <p><fmt:formatDate value="${ecppConfig.thirdenddate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;&nbsp;</p>
        </div>
        <div class="col-xs-6 col-sm-3" style="text-align:center;">
            <p><%-- ${ecppConfig.fouthname} --%>第四阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
            <p><fmt:formatDate value="${ecppConfig.fouthenddate}" pattern="yyyy-MM-dd"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
        </div>
    </div>
</div>
<iframe id="chartPage" name="" src="${ctx}/ecpp/planinformation/Analysisnew/"
        style="overflow:visible;" scrolling="no" frameborder="no" onload="iFrameHeight();"
        width="100%"></iframe>
</body>
</html>