<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
	</script>
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
    var bkVal=${fns:toJson(ofidlist)};
    var data1=${fns:toJson(dwlist)};
    var data2=${fns:toJson(mbjdlist)};
    var data3=${fns:toJson(sjjdlist)};
    myChart.title = '改进项排名';

    option = {
        title: {
            text: '改进项排名',
            subtext: '系统统计'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        legend: {
            data: ['目标', '改进项']
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        color:['#0F65C1','#2A363F'],
        yAxis: {
            type: 'value',
            //下面的两行代码可以去除y轴没有数据的时候初始化数据不显示小数
            minInterval : 1,
            boundaryGap : [ 0, 0.1 ]
        },
        xAxis: {
            type: 'category',
            //data: ['沈阳设计院','南京设计院','上海有限公司','煤科院','天地奔牛','天地支护','煤科总院','天地华泰','常州研究院','安标中心']
       		data:data1,
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
                       zoomOnMouseWheel:false
                   }
               
               ],
        series: [
            {
                name: '目标',
                type: 'bar',
                //data: [18, 23, 29, 10, 13, 63, 56, 56, 45, 34],
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
                //data: [19, 23, 33, 12, 13, 68, 78, 90, 43, 34]
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
 	 //设置x轴的最大值
   //option.yAxis.max = '100';
 	 
 	myChart.on('click', function (param) {
 		//根据公司的改进项数量进行排序
	 	location.href="${ctx}/ecpp/planinformation/a3ListIndexLook?unit.id="+option.series[0].dataClick[param.dataIndex]+"&unit.type="+${type}+"&target='mainFrame'";
    	//alert(option.series[0].dataClick[param.dataIndex]);
	}); 

    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
	</script>
</body>
</html>