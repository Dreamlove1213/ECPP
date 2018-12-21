<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>目标改进项管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		p.con{
			margin: 5px 0px 10px;
		}
	</style>
	<script type="text/javascript">
        $(document).ready(function() {

            var attachment = $("#selfevaluation").val();

            if(!attachment){
                var string = new Array()
                var fileName = new Array()
                string = attachment.split("|");
                for(var i=1; i<string.length; i++){
                    fileName[i] = decodeURIComponent(string[i].substring(string[i].lastIndexOf("/")+1));
                    if(i==1){
                        $("#fileBox").append("<p style='padding-left:80px;line-height:16px;'><a href='"+string[i]+"'>"+fileName[i]+"</a></p>");
                    }else{
                        $("#fileBox").append("<p style='padding-left:80px;line-height:16px;'><a href='"+string[i]+"'>"+fileName[i]+"</a></p>");
                    }
                    //console.log(fileName[i])
                }
            }

            //$("#name").focus();
            $("#inputForm").validate({
                submitHandler: function(form){
                    loading('正在保存，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function(error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
        });
        function addRow(list, idx, tpl, row){
            $(list).append(Mustache.render(tpl, {
                idx: idx, delBtn: true, row: row, index: idx+1
            }));
            $(list+idx).find("select").each(function(){
                $(this).val($(this).attr("data-value"));
            });
            $(list+idx).find("input[type='checkbox'], input[type='radio']").each(function(){
                var ss = $(this).attr("data-value").split(',');
                for (var i=0; i<ss.length; i++){
                    if($(this).val() == ss[i]){
                        $(this).attr("checked","checked");
                    }
                }
            });
        }
        function delRow(obj, prefix){
            var id = $(prefix+"_id");
            var delFlag = $(prefix+"_delFlag");
            if (id.val() == ""){
                $(obj).parent().parent().remove();
            }else if(delFlag.val() == "0"){
                delFlag.val("1");
                $(obj).html("&divide;").attr("title", "撤销删除");
                $(obj).parent().parent().addClass("error");
            }else if(delFlag.val() == "1"){
                delFlag.val("0");
                $(obj).html("&times;").attr("title", "删除");
                $(obj).parent().parent().removeClass("error");
            }
        }
	</script>
	<style type="text/css">
		.moveDown{padding-top:3px;}
		.backColor{background:#F6F5F4;}
	</style>
</head>
<body>
<ul class="nav nav-tabs">
	<li><a href="${ctx}/ecpp/planinformation/a2List2?unit.id=${officeId}&unit.type=${type}">目标列表</a></li>
	<li class="active"><a href="javascript:">目标/改进项 信息查看</a></li>
</ul><br/>
<form:form id="inputForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/save" method="post" class="form-horizontal">
	<form:hidden path="id"/>
	<sys:message content="${message}"/>
	<div class="control-group">
		<label class="control-label"><font style="color:black;">目标标题：</font></label>
		<div class="controls">
			<p class="con">${planinformation.plantitle}</p>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><font style="color:black;">问题描述：</font></label>
		<div class="controls">
			<p class="con">${planinformation.problemdescription}</p>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><font style="color:black;">目标类型：</font></label>
		<div class="controls">
			<p class="con">${fns:getDictLabel(planinformation.plantype, 'ecpp_plan_type', '')}</p>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><font style="color:black;">总体目标：</font></label>
		<div class="controls">
			<p class="con">${planinformation.overallgoals}</p>
		</div>
	</div>
	<div class="control-group">
		<label class="control-label"><font style="color:black;">负责人：</font></label>
		<div class="controls">
			<p class="con">${planinformation.planprincipal}</p>
		</div>
	</div>

	<div class="control-group">
		<label class="control-label"><font style="color:black;">改进项：</font></label>
		<div class="controls">
			<table id="contentTable" class="table table-bordered table-condensed" style="<c:if test="${fn:length(planinformation.improvementsList) == 0}">border:none;</c:if>">
				<tbody id="improvementsList">
				</tbody>
			</table>
			<script type="text/template" id="improvementsTpl">//<!--
						<tr id="improvementsList{{idx}}" class="backColor">
							<td>
								<font style="color:black;">序号：</font>{{index}}
							</td>
							<td>
								<font style="color:black;">改进项标题：</font>{{row.improvedtitle}}
							</td>
							<td>
								<font style="color:black;">权重：</font>{{row.weight}}%
							</td>
							<%--<td>
								<font style="color:black;">进度：</font>{{row.improvementprogress}}%
							</td>--%>
							<td>
								<font style="color:black;">责任人：</font>{{row.principal}}
							</td>
							<td colspan="2">
								<font style="color:black;">完成时间：</font>{{row.finishtime}}
							</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">改进项内容：</font>{{row.content}}</td>
						</tr>
						<%--<tr>
							<td colspan="6"><font style="color:black;">定期记录改进措施实施情况：</font>{{row.attribute2}}</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">1阶段措施实施情况小结：</font>{{row.attribute3}}</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">2阶段措施实施情况小结：</font>{{row.attribute4}}</td>
						</tr>--%>
						//-->
			</script>

			<script type="text/javascript">
                var improvementsRowIdx = 0, improvementsTpl = $("#improvementsTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
                $(document).ready(function() {
                    var data = ${fns:toJson(planinformation.improvementsList)};
                    for (var i=0; i<data.length; i++){
                        addRow('#improvementsList', improvementsRowIdx, improvementsTpl, data[i]);
                        improvementsRowIdx = improvementsRowIdx + 1;
                    }
                });
			</script>
		</div>
	</div>
	<input type="hidden" id="selfevaluation" value="${planinformation.selfevaluation}" />

	<div class="form-actions">
		<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
	</div>
</form:form>

<script type="text/javascript">
    function noPass(e) {
        var status = confirm("确定要驳回此条上报信息吗?");
        if(status == true){
            var id = e;
            //var bh =  $("#bh").val();
            $.ajax({
                type : "post",
                url : "${ctx}/ecpp/planinformation/noPass",
                data : {
                    'id' : id,
                    'shstatus' : '2',
                    //'attribute1':bh
                },
                dataType : "json",
                success : function(msg) {

                    $.jBox.alert("操作完成！");
                    if (msg == "1") {
                        $.jBox.alert("操作完成！");
                        window.location.href = "${ctx}/ecpp/planinformation/a2List";
                    }
                },
                error : function(json) {
                    $.jBox.alert("网络异常！");
                }
            });
        }
    }
    function pass(e) {
        var status = confirm("确定要通过此条目标信息吗?");
        if(status == true){
            var id = e;
            $.ajax({
                type : "post",
                url : "${ctx}/ecpp/planinformation/pass",
                data : {
                    'id' : id,
                    'shstatus' : '1'
                },
                dataType : "json",
                success : function(msg) {
                    $.jBox.alert("操作完成！");
                    if (msg == "1") {
                        $.jBox.alert("操作完成！");
                        window.location.href = "${ctx}/ecpp/planinformation/a2List";
                    }
                },
                error : function(json) {
                    $.jBox.alert("网络异常！");
                }
            });
        }

    }
</script>
</body>
</html>