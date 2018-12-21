<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>组建机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
		});
	</script>
	<link href="${ctxStatic}/indexPageStyle/layui/css/layui.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/indexPageStyle/layui/layui.js" type="text/javascript"></script>
</head>
<body>
<div class="container-fluid">
	<table id="demo" lay-filter="test"></table>
</div>
<script type="text/html" id="toolbarDemo">
	<div><b>主页数据</b>&nbsp;&nbsp;&nbsp;文件数量：${dataMap.get("fileNum")}&nbsp;&nbsp;&nbsp;
		参与活动的负责人人数：${dataMap.get("fuZenNum")}&nbsp;&nbsp;&nbsp;参与活动的责任人人数：${dataMap.get("zeRenNum")}
	</div>
</script>
<script>
    layui.use('table', function(){
        var table = layui.table;

        //第一个实例
        table.render({
            elem: '#demo'
            ,height: 420
            ,url: '${ctx}/ecpp/planinformation/getStatisticsByAjaxPage' //数据接口
            ,page: true //开启分页
            ,toolbar: '#toolbarDemo' //开启工具栏，此处显示默认图标，可以自定义模板，详见文档
            ,cols: [[ //表头
                {field: 'officename', title: '机构名称', sort: true, fixed: 'left'}
                ,{field: 'muprogress', title: '目标计划进度'}
                ,{field: 'sjprogress', title: '目标实际进度', sort: true}
                ,{field: 'munum', title: '目标数量',}
                ,{field: 'gjxnum', title: '改进项数量',}
                ,{field: 'attribute3', title: '已完成改进项数量', sort: true}
            ]]
        });

    });
</script>
</body>
</html>