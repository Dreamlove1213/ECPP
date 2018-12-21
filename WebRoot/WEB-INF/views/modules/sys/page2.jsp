 <%@ page contentType="text/html;charset=UTF-8" %>
 <%@ include file="/WEB-INF/views/include/taglib.jsp"%>     
       <div id="page1" style="height: 100%"></div>
       <script src="${ctxStatic}/indexStyle/js/echarts.js"></script>
       <script src="${ctxStatic}/indexStyle/js/echarts-gl.min.js"></script>
       <script type="text/javascript">
		var dom = document.getElementById("page1");
		var myChart = echarts.init(dom);
		var app = {};
		option = null;
		option = {
		    title : {
		        text: '改进项',
		        subtext: '',
		        x:'center'
		    },
		    tooltip : {
		        trigger: 'item',
		        formatter: "{a} <br/>{b} : {c} ({d}%)"
		    },
		    legend: {
		        orient: 'vertical',
		        left: 'left',
		        data: [${planName}]
		    },
		    series : [
		        {
		            name: '计划类型',
		            type: 'pie',
		            radius : '55%',
		            center: ['50%', '60%'],
		            data:[
		                {value:${typeViewImpList.get(0).getValue()}, name:'${typeViewImpList.get(0).getName()}'},
		                {value:${typeViewImpList.get(1).getValue()}, name:'${typeViewImpList.get(1).getName()}'},
		                {value:${typeViewImpList.get(2).getValue()}, name:'${typeViewImpList.get(2).getName()}'},
		                {value:${typeViewImpList.get(3).getValue()}, name:'${typeViewImpList.get(3).getName()}'}
		            ],
		            itemStyle: {
		                emphasis: {
		                    shadowBlur: 10,
		                    shadowOffsetX: 0,
		                    shadowColor: 'rgba(0, 0, 0, 0.5)'
		                },
                        normal : {
                            label : {
                                show : ${flagPage2}   //隐藏标示文字
                            },
                            labelLine : {
                                show : ${flagPage2}   //隐藏标示线
                            }
                        }
		            }
		        }
		    ]
		};
		;
		if (option && typeof option === "object") {
		    myChart.setOption(option, true);
		}
		// 处理点击事件并且跳转到相应页面
		   myChart.on('click', function (param) {
			window.location.href="${ctx}/ecpp/planinformation/a3ListIndexLook?plantype="+(param.dataIndex+1)+"&target='mainFrame'";
			}); 
       </script>
