<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建通讯录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
                    loadingTimeOut('正在提交，请稍等...',form);
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
		.input-xlarge{
			border: 0px;
		}
	</style>
</head>
<body style="padding:0px 5px;">
	<ul class="nav nav-tabs">
		<li><a href="javascript:;">通讯录信息查看</a></li>
		<c:if test="${not empty strformation.id and todo eq false}">
		<li><a href="${ctx}/stion/strformation/form/?id=${strformation.id}">修改</a></li>
		</c:if>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="strformation" action="${ctx}/stion/strformation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="status"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">负责人姓名：</label>
			<div class="controls">${strformation.name}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">负责人职位：</label>
			<div class="controls">${strformation.zhiwei}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">负责人电话：</label>
			<div class="controls">${strformation.dianhua}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">负责人邮箱：</label>
			<div class="controls">${strformation.youxiang}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">${strformation.remarks}
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">联络人列表：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed">
						<thead>
							<tr>
								<th>序号</th>
								<th>姓名</th>
								<th>oa账号</th>
								<th>部门</th>
								<th>职位</th>
								<th>电话</th>
								<th>手机</th>
								<th>邮箱</th>
							</tr>
						</thead>
						<tbody id="strformationitemList">
						</tbody>
						<%-- <shiro:hasPermission name="stion:strformation:edit"><tfoot>
							<tr><td colspan="15"><a href="javascript:" onclick="addRow('#strformationitemList', strformationitemRowIdx, strformationitemTpl);strformationitemRowIdx = strformationitemRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission> --%>
					</table>
					<script type="text/template" id="strformationitemTpl">//<!--
						<tr id="strformationitemList{{idx}}">
							<td>联络人{{index}}</td>
							<td>{{row.nane}}</td>
							<td>{{row.oa}}</td>
							<td>{{row.bumen}}</td>
							<td>{{row.zhiwei}}</td>
							<td>{{row.dianhua}}</td>
							<td>{{row.shouji}}</td>
							<td>{{row.youxiang}}</td>
						</tr>//-->
					</script>
					<script type="text/javascript">
						var strformationitemRowIdx = 0, strformationitemTpl = $("#strformationitemTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
						$(document).ready(function() {
							var data = ${fns:toJson(strformation.strformationitemList)};
							for (var i=0; i<data.length; i++){
								addRow('#strformationitemList', strformationitemRowIdx, strformationitemTpl, data[i]);
								strformationitemRowIdx = strformationitemRowIdx + 1;
							}
						});
					</script>
				</div>
			</div>
			<c:if test="${todo eq false}"><%-- 若提交后不能在提交则用： ${strformation.status eq '0' and todo eq false} --%>
				<div class="form-actions">
					<input id="" class="btn btn-primary" onclick="$('#status').val('1')" type="submit" value="提 交"/>&nbsp;
					<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
				</div>
			</c:if>
	</form:form>
</body>
</html>