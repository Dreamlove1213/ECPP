<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>计划改进项管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			 var message = '${saveStatus}';
			 var addSum = '${addSum}';
			 if(message != null && message != ""){
			 	$.jBox.messager("保存成功！","提示");
			 }
			 if(addSum != null && addSum != ""){
			 	$.jBox.messager("权重之和不为100！","提示");
			 }
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					var stra=$("#sturts").val();
					if(stra=="1"){
						var gnl=confirm("请注意，提交后将不允许再修改，您确定是否要提交?");  
						if (gnl==true){
                            loadingTimeOut('正在提交，请稍等...',form);
						}else{
                            return false;
						}  
					}else{
                        loadingTimeOut('正在保存，请稍等...',form);
					}
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
			//var tableWibdth = $("#improvementsList").width();
			//alert(tableWibdth);
			$(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row
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
		//	onclick="delRow(this, '#improvementsList{{idx}}','#improvementsListText{{idx}}')"
		function delRow(obj, prefix,textObj){
			var id = $(prefix+"_id");
			var delFlag = $(prefix+"_delFlag");
			if (id.val() == ""){
				$(obj).parent().parent().remove();
				$(textObj).remove();
			}else if(delFlag.val() == "0"){
				delFlag.val("1");
				$(obj).html("&divide;").attr("title", "撤销删除");
				$(obj).parent().parent().addClass("error");
			}else if(delFlag.val() == "1"){
				delFlag.val("0");
				$(obj).html("&times;").attr("title", "删除");
				$(obj).parent().parent().removeClass("error");
				//$(textObj).remove();
			}
            $(prefix).addClass("hide");
            $(textObj).addClass("hide");
		}
	</script>
	<style type="text/css">
		.input-smalli{width:110px;}
		.input-smalls{width: 65px;}
		.input-smallt{width: 98px;}
		.control-label{color:black !important;}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecpp/planinformation/u2List">目标列表</a></li>
		<li class="active"><a href="${ctx}/ecpp/planinformation/u2Form?id=${planinformation.id}">目标<shiro:hasPermission name="ecpp:planinformation:edit">${not empty planinformation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="ecpp:planinformation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/u2Save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="sturts" path="sturts"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">目标标题：</label>
			<div class="controls">
				<form:input path="plantitle" htmlEscape="false" maxlength="50" style="width:50%;" class="input-xlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">问题描述：</label>
			<div class="controls">
				<form:textarea path="problemdescription" htmlEscape="false" style="width:50%;" rows="4" maxlength="45000" class="input-xxlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标类型：</label>
			<div class="controls">
				<form:select path="plantype" class="input-xlarge required">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('ecpp_plan_type')}" itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总体目标：</label>
			<div class="controls">
				<form:textarea path="overallgoals" htmlEscape="false"  style="width:50%;" rows="4" maxlength="10240" class="input-xxlarge required"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">负责人：</label>
			<div class="controls">
				<form:input path="planprincipal" htmlEscape="false" maxlength="20" class="input-xlarge required"/>
			</div>
		</div>
		
		<div class="control-group">
			<label class="control-label">改进项：</label><br>
			<div class="controls">
				<table id="contentTable" class="" style="width:900px !important;">
					<tbody id="improvementsList">
					</tbody>
					<c:if test="${planinformation.attribute12!=1}">
					<shiro:hasPermission name="ecpp:planinformation:edit"><tfoot>
						<tr><td colspan="15"><a href="javascript:" onclick="addRow('#improvementsList', improvementsRowIdx, improvementsTpl);improvementsRowIdx = improvementsRowIdx + 1;" class="btn">新增</a></td></tr>
					</tfoot></shiro:hasPermission>
					</c:if>
				</table>
				<script type="text/template" id="improvementsTpl">//<!--
						<tr id="improvementsList{{idx}}">
							<td class="hide">
								<input id="improvementsList{{idx}}_id" name="improvementsList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="improvementsList{{idx}}_delFlag" name="improvementsList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<div class="control-group" style="border-bottom:0px;padding-bottom:0px;">
									<label class="control-label">改进项标题：</label>
									<div class="controls">
										<input id="improvementsList{{idx}}_improvedtitle" name="improvementsList[{{idx}}].improvedtitle" type="text" value="{{row.improvedtitle}}" maxlength="50" class="input-max required"/>
									</div>
								</div>
							</td>
							<td>
								<div class="control-group" style="border-bottom:0px;padding-bottom:0px;">
									<label class="control-label" style="width:50px;">权重：</label>
									<div class="controls" style="margin-left:50px;white-space:nowrap;">
										<input id="improvementsList{{idx}}_weight" name="improvementsList[{{idx}}].weight" type="text" value="{{row.weight}}" class="input-smalls number required"/>%
									</div>
								</div>
							</td>
							<td>
								<div class="control-group" style="border-bottom:0px;padding-bottom:0px;">
									<label class="control-label" style="width:70px;">责任人：</label>
									<div class="controls" style="margin-left:70px;">
										<input id="improvementsList{{idx}}_principal" name="improvementsList[{{idx}}].principal" type="text" value="{{row.principal}}" maxlength="20" class="input-smallt required"/>
									</div>
								</div>
							</td>
							<td>
								<div class="control-group" style="border-bottom:0px;padding-bottom:0px;">
									<label class="control-label">完成时间：</label>
									<div class="controls">
										<input id="improvementsList{{idx}}_finishtime" name="improvementsList[{{idx}}].finishtime" type="text" readonly="readonly" maxlength="20" class="input-medium input-smalli Wdate required"
									value="{{row.finishtime}}" onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
									</div>
								</div>
							</td>
							<shiro:hasPermission name="ecpp:planinformation:edit"><td rowspan="2" class="text-center" width="10">
								{{#delBtn}}<span class="close" onclick="delRow(this, '#improvementsList{{idx}}','#improvementsListText{{idx}}')" title="删除">&times;</span>{{/delBtn}}
							</td></shiro:hasPermission>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<td colspan="4">
								<textarea id="improvementsList{{idx}}_content" name="improvementsList[{{idx}}].content" rows="5" style="width:98%;margin-bottom:18px;" cols="1000" maxlength="50000" class="required">{{row.content}}</textarea>
								<hr style="margin:-5px 0 15px 0;">
							</td>
						</tr>//-->
					</script>
							<!-- <td>
								<input id="improvementsList{{idx}}_remarks" name="improvementsList[{{idx}}].remarks" type="text" value="{{row.remarks}}" maxlength="1024" class="input-max "/>
							</td> -->
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
		<%-- <div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="1024" class="input-xxlarge "/>
			</div>
		</div> --%>
		
	
			
		<%-- <div class="form-actions">
			<shiro:hasPermission name="ecpp:planinformation:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div> --%>
		
		<div class="form-actions">
			<shiro:hasPermission name="ecpp:planinformation:edit">
			<c:if test="${planinformation.attribute12!=1}">
				<!-- <input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交" onclick="$('#sturts').val('1')"/>&nbsp; -->
				<input id="btnSubmit2" class="btn btn-primary" type="submit" value="保 存" onclick="$('#sturts').val('0')"/>&nbsp;
			</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>