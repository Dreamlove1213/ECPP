<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>信息管理</title>
    <script src="${ctxStatic}/indexStyle/js/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $(document).click(function (event) {
                var _con = $("#aside", top.document);
                var _con1 = $("#container", top.document);
                var _con = $('#aside');  // 设置目标区域
                if (!_con.is(event.target) && _con.has(event.target).length === 0) { // Mark 1
                    $(_con1).removeClass('aside-in')     //淡出消失
                } else {
                    $(_con1).addClass('aside-in')
                }
            });
        });
    </script>
    <style type="text/css">
        .Black {
            color: #404040;
            font-size: 24px;
            font-weight: bold;
        }
    </style>
    <link href="${ctxStatic}/indexStyle/css/font-awesome.css"
          rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/ionicons.css" rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/perfect-scrollbar.css"
          rel="stylesheet">
    <link href="${ctxStatic}/indexStyle/css/rickshaw.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="${ctxStatic}/indexStyle/css/starlight.css">
    <script src="${ctxStatic}/indexStyle/js/flexie.js"></script>
</head>
<body>
<div class="analysisBox">
    <div class="sl-pagebody">
        <div class="Black">统计分析</div>
        <div class="row row-sm">
            <div class="col-sm-6 col-xl-3">
                <a href="${ctx}/sys/office/analyzeByType" target="mainFrame">
                    <div class="card pd-20 bg-primary">
                        <div
                                class="d-flex justify-content-between align-items-center mg-b-10">
                            <h6
                                    class="tx-11 tx-uppercase mg-b-0 tx-spacing-1 tx-white tx-18l">按类型&nbsp;&nbsp;&nbsp;目标数量：${dataMap.get("mbToatal")}&nbsp;&nbsp;改进项数量：${dataMap.get("gjxToatal")}</h6>
                        </div>
                        <!-- card-header -->
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="sparkline2">5,3,9,6,5,9,7,3,5,2</span>
                            <h3 class="mg-b-0 tx-white tx-lato tx-bold"> ${singleData.planTypeNum1}</h3>
                        </div>
                        <!-- card-body -->
                        <div
                                class="d-flex align-items-center justify-content-between mg-t-15 bd-t bd-white-2 pd-t-10">
                            <div>
                                <h6 class="tx-white mg-b-0"></h6>
                            </div>
                            <div>
                                <h6 class="tx-white mg-b-0"> ${singleData.planTypeNum11} </h6>
                            </div>
                        </div>
                        <!-- -->
                    </div>
                </a>
                <!-- card -->
            </div>
            <!-- col-3 -->
            <div class="col-sm-6 col-xl-3 mg-t-20 mg-sm-t-0">
                <a href="${ctx}/sys/office/institionOnly?type=2" target="mainFrame">
                    <div class="card pd-20 bg-info">
                        <div
                                class="d-flex justify-content-between align-items-center mg-b-10">
                            <h6
                                    class="tx-11 tx-uppercase mg-b-0 tx-spacing-1 tx-white tx-18l">按部门&nbsp;&nbsp;&nbsp;目标数量：${dataMap.get("mbNum1")}&nbsp;&nbsp;改进项数量：${dataMap.get("gjxNum1")}</h6>
                        </div>
                        <!-- card-header -->
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="sparkline2">5,3,9,6,5,9,7,3,5,2</span>
                            <h3 class="mg-b-0 tx-white tx-lato tx-bold"> ${singleData.planTypeNum2} </h3>
                        </div>
                        <!-- card-body -->
                        <div
                                class="d-flex align-items-center justify-content-between mg-t-15 bd-t bd-white-2 pd-t-10">
                            <div>
                                <h6 class="tx-white mg-b-0"></h6>
                            </div>
                            <div>
                                <h6 class="tx-white mg-b-0"> ${singleData.planTypeNum22} </h6>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <div class="col-sm-6 col-xl-3 mg-t-20 mg-xl-t-0">
                <a href="${ctx}/sys/office/institionOnly?type=3" target="mainFrame">
                    <div class="card pd-20 bg-purple">
                        <div class="d-flex justify-content-between align-items-center mg-b-10">
                            <h6
                                    class="tx-11 tx-uppercase mg-b-0 tx-spacing-1 tx-white tx-18l">按公司&nbsp;&nbsp;&nbsp;目标数量：${dataMap.get("mbNum2")}&nbsp;&nbsp;改进项数量：${dataMap.get("gjxNum2")}</h6>
                        </div>
                        <!-- card-header -->
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="sparkline2">5,3,9,6,5,9,7,3,5,2</span>
                            <h3 class="mg-b-0 tx-white tx-lato tx-bold"> ${singleData.planTypeNum3} </h3>
                        </div>
                        <!-- card-body -->
                        <div class="d-flex align-items-center justify-content-between mg-t-15 bd-t bd-white-2 pd-t-10">
                            <div>
                                <h6 class="tx-white mg-b-0"></h6>
                            </div>
                            <div>
                                <h6 class="tx-white mg-b-0"> ${singleData.planTypeNum33} </h6>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
            <!-- col-3 -->
            <div class="col-sm-6 col-xl-3 mg-t-20 mg-xl-t-0">
                <a href="${ctx}/sys/office/checkEchartPlateSix" target="mainFrame">
                    <div class="card pd-20 bg-sl-primary">
                        <div class="d-flex justify-content-between align-items-center mg-b-10">
                            <h6
                                    class="tx-11 tx-uppercase mg-b-0 tx-spacing-1 tx-white tx-18l">按板块&nbsp;&nbsp;&nbsp;目标数量：${dataMap.get("mbToatal")}&nbsp;&nbsp;改进项数量：${dataMap.get("gjxToatal")}</h6>
                        </div>
                        <!-- card-header -->
                        <div class="d-flex align-items-center justify-content-between">
                            <span class="sparkline2">5,3,9,6,5,9,7,3,5,2</span>
                            <h3 class="mg-b-0 tx-white tx-lato tx-bold"> ${singleData.planTypeNum4} </h3>
                        </div>
                        <!-- card-body -->
                        <div
                                class="d-flex align-items-center justify-content-between mg-t-15 bd-t bd-white-2 pd-t-10">
                            <div>
                                <h6 class="tx-white mg-b-0"></h6>
                            </div>
                            <div>
                                <h6 class="tx-white mg-b-0"> ${singleData.planTypeNum44} </h6>
                            </div>
                        </div>
                    </div>
                </a>
            </div>
        </div>
        <div class="row row-sm mg-t-20">
        </div>
        <div class="row row-sm mg-t-20">
            <div id="demo" style="width: 100%;height:400px;"></div>
        </div>
        <div class="row row-sm mg-t-20">
            <div id="demo1" style="width: 100%;height:400px;"></div>
        </div>
    </div>
</div>
<input id="officeArray" type="hidden" value="${singleData.officeArray}"/>
<input id="intArray" type="hidden" value="${singleData.intArray}"/>
<script src="${ctxStatic}/indexStyle/js/jquery.js"></script>
<script src="${ctxStatic}/indexStyle/js/popper.js"></script>
<script src="${ctxStatic}/indexStyle/js/bootstrap.js"></script>
<script src="${ctxStatic}/indexStyle/js/jquery-ui.js"></script>
<script src="${ctxStatic}/indexStyle/js/perfect-scrollbar.jquery.js"></script>
<script src="${ctxStatic}/indexStyle/js/jquery.sparkline.min.js"></script>
<script src="${ctxStatic}/indexStyle/js/d3.js"></script>
<script src="${ctxStatic}/indexStyle/js/rickshaw.min.js"></script>
<script src="${ctxStatic}/indexStyle/js/chart.js"></script>
<script src="${ctxStatic}/indexStyle/js/jquery.flot.js"></script>
<script src="${ctxStatic}/indexStyle/js/jquery.flot.pie.js"></script>
<script src="${ctxStatic}/indexStyle/js/jquery.flot.resize.js"></script>
<script src="${ctxStatic}/indexStyle/js/jquery.flot.spline.js"></script>
<script src="${ctxStatic}/indexStyle/js/starlight.js"></script>
<script src="${ctxStatic}/indexStyle/js/resizesensor.js"></script>
<script src="${ctxStatic}/indexStyle/js/dashboard.js"></script>
<script src="${ctxStatic}/indexStyle/js/echarts.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('demo'));
    var myChart1 = echarts.init(document.getElementById('demo1'));

    myChart.showLoading();  //option
    myChart1.showLoading(); //option1
    var dwlistId=[];
    var dwlistDId=[];
    $.get('${ctx}/ecpp/planinformation/getDataIndex').done(function (data) {
        dwlistId = data.dwlistId;
        dwlistDId = data.dwlistDId;
        myChart.hideLoading();
        myChart1.hideLoading();
        myChart.setOption({
            xAxis: {
                data: data.dwlist
            },
            series: [
                {
                    data: data.mbjdlist,
                },
                {
                    data: data.sjjdlist
                }
            ],
        });
        myChart1.setOption({
            xAxis: {
                data: data.dwlistD,
            },
            series: [
                {
                    data: data.mbjdlistD,
                },
                {
                    data: data.sjjdlistD
                }
            ]
        });

    });

    myChart.title = '目标实施进度排名';

    option = {
        title: {
            text: '目标实施进度排名(百分制)  集团部门',
            subtext: '系统统计'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            data: ['目标计划进度', '目标实际进度']
        },
        color: ['#3F91CF', '#7443BA'],
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        yAxis: {
            type: 'value',
            boundaryGap: [0, 0.01],
            axisLabel: {
                formatter: '{value}%'
            }
        },
        xAxis: {
            type: 'category',
            //data: ['沈阳设计院','南京设计院','上海有限公司','煤科院','天地奔牛','天地支护','煤科总院','天地华泰','常州研究院','安标中心']
            data: [],
            axisLabel: {
                interval: 0,
                rotate: 45
            }
        },
        dataZoom: [
            {
                type: 'slider',
                show: true,
                xAxisIndex: [0],
                start: 0,
                end: 100
            },
            {
                type: 'inside',
                xAxisIndex: [0],
                start: 0,
                end: 100,
                zoomOnMouseWheel: false
            }

        ],

        series: [
            {
                name: '目标计划进度',
                type: 'bar',
                //data: [18.3, 23, 29, 10, 13, 63, 56, 56, 45, 34]
                itemStyle: {
                    normal: {
                        label: {
                            show: true,
                            position: 'top',
                            textStyle: {
                                color: 'black'
                            }
                        }
                    },
                },
                data: [],
            },
            {
                name: '目标实际进度',
                type: 'bar',
                //data: [19, 23, 33, 12, 13, 68, 78, 90, 43, 34]
                itemStyle: {
                    normal: {
                        label: {
                            show: true,
                            position: 'top',
                            textStyle: {
                                color: 'black'
                            }
                        }
                    },
                },
                data:[]
            }
        ],
    };


    option1 = {
        title: {
            text: '目标实施进度排名(百分制)  二级单位',
            subtext: '系统统计'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            data: ['目标计划进度', '目标实际进度']
        },
        color: ['#3F91CF', '#7443BA'],
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        yAxis: {
            type: 'value',
            boundaryGap: [0, 0.01],
            axisLabel: {
                formatter: '{value}%'
            }
        },
        dataZoom: [
            {
                type: 'slider',
                show: true,
                xAxisIndex: [0],
                start: 0,
                end: 100
            },
            {
                type: 'inside',
                xAxisIndex: [0],
                start: 0,
                end: 100,
                zoomOnMouseWheel: false
            }

        ],
        xAxis: {
            type: 'category',
            //data: ['沈阳设计院','南京设计院','上海有限公司','煤科院','天地奔牛','天地支护','煤科总院','天地华泰','常州研究院','安标中心']
            data: [],
            axisLabel: {
                interval: 0,
                rotate: 45
            }
        },

        series: [
            {
                name: '目标计划进度',
                type: 'bar',
                roam: false,
                //data: [18.3, 23, 29, 10, 13, 63, 56, 56, 45, 34]
                itemStyle: {
                    normal: {
                        label: {
                            show: true,
                            position: 'top',
                            textStyle: {
                                color: 'black'
                            }
                        }
                    },
                },
                data: [],
            },
            {
                name: '目标实际进度',
                type: 'bar',
                //data: [19, 23, 33, 12, 13, 68, 78, 90, 43, 34]
                itemStyle: {
                    normal: {
                        label: {
                            show: true,
                            position: 'top',
                            textStyle: {
                                color: 'black'
                            }
                        }
                    },
                },
                data:[]
            }
        ]
    };
    myChart1.on('click', function (param) {
        parent.location.href = "${ctx}/ecpp/planinformation/a3ListIndexLook?unit.id=" + dwlistDId[param.dataIndex] + "&unit.type=3&target='mainFrame'";
    });
    myChart.on('click', function (param) {
       parent.location.href = "${ctx}/ecpp/planinformation/a3ListIndexLook?unit.id=" + dwlistId[param.dataIndex] + "&unit.type=2&target='mainFrame'";
    });

    //设置x轴的最大值
    option.yAxis.max = '100';
    option1.yAxis.max = '100';
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
    myChart1.setOption(option1);
</script>
<script type="text/javascript">
    $(document).click(function (event) {
        var _con = $("#aside", top.document);
        var _con1 = $("#container", top.document);
        if (!_con.is(event.target) && _con.has(event.target).length === 0) { // Mark 1
            $(_con1).removeClass('aside-in')     //淡出消失
        } else {
            $(_con1).addClass('aside-in')
        }
    });
</script>
</body>
</html>