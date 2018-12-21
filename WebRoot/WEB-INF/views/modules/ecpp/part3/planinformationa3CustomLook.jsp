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
	.btn.btn-success{display: none;}
	.btn.btn-warning{display: none;}
	#attachementPreview,ol{margin-bottom: 0 !important;}
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
				}
			}
			
			$("#inputForm").validate({
				submitHandler: function(form){
                    loadingTimeOut('正在保存，请稍等...',form);
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
		.displayNone{display: none;}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecpp/planinformation/a3ListIndexLook?${Parmeter}">目标列表</a></li>
		<li class="active"><a href="javascript:">目标/改进项 信息查看</a></li>
		<%-- <shiro:hasPermission name="ecpp:resultrecord:edit"><li><a href="${ctx}/ecpp/resultrecord/">更多进度信息</a></li></shiro:hasPermission> --%>
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
		<c:if test="${todo ne 'a2'}">
			<div class="control-group">
				<label class="control-label"><font style="color:black;">总进度：</font></label>
				<div class="controls">
				<c:choose>
					<c:when test = "${empty planinformation.plannedprogress}">
						<p class="con">0%</p>
					</c:when>
					<c:otherwise>
						<p class="con">${planinformation.plannedprogress}%</p>
					</c:otherwise>
				</c:choose>
				</div>
			</div>
		</c:if>
		<div class="control-group">
			<label class="control-label"><font style="color:black;">负责人：</font></label>
			<div class="controls">
				<p class="con">${planinformation.planprincipal}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label"><font style="color:black;">改进项：</font></label>
			<div class="controls">
				<table id="contentTable" class="table table-bordered table-condensed">
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
							<c:if test="${todo ne 'a2'}">
							<td>
								<font style="color:black;">进度：</font>{{row.improvementprogress}}%
							</td>
							</c:if>
							<td>
								<font style="color:black;">责任人：</font>{{row.principal}}
							</td>
							<td <c:if test="${todo ne 'a2'}">colspan="2"</c:if>>
								<font style="color:black;">完成时间：</font>{{row.finishtime}}
							</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">改进项内容：</font>{{row.content}}</td>
						</tr>
						<c:if test="${todo ne 'a2'}">
						<tr>
							<td colspan="6"><font style="color:black;"><p style="color:black;line-height: 20px;">实施历史：</p>
								<input class="rowdata" type="hidden" name="da_{{row.id}}" value="{{row.attribute2}}"/>
								<p id="da_{{row.id}}" style="text-indent:2em;line-height: 20px;"></p></td>
						</tr>
						<tr>
							<td colspan="6"><p style="color:black;line-height: 20px;">改进项成果：</p>
								<input id="improvementsList{{idx}}_attachment" name="improvementsList[{{idx}}].attachment" type="hidden" value="{{row.attachment}}" maxlength="1024"/>
								<sys:ckfinder input="improvementsList{{idx}}_attachment" type="files" uploadPath="/zhuzi/formation" selectMultiple="true"/>
                            </td>
						</tr>
						<c:if test="${ecppConfig.attribute1 ==1}">
						<tr>
							<td colspan="6"><font style="color:black;">1阶段措施实施情况小结：</font>{{row.attribute3}}</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">1阶段提升效益：</font>{{row.money1}}</td>
						</tr>
						</c:if>
						<c:if test="${ecppConfig.attribute2 ==1}">
						<tr>
							<td colspan="6"><font style="color:black;">2阶段措施实施情况小结：</font>{{row.attribute4}}</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">2阶段提升效益：</font>{{row.money2}}</td>
						</tr>
						</c:if>
						</c:if>

						//-->
					</script>
							<!-- <td class="alignCenter">
								<div class="progress clearMar">
					  				<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: {{row.improvementprogress}}%;">
					    				{{row.improvementprogress}}%
					  				</div>
								</div>
							</td> -->
				<script type="text/javascript">
					var improvementsRowIdx = 0, improvementsTpl = $("#improvementsTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
					$(document).ready(function() {
						var data = ${fns:toJson(planinformation.improvementsList)};
						for (var i=0; i<data.length; i++){
							addRow('#improvementsList', improvementsRowIdx, improvementsTpl, data[i]);
							improvementsRowIdx = improvementsRowIdx + 1;
						}
                        $(".rowdata").each(function(){
                            var content = $(this).val();
                            var obj = document.getElementById($(this).context.name);
                            obj.style.color = "#3d99e4";
                            obj.innerHTML = content;
                        });
					});
				</script>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<p class="con">${planinformation.remarks}</p>
			</div>
		</div> --%>
		<%-- <div class="control-group">
			<label class="control-label">得分：</label>
			<div class="controls">
				<p class="con">${planinformation.selfevaluationscore}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自我评价：</label>
			<div class="controls">
				<p class="con">${planinformation.selfevaluation}</p>
			</div>
		</div> --%>
				<c:if test="${!empty resultrecord.opinion}">
					<div class="control-group">
						<label class="control-label"><font style="color:black;">改革小组意见：</font></label>
						<div class="controls">
							<p class="con">${resultrecord.opinion}</p>
						</div>
					</div>
				</c:if>		
				 <c:if test="${!empty planinformation.selfevaluationscore}">
					<div class="control-group">
						<label class="control-label"><font style="color:black;">得分：</font></label>
						<div class="controls">
							<p class="con">${planinformation.selfevaluationscore}</p>
						</div>
					</div>
				</c:if>
						<input type="hidden" id="selfevaluation" value="${planinformation.selfevaluation}" />	
				<c:if test="${!empty planinformation.selfevaluation}">
					<div class="control-group">
						<%-- <label class="control-label">自我评价：</label>
						<div class="controls">
							<p class="con">${planinformation.selfevaluation}</p>
						</div> --%>
						<div class="file" id="fileBox">
						自我评价：
						</div>
					</div>
				</c:if>
				<c:if test="${!empty planinformation.evaluationscore}">
					<div class="control-group">
						<label class="control-label"><font style="color:black;">得分：</font></label>
						<div class="controls">
							<p class="con">${planinformation.evaluationscore}</p>
						</div>
					</div>
				</c:if>
				<c:if test="${!empty planinformation.organisationalmeasures}">
					<c:if test="${planinformation.attribute11==1}">
						<div class="control-group">
							<label class="control-label"><font style="color:black;">组织评价：</font></label>
							<div class="controls">
								<p class="con">${planinformation.organisationalmeasures}</p>
							</div>
						</div>
					</c:if>
				</c:if>
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>