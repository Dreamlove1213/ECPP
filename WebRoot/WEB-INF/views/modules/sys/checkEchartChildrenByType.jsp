<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>按类型统计</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		#chart{width:100%;height:600px;}
	</style>
</head>
<body>

<div class="container-fluid">
	<div id="chart"></div>
</div>
<script src="${ctxStatic}/indexStyle/js/echarts.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('chart'));
    
    var data1 = ${fns:toJson(jhlxlist)};
    var bkVal = ${fns:toJson(bkVallist)};
    var data2 = ${fns:toJson(mbbllist)};
    var data3 = ${fns:toJson(gjxbllist)};

    option = {
            title: {
                text: '目标与改进项对比柱状图'
            },
            tooltip: {},
            legend: {
                data: ['目标', '改进项']
            },
            xAxis: {
            	data:data1
            },
            yAxis: {
                type: 'value',
                //下面的两行代码可以去除y轴没有数据的时候初始化数据不显示小数
                minInterval : 1,
                boundaryGap : [ 0, 0.1 ]
			},
            series: [
                {
                    name: '目标',
                    type: 'bar',
                    data:data2,
                    itemStyle : {
                        normal : {
                            label: {
                                show: true,
                                position: 'top',
                                textStyle: {
                                    color: 'black'
                                }
                            }
                        },
                    },
                    dataClick:bkVal
                },
                {
                    name: '改进项',
                    type: 'bar',
                    itemStyle : {
                        normal : {
                            label: {
                                show: true,
                                position: 'top',
                                textStyle: {
                                    color: 'black'
                                }
                            }
                        },
                    },
                    data:data3
                }
            ]
        };
    
   myChart.on('click', function (param) {
	 parent.location.href="${ctx}/ecpp/planinformation/a3ListIndexLook?plantype="+(param.dataIndex+1)+"&target='mainFrame'";
	}); 

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
</script>
</body>
</html>