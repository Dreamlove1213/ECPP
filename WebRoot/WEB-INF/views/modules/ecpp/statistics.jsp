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
	<script src="https://cdn.staticfile.org/vue/2.4.2/vue.min.js"></script>
	<script src="https://cdn.bootcss.com/vue-resource/1.5.1/vue-resource.min.js"></script>
	<link href="${ctxStatic}/indexPageStyle/layui/layui.css" type="text/css" rel="stylesheet" />
	<script src="${ctxStatic}/indexPageStyle/layui/layui.js" type="text/javascript"></script>
</head>
<body>
<div class="container-fluid">
	<table class="layui-table" id="app">
		<colgroup>
			<col width="150">
			<col>
			<col>
			<col>
			<col>
			<col>
		</colgroup>
		<thead>
		<tr>
			<th colspan="6" style="text-align: center;"><b>主页数据</b>&nbsp;&nbsp;&nbsp;文件数量：${dataMap.get("fileNum")}&nbsp;&nbsp;&nbsp;
				参与活动的负责人人数：${dataMap.get("fuZenNum")}&nbsp;&nbsp;&nbsp;参与活动的责任人人数：${dataMap.get("zeRenNum")}</th>
		</tr>
		<tr>
			<th>机构名称</th>
			<th>目标计划进度</th>
			<th>目标实际进度</th>
			<th>目标数量</th>
			<th>改进项数量</th>
			<th>已完成改进项数量</th>
		</tr>
		</thead>
		<tbody>
		<tr v-for="value in libraryInfo">
			<td>{{value.officename}}</td>
			<td>{{value.muprogress}}</td>
			<td>{{value.sjprogress}}</td>
			<td>{{value.munum}}</td>
			<td>{{value.gjxnum}}</td>
			<td>{{value.attribute3}}</td>
		</tr>
		</tbody>
	</table>
</div>
<script>
    Vue.use(VueResource); //这个一定要加上，指的是调用vue-resource.js
    new Vue({
        el: '#app',      //div的id
        data: {
            libraryInfo: ""    //数据，名称自定
        },
        created: function () { //created方法，页面初始调用
            var url = "${ctx}/ecpp/planinformation/getStatisticsByAjax";
            this.$http.get(url).then(function (data) {   //ajax请求封装
                //console.info(data);
               /* var json = data.bodyText;
                var usedData= JSON.parse(json);
                //我的json数据参考下面
                this.libraryInfo = usedData["libraryBooks"];*/

                var json = data.bodyText;
                var usedData= JSON.parse(json);
                this.libraryInfo = usedData;

            }, function (response) {     //返回失败方法调用，暂不处理
                console.info(response);
            })
        }
    });
</script>
</body>
</html>