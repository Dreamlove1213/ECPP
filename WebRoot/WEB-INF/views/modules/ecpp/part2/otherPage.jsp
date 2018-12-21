<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>管理提升</title>
    <script src="${ctxStatic}/indexStyle/js/jquery.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
           $.ajax({
                async: false,
                type: "get",
                data: {username :'YOUKE',password:'123456'},
                url: "http://172.18.102.120:8081/a/loginNewPage",
                success: function (res) {
                },
                error: function (data) {
                    console.info("error: " + data.responseText);
                    $.jBox.messager("请求失败: " + err + "请稍后再试！","提示");
                },
                complete: function () {
                    $.jBox.closeTip();
                }
            });

           /* function postglts() {
                var PARAMS={username :'YOUKE',password:'123456'};
                var temp = document.createElement("form");
                temp.action = "http://localhost:8080/a/loginNewPage" ;
                temp.method = "post";
                temp.style.display = "none";
                temp.target="_self";
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
            postglts();*/


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
        .h1NewStyle{
            text-align:center;
            margin: 10px 0;
            font-family: 'Telex',sans-serif;
            font-weight: bold;
            line-height: 40px;
            font-size: 40px !important;
            color: #000;
            text-rendering: optimizelegibility;
        }
        body{background: snow !important;}
        .Black {
            color: #404040;
            font-size: 24px;
            font-weight: bold;
        }
        .sectionBox{
            width: 1000px;
            height: 570px;
            margin: 0 auto;
        }
        .section{
            float: left;
            padding: 15px;
        }
        .part1{
            width: 700px;
            height: 558px;
        }
        .part2{
            width: 300px;
            height: 300px;
        }
        .reportContainer{
            padding-left: 20px;
            margin-top: 58px;
            border-left: 3px dashed #ababb3;
        }
        .reportContainer li{
            list-style: none;
            border-bottom: 1px dashed #e2e2e2;
            margin-bottom: 10px;
        }
        p{text-indent: 2em;margin-bottom: 10px !important;}
        .bottomCon{
            height: 200px;
            padding:20px;
        }
        .echarContainer{
            height: 950px;
            margin-top: 20px;
        }
        .h2NewStyle{
            margin: 30px 0;
            font-family: 'Telex',sans-serif;

            font-weight: bold;
            line-height: 40px;
            font-size: 20px !important;
            color: #000;
            text-rendering: optimizelegibility;
        }
        hr{
            size: 10px;
            background-color: blue;
        }
        .noIndent{text-indent: 0 !important;}
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
<header>
    <h1 class="h1NewStyle">管理提升 创先争优 追求实效</h1>
</header>
<div class="analysisBox">
    <div class="sectionBox">
        <div class="section part1">
            <h2 class="h2NewStyle">工作通知：</h2>
            <p class="noIndent">各部门、各单位：</p>
            <p>
                管理提升活动开展以来，各部门各单位高度重视，积极参与，认真推进，活动正按计划顺利进行。从信息系统上可以看到，当前陆
                续有部分立项已100%完成。为及时跟踪活动的进展情况，评估活
                动的实际效果，根据活动工作安排，请各部门各单位对已完成的立项项目进行自查，重点从下列三个方面填写自评表：
            </p>
            <p>
                1、对照检查立项时提出的问题是否已解决<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2、各改进任务是否已按立项时确定的标准完成<br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3、各改进项取得了何种成效，是否达到预期
            </p>
            <p>各部门各单位在每次提交半月报时，请将上述总结以附件的形式一起上报。管理提升领导小组办公室将在此基础上进行评价展示。</p>
            <p>集团公司10月26日召开的整治形式主义和官僚主义动员会上强调，管理提升活动要和反对形式主义相结合。请在项
                目自评中力戒形式主义，如发现提升效果不理想的，须继续改进，或梳理确立新的改进项以便持续提升。</p>
            <p style="text-align: right;">管理提升活动领导小组办公室</p>
            <p style="text-align: right;">2018年10月29日</p>
        </div>
        <div class="section part2">
            <ul class="reportContainer">
                <h2>月报列表:</h2>
                <li><a href="${ctxStatic}/Reporthtml/report.html">1、管理提升7月月报</a></li>
                <li><a href="${ctxStatic}/Reporthtml/report_month8.html">2、管理提升8月月报</a></li>
                <li><a href="${ctxStatic}/Reporthtml/report_month9.html">3、管理提升9月月报</a></li>
                <li><a href="${ctxStatic}/Reporthtml/report_month10.html">4、管理提升10月月报</a></li>
                <li><a href="${ctxStatic}/Reporthtml/report_month11.html">5、管理提升11月月报</a></li>
            </ul>
        </div>
        <div style="clear:both;width: 100%;height: 10px;background-color: #1F3B7C"></div>
    </div>

    <div class="sectionBox echarContainer">
        <h2 class="h2NewStyle">工作进度:<br>
            <span style="color: red;padding-left: 20px;">(欲查看细节，请点击柱状图)</span>
        </h2>
        <div id="demo" style="width: 1000px;height:400px;margin: 20px auto;"></div>
        <div id="demo1" style="width: 1000px;height:400px;margin: 0 auto;"></div>
        <div style="clear:both;width: 100%;height: 10px;background-color: #1F3B7C;margin-top: 30px;"></div>
    </div>

    <div class="sectionBox bottomCon">
            <h2 class="h2NewStyle">工作要求:</h2>
            <p>目前管理提升活动进入了第三环节第二阶段，到了攻坚克难见成效的关键时期。全集团整体61.4%的实际进度，与82.4%的计划进度仍有一定差距。进度未达预期的部门和单位要进一步提高认识，对照计划，加快进度，真抓实干，确保按期完成整改项目。同时，要坚决贯彻落实整治官僚主义和形式主义会议的精神，力戒形式主义，确保活动高质量、提升见实效。</p>
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
    $.get('/f/getDataIndex').done(function (data) {
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
    })

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