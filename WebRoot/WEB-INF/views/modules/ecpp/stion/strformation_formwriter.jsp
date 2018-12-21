<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建通讯录管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
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
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="javascript:;">通讯录<shiro:hasPermission name="stion:strformation:edit">${not empty strformation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="stion:strformation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="strformation" action="${ctx}/stion/strformation/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden path="status"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">负责人姓名：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">职位：</label>
			<div class="controls">
				<form:input path="zhiwei" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">电话：</label>
			<div class="controls">
				<form:input path="dianhua" htmlEscape="false" maxlength="255" class="input-xlarge "/>&nbsp;&nbsp;请按此格式填写：010-84264188
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">邮箱：</label>
			<div class="controls">
				<form:input path="youxiang" htmlEscape="false" maxlength="255" class="input-xlarge "/>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">单位：</label>
			<div class="controls">
				<sys:treeselect id="unit" name="unit.id" value="${strformation.unit.id}" labelName="unit.name" labelValue="${strformation.unit.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="" allowClear="true" notAllowSelectParent="true"/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="2" maxlength="1024" class="input-xxlarge "/>
			</div>
		</div>
			<div class="control-group">
				<label class="control-label">联络人：</label>
				<div class="controls">
					<table id="contentTable" class="table table-striped table-bordered table-condensed" style="text-align:center;">
						<thead>
							<tr>
								<th class="hide"></th>
								<th>序号</th>
								<th>姓名</th>
								<th>oa账号</th>
								<th>部门</th>
								<th>职位</th>
								<th>电话</th>
								<th>手机</th>
								<th>邮箱</th>
								<shiro:hasPermission name="stion:strformation:edit"><th width="10">&nbsp;</th></shiro:hasPermission>
							</tr>
						</thead>
						<tbody id="strformationitemList">
						</tbody>
						<shiro:hasPermission name="stion:strformation:edit"><tfoot>
							<tr><td colspan="15"><a href="javascript:" onclick="addRow('#strformationitemList', strformationitemRowIdx, strformationitemTpl);strformationitemRowIdx = strformationitemRowIdx + 1;" class="btn">新增</a></td></tr>
						</tfoot></shiro:hasPermission>
					</table>
					<script type="text/template" id="strformationitemTpl">//<!--
						<tr id="strformationitemList{{idx}}">
							<td class="hide">
								<input id="strformationitemList{{idx}}_id" name="strformationitemList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="strformationitemList{{idx}}_delFlag" name="strformationitemList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td style="text-align:center;">{{index}}</td>
							<td style="text-align:center;">
								<input id="strformationitemList{{idx}}_nane" name="strformationitemList[{{idx}}].nane" type="text" value="{{row.nane}}" width="95%" maxlength="255" class="input-small "/>
							</td>
							<td style="text-align:center;">
								<input id="strformationitemList{{idx}}_oa" name="strformationitemList[{{idx}}].oa" type="text" value="{{row.oa}}" maxlength="255" class="input-small "/>
							</td>
							<td style="text-align:center;">
								<input id="strformationitemList{{idx}}_bumen" name="strformationitemList[{{idx}}].bumen" type="text" value="{{row.bumen}}" maxlength="255" class="input-small "/>
							</td>
							<td style="text-align:center;">
								<input id="strformationitemList{{idx}}_zhiwei" name="strformationitemList[{{idx}}].zhiwei" type="text" value="{{row.zhiwei}}" maxlength="255" class="input-small "/>
							</td>
							<td style="text-align:center;">
								<input id="strformationitemList{{idx}}_dianhua" name="strformationitemList[{{idx}}].dianhua" type="text" value="{{row.dianhua}}" maxlength="255" class="input-small "/>
							</td>
							<td style="text-align:center;">
								<input id="strformationitemList{{idx}}_shouji" name="strformationitemList[{{idx}}].shouji" type="text" value="{{row.shouji}}" maxlength="255" class="input-small "/>
							</td>
							<td style="text-align:center;">
								<input id="strformationitemList{{idx}}_youxiang" name="strformationitemList[{{idx}}].youxiang" type="text" value="{{row.youxiang}}" maxlength="255" class="input-xlarge "/>
							</td>
							<shiro:hasPermission name="stion:strformation:edit"><td class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#strformationitemList{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
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
		<div class="form-actions">
			<shiro:hasPermission name="stion:strformation:edit">
				<input id="" class="btn btn-primary" onclick="$('#status').val('0')" type="submit" value="保 存"/>&nbsp;
				<c:if test=" ${strformation.status eq '0'}"><%-- 若提交后不能在提交 --%>
				</c:if>
				<!-- <input id="" class="btn btn-primary" onclick="$('#status').val('1')" type="submit" value="提 交"/>&nbsp; -->
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>