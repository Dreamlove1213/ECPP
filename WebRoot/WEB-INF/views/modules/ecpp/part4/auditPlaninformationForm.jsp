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
			var string = new Array()
			var fileName = new Array()
			string = attachment.split("|");
			for(var i=1; i<string.length; i++){
				fileName[i] = decodeURIComponent(string[i].substring(string[i].lastIndexOf("/")+1));
				$("#fileBox").append("<p style='padding-left:80px;line-height:16px;'><a href='"+string[i]+"'>"+fileName[i]+"</a></p>");
			}
			
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
	.control-label{color:black !important;}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecpp/planinformation/a4List?unit.id=${planinformation.unit.id}&unit.type=${planinformation.unit.type}">目标列表</a></li>
		<li class="active"><a href="${ctx}/ecpp/planinformation/a4Form?id=${planinformation.id}">目标改进项<shiro:hasPermission name="ecpp:planinformation:edit">${not empty planinformation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="ecpp:planinformation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/a4Save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<form:hidden id="sturts" path="sturts"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">目标标题：</label>
			<div class="controls">
				<p class="con">${planinformation.plantitle}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">问题描述：</label>
			<div class="controls">
				<p class="con">${planinformation.problemdescription}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标类型：</label>
			<div class="controls">
				<p class="con">${fns:getDictLabel(planinformation.plantype, 'ecpp_plan_type', '')}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总体目标：</label>
			<div class="controls">
				<p class="con">${planinformation.overallgoals}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">总进度：</label>
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
		<div class="control-group">
			<label class="control-label">负责人：</label>
			<div class="controls">
				<p class="con">${planinformation.planprincipal}</p>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">目标执行进度：</label>
			<div class="controls">
				<form:input path="plannedprogress" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">单位自我评价：</label>
			<div class="controls">
				<form:textarea path="selfevaluation" htmlEscape="false" rows="4" maxlength="2048" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自我评价得分：</label>
			<div class="controls">
				<form:input path="selfevaluationscore" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">自我评价时间：</label>
			<div class="controls">
				<input name="evaluationdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${planinformation.evaluationdate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">改革小组建议：</label>
			<div class="controls">
				<form:textarea path="groupproposal" htmlEscape="false" rows="4" maxlength="2048" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">改革小组建议提出时间：</label>
			<div class="controls">
				<input name="outgroupproposaldate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${planinformation.outgroupproposaldate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">组织评价：</label>
			<div class="controls">
				<form:textarea path="organisationalmeasures" htmlEscape="false" rows="4" maxlength="2048" class="input-xxlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">组织评价得分：</label>
			<div class="controls">
				<form:input path="evaluationscore" htmlEscape="false" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">组织评价时间：</label>
			<div class="controls">
				<input name="organisationadodate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${planinformation.organisationadodate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">状态：</label>
			<div class="controls">
				<form:input path="status" htmlEscape="false" maxlength="64" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">改进项：</label><br>
			<div class="controls">
				<table id="contentTable" class="table table-bordered table-condensed">
					<!-- <thead>
						<tr>
							<th class="hide"></th>
							<th>改进项标题</th>
							<th>权重</th>
							<th>责任人</th>
							<th>改进项进度</th>
							<th>内容</th>
							<th>完成时间</th>
							<th>备注</th>
						</tr>
					</thead> -->
					<tbody id="improvementsList">
					</tbody>
				</table>
				<!-- <script type="text/template" id="improvementsTpl">//<!--
						<tr id="improvementsList{{idx}}">
							<td class="hide">
								<input id="improvementsList{{idx}}_id" name="improvementsList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="improvementsList{{idx}}_delFlag" name="improvementsList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>{{row.improvedtitle}}</td>
							<td>{{row.weight}}</td>
							<td>{{row.principal}}</td>
							<td>
								<div class="progress clearMar">
					  				<div class="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: {{row.improvementprogress}}%;">
					    				{{row.improvementprogress}}%
					  				</div>
								</div>
							</td>
							<td>{{row.content}}</td>
							<td>{{row.finishtime}}</td>
							<td>{{row.remarks}}</td>
						</tr>//
					</script>-->
					
				<script type="text/template" id="improvementsTpl">//<!--
						<tr id="improvementsList{{idx}}">
							<td class="hide">
								<input id="improvementsList{{idx}}_id" name="improvementsList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="improvementsList{{idx}}_delFlag" name="improvementsList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<font style="color:black;">序号：</font>{{idx}}
							</td>
							<td>
								<font style="color:black;">标题：</font>{{row.improvedtitle}}
							</td>
							<td>
								<font style="color:black;">权重：</font>{{row.weight}}
							</td>
							<td>
								<font style="color:black;">责任人：</font>{{row.principal}}
							</td>
							<td>
								<font style="color:black;">进度：</font>{{row.improvementprogress}}
							</td>
							<td>
								<font style="color:black;">完成时间：</font>{{row.finishtime}}
							</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<td colspan="6"><font style="color:black;">改进项内容：</font>{{row.content}}</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<td colspan="6"><font style="color:black;"><p style="color:black;line-height:20px;">实施历史：</p>
								<input class="rowdata" type="hidden" name="da_{{row.id}}" value="{{row.attribute2}}"/>
								<p id="da_{{row.id}}" style="text-indent: 2em;line-height: 20px;"></p>
							</td>
						</tr>
						<tr>
							<td colspan="6"><p style="line-height:20px;">改进项成果：</p>
								<input id="improvementsList{{idx}}_attachment" name="improvementsList[{{idx}}].attachment" type="hidden" value="{{row.attachment}}" maxlength="1024"/>
								<sys:ckfinder input="improvementsList{{idx}}_attachment" type="files" uploadPath="/zhuzi/formation" selectMultiple="true"/>
                            </td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">得分：</font>{{row.score}}</td>
						</tr>
						<c:if test="${ecppConfig.attribute1 =='1'}">
						<tr id="improvementsListText{{idx}}">
							<td colspan="6"><font style="color:black;">1阶段措施实施情况小结：</font>{{row.attribute3}}</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">1阶段提升效益：</font>{{row.money1}}</td>
						</tr>
						</c:if>
						<c:if test="${ecppConfig.attribute2 =='1'}">
						<tr id="improvementsListText{{idx}}">
							<td colspan="6"><font style="color:black;">2阶段措施实施情况小结：</font>{{row.attribute4}}</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">1阶段提升效益：</font>{{row.money1}}</td>
						</tr>
						</c:if>
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
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<p class="con">${planinformation.remarks}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">目标分：</label>
			<div class="controls">
				<p class="con">${planinformation.selfevaluationscore}</p>
			</div>
		</div>
		<div class="control-group">
			<input type="hidden" id="selfevaluation" value="${planinformation.selfevaluation}" />
		</div>
		<div class="control-group">
			<label class="control-label">组织评价得分：</label>
			<div class="controls">
				<form:input path="evaluationscore" class="input-xxlarge number required" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">组织评价：</label>
			<div class="controls">
				<form:textarea path="organisationalmeasures" readonly="ture" htmlEscape="false" rows="4" cols="300" maxlength="2048" class="input-xxlarge "/>
			</div>
		</div>
		
		<div class="form-actions">
			<shiro:hasPermission name="ecpp:planinformation:edit">
			<c:if test="${planinformation.attribute11!='1'}">
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提 交" onclick="$('#sturts').val('1')"/>&nbsp;
				<input id="btnSubmit2" class="btn btn-primary" type="submit" value="保 存" onclick="$('#sturts').val('0')"/>&nbsp;
			</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>