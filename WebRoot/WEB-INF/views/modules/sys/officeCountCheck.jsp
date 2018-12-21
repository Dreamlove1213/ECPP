<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			function iFrameHeight() {
		 	    var ifm = document.getElementById("chartPage");
		 	    var subWeb = document.frames ? document.frames["chartPage"].document : ifm.contentDocument;
		 	    if (ifm != null && subWeb != null) {
		 	         ifm.height = subWeb.body.scrollHeight;
		 	    }
		 	}
		});
	</script>
	<style type="text/css">
		.chartContainew{width:100%;}
		.chartContainew .chartContainew_child{width:50%;height:500px;float:left;}
	</style>
</head>
<body>

<div class="container-fluid">
	<div class="chartContainew">
	  <div class="chartContainew_child" id="chart1" style="display:inline-block;">
	  </div>
	  <div class="chartContainew_child" id="chart2">
	  </div>
	</div>
	<iframe id="chartPage" name="" src="${ctx}/sys/office/checkEchartChildren"
						style="overflow:visible;height:600px;" scrolling="no" frameborder="no" onload="iFrameHeight();"
						width="100%"></iframe>
</div>


<script src="${ctxStatic}/indexStyle/js/echarts.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart1 = echarts.init(document.getElementById('chart1'));
    var myChart2 = echarts.init(document.getElementById('chart2'));
    
    var data1=${fns:toJson(jhlxlist)};
    var dataClick=${fns:toJson(bklist)};
    var data2=${fns:toJson(mbbllist)};
    var data3=${fns:toJson(gjxbllist)};
    
	//扇形图1
    option1 = {
        title : {
            text: '目标比例',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            //data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
        	data:data1
        },
        series : [
            {
                name: '访问来源',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                //data:[{value:335, name:'直接访问'},{value:310, name:'邮件营销'},{value:234, name:'联盟广告'},{value:135, name:'视频广告'},{value:1548, name:'搜索引擎'}],
                data:data2,
                dataClick:dataClick,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    },
                    normal : {
                        label : {
                            show : ${flagB1}   //隐藏标示文字
                        },
                        labelLine : {
                            show : ${flagB1}   //隐藏标示线
                        }
                    }
                }
            }
        ]
    };
    
  //扇形图2
    option2 = {
        title : {
            text: '改进项比例',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            //data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
            data:data1
        },
        series : [
            {
                name: '访问来源',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                //data:[{value:335, name:'直接访问'},{value:310, name:'邮件营销'},{value:234, name:'联盟广告'},{value:135, name:'视频广告'},{value:1548, name:'搜索引擎'}],
                data:data3,
                dataClick:dataClick,
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    },
                    normal : {
                        label : {
                            show : ${flagB2}   //隐藏标示文字
                        },
                        labelLine : {
                            show : ${flagB2}   //隐藏标示线
                        }
                    }
                }
            }
        ]
    };
  
    myChart1.on('click', function (param) {
   		location.href="${ctx}/ecpp/planinformation/a3ListIndexLook?unit.plate="+option1.series[0].dataClick[param.dataIndex]+"&unit.type=3&target='mainFrame'";
       //alert(option1.series[0].dataClick[param.dataIndex]);
   	}); 
    myChart2.on('click', function (param) {
   		location.href="${ctx}/ecpp/planinformation/a3ListIndexLook?unit.plate="+option2.series[0].dataClick[param.dataIndex]+"&unit.type=3&target='mainFrame'";
       //alert(option2.series[0].dataClick[param.dataIndex]);
   	}); 

    // 使用刚指定的配置项和数据显示图表。
    myChart1.setOption(option1);
   	myChart2.setOption(option2);
</script>
</body>
</html>