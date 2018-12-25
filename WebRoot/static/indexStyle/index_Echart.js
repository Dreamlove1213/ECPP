// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('demo'));
var myChart1 = echarts.init(document.getElementById('demo1'));

myChart.showLoading();  //option
myChart1.showLoading(); //option1
var dwlistId=[];
var dwlistDId=[];
$.get('http://localhost:8081/a/ecpp/planinformation/getDataIndex').done(function (data) {
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
    location.href = "http://localhost:8081/a/ecpp/planinformation/a3ListIndexLook?unit.id=" + dwlistDId[param.dataIndex] + "&unit.type=3&target='mainFrame'";
});
myChart.on('click', function (param) {
    location.href = "http://localhost:8081/a/ecpp/planinformation/a3ListIndexLook?unit.id=" + dwlistId[param.dataIndex] + "&unit.type=2&target='mainFrame'";
});

//设置x轴的最大值
option.yAxis.max = '100';
option1.yAxis.max = '100';
// 使用刚指定的配置项和数据显示图表。
myChart.setOption(option);
myChart1.setOption(option1);


$(document).click(function (event) {
    var _con = $("#aside", top.document);
    var _con1 = $("#container", top.document);
    if (!_con.is(event.target) && _con.has(event.target).length === 0) { // Mark 1
        $(_con1).removeClass('aside-in')     //淡出消失
    } else {
        $(_con1).addClass('aside-in')
    }
});

$(document).ready(function(){
    //四方块的数据
    $.ajax({
        type: "get",
        url: "http://localhost:8081/a/ecpp/planinformation/Analysisnew",
        dateType:"json",
        success: function (data) {
            console.log(data);
        },
        error: function (data) {
            console.info("error: " + data.responseText);
        }
    });
});