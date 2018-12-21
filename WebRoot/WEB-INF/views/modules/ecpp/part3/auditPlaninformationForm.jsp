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
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecpp/planinformation/a3List?unit.id=${planinformation.unit.id}&unit.type=${planinformation.unit.type}">目标列表</a></li>
		<%-- <li class="active"><a href="${ctx}/ecpp/planinformation/a3Form?id=${planinformation.id}">目标改进项<shiro:hasPermission name="ecpp:planinformation:edit">${not empty planinformation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="ecpp:planinformation:edit">查看</shiro:lacksPermission></a></li> --%>
		<li class="active"><a href="${ctx}/ecpp/planinformation/a3Form?id=${planinformation.id}">进度更新</a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/a3Save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
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
			<label class="control-label">总体进度：</label>
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
		<div class="control-group">
			<label class="control-label">改进项：</label>
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
				<script type="text/template" id="improvementsTpl">//<!--
						<tr id="improvementsList{{idx}}">
							<td class="hide">
								<input id="improvementsList{{idx}}_id" name="improvementsList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="improvementsList{{idx}}_delFlag" name="improvementsList[{{idx}}].delFlag" type="hidden" value="0"/>
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
							<td style="text-align:left;" colspan="6">
							<font style="color:black;">改进项内容：</font>{{row.content}}
							</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<td style="text-align:left;" colspan="6"><p style="color:black;line-height: 20px;">实施历史：</p>
								<input class="rowdata" type="hidden" name="da_{{row.id}}" value="{{row.attribute2}}"/>
								<p id="da_{{row.id}}" style="text-indent: 2em;line-height: 20px;"></p></td>
						</tr>
						<tr>
							<td colspan="6">改进项成果：
								<input id="improvementsList{{idx}}_attachment" name="improvementsList[{{idx}}].attachment" type="hidden" value="{{row.attachment}}" maxlength="1024"/>
								<sys:ckfinder input="improvementsList{{idx}}_attachment" type="files" uploadPath="/zhuzi/formation" selectMultiple="true"/>
                            </td>
						</tr>
					<c:if test="${ecppConfig.attribute1 ==1}">
						<tr id="improvementsListText{{idx}}">
							<td style="text-align:left;" colspan="6"><font style="color:black;">1阶段措施实施情况小结：</font>{{row.attribute3}}</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">1阶段提升效益：</font>{{row.money1}}</td>
						</tr>
					</c:if>
					<c:if test="${ecppConfig.attribute2 == 1}">
						<tr id="improvementsListText{{idx}}">
							<td style="text-align:left;" colspan="6">
							<font style="color:black;">2阶段措施实施情况小结：</font>{{row.attribute4}}
							</td>
						</tr>
						<tr>
							<td colspan="6"><font style="color:black;">2阶段提升效益：</font>{{row.money2}}</td>
						</tr>
					</c:if>
						<tr id="improvementsListText{{idx}}" style="border-top:1px solid #e2e2e2 !important;margin-bottom:20px !important;height:15px;">
							<td colspan="5">
							</td>
						</tr>
						//-->
					</script>
					
<%-- 				var improvementsRowIdx = 0, improvementsTpl = $("#improvementsTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
					$(document).ready(function() {
						var data = ${fns:toJson(planinformation.improvementsList)};
						for (var i=0; i<data.length; i++){
							addRow('#improvementsList', improvementsRowIdx, improvementsTpl, data[i]);
							improvementsRowIdx = improvementsRowIdx + 1;
						}
					}); --%>
					
					
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
			<label class="control-label">提升历史：</label>
			<div class="controls">
					${planinformation.situationandeffect}
			</div>
		</div>
		<%--<div class="control-group">
			<label class="control-label">提升情况及效果：</label>
			<div class="controls">
				<p class="con">${resultrecord.situationandresults}</p>
			</div>
		</div>--%>
		<div class="control-group">
			<label class="control-label" style="width: 130px;">改革小组建议：</label>
			<div class="controls">
				<form:textarea path="groupproposal.opinion" htmlEscape="false" rows="2" cols="300" maxlength="2048" style="width:90%;" class="input-xxlarge "/><br/><br/>
				<c:forEach items="${resultrecords}" var="res" varStatus="i">
					<pre style="width:90%;">${i.index+1}.${res.opinion} <fmt:formatDate value="${res.opinionchangedate}" pattern="yyyy年 MM月 dd日  HH时:mm分"/></pre>
				</c:forEach>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="ecpp:planinformation:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>