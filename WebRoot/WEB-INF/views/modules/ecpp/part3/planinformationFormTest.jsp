<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>目标改进项管理</title>
	<meta name="decorator" content="default"/>
	<style type="text/css">
		*{
			font-size:16px !important;
		}
		p.con{
			margin: 5px 0px 10px;
		}
		    .progressnew {
            position: relative;
            width: 300px;
            text-align:center;
        }

        .progress_bgnew {
            height: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            overflow: hidden;
            background-color: #f2f2f2;
        }

        .progress_barnew {
            background: #5FB878;
            width: 0;
            height: 10px;
            border-radius: 5px;
        }

        .progress_btnnew {
            width: 20px;
            height: 20px;
            border-radius: 5px;
            position: absolute;
            background: #F7B824;
            left: 0px;
            margin-left: -10px;
            top: -5px;
            cursor: pointer;
            border: 1px #ddd solid;
            box-sizing: border-box;
        }

        .progress_btnnew:hover {
            border-color: #F7B824;
        }
        .moreLong{
        	width:700px;
        }

	</style>
	<script type="text/javascript">


		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
                    loadingTimeOut('正在提交，请稍等...',form);
				},

                showErrors : function(errorMap, errorList) {
				 var msg = "";
				 $.each(errorList, function(i, v) {
				 //console.log(v.message);
				 	msg = (v.message + "\r\n");
				 });
				 if (msg != "")
				 	$.jBox.messager(msg,'提示');
				 },
				 /* 失去焦点时不验证 */
				 onfocusout : false,



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
       /* jQuery.validator.addMethod("checkOne", function() {

            //return $("#effectivenessmoney1").val()!="" || $("#effectivenessmoney2").val()!="" || $("#effectivenessmoney3").val()!="" || $("#effectivenessmoney4").val()!="" || $("#effectivenessmoney5").val()!="" || $("#effectivenessmoney6").val()!="";
            return ($("#effectivenessmoney1").val()!="") || ($("#effectivenessmoney2").val()!="") || ($("#effectivenessmoney3").val()!="") || ($("#effectivenessmoney4").val()!="") || ($("#effectivenessmoney5").val()!="") || ($("#effectivenessmoney6").val()!="");
        }, "减两金、降成本、提效益、增效益、降负债、减费用，至少填写其中一下，且大于0！");*/

        jQuery.validator.addMethod("isFloatNEqZero", function(value, element) {
            value=parseFloat(value);
            return this.optional(element) || value!=0;
        }, "输入值必须大于0！");
        // 判断整数value是否大于0
        jQuery.validator.addMethod("isIntGtZero", function(value, element) {
            value=parseInt(value);
            return this.optional(element) || value>0;
        }, "输入值必须大于0");




        function addRow(list, idx, tpl, row,indexNum){
            var newTitle = row.improvedtitle;
            row.improvedtitle = newTitle.substring(0,10)+"...";
            $(list).append(Mustache.render(tpl, {
				idx: idx, delBtn: true, row: row,indexNum:indexNum
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
		tr:last-child{
			border-top:0px solid black !important;height:0px;
		}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/ecpp/planinformation/u3List">目标列表</a></li>
		<li class="active"><a href="${ctx}/ecpp/planinformation/u3Form?id=${planinformation.id}">目标改进项<shiro:hasPermission name="ecpp:planinformation:edit">${not empty planinformation.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="ecpp:planinformation:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/u3Save" method="post" class="form-horizontal">
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
		<div class="control-group">
			<div style="float: left">
				<label class="control-label">减两金：</label>
				<div class="controls">
					<form:input path="effectivenessmoney1" id="effectivenessmoney1" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-small isIntGtZero isFloatNEqZero"/>万元
				</div>
				</div>
			<div style="float: left">
				<label class="control-label">备注：</label>
				<div class="controls">
					<form:input path="effremarks1" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-xxlarge"/>&nbsp;&nbsp;<span style="color: #a29c9c;">二十字以内</span>
				</div>
			</div>
		</div>

		<div class="control-group">
			<div style="float: left">
				<label class="control-label">降成本：</label>
				<div class="controls">
					<form:input path="effectivenessmoney2" id="effectivenessmoney2" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-small isIntGtZero isFloatNEqZero"/>万元
				</div>
				</div>
			<div style="float: left">
				<label class="control-label">备注：</label>
				<div class="controls">
					<form:input path="effremarks2" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-xxlarge"/>&nbsp;&nbsp;<span style="color: #a29c9c;">二十字以内</span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div style="float: left">
				<label class="control-label">提效益：</label>
				<div class="controls">
					<form:input path="effectivenessmoney3" id="effectivenessmoney3" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-small isIntGtZero isFloatNEqZero"/>%&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				</div>
			<div style="float: left">
				<label class="control-label">备注：</label>
				<div class="controls">
					<form:input path="effremarks3" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-xxlarge"/>&nbsp;&nbsp;<span style="color: #a29c9c;">二十字以内</span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div style="float: left">
				<label class="control-label">增效益：</label>
				<div class="controls">
					<form:input path="effectivenessmoney4" id="effectivenessmoney4" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-small isIntGtZero isFloatNEqZero"/>万元
				</div>
				</div>
			<div style="float: left">
				<label class="control-label">备注：</label>
				<div class="controls">
					<form:input path="effremarks4" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-xxlarge"/>&nbsp;&nbsp;<span style="color: #a29c9c;">二十字以内</span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div style="float: left">
				<label class="control-label">降负债：</label>
				<div class="controls">
					<form:input path="effectivenessmoney5" id="effectivenessmoney5" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-small isIntGtZero isFloatNEqZero"/>%&nbsp;&nbsp;&nbsp;&nbsp;
				</div>
				</div>
			<div style="float: left">
				<label class="control-label">备注：</label>
				<div class="controls">
					<form:input path="effremarks5" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-xxlarge"/>&nbsp;&nbsp;<span style="color: #a29c9c;">二十字以内</span>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div style="float: left">
				<label class="control-label">减费用：</label>
				<div class="controls">
					<form:input path="effectivenessmoney6" id="effectivenessmoney6" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-small isIntGtZero isFloatNEqZero"/>万元
				</div>
				</div>
			<div style="float: left">
				<label class="control-label">备注：</label>
				<div class="controls">
					<form:input path="effremarks6" htmlEscape="false" rows="6" cols="400" maxlength="20" class="input-xxlarge"/>&nbsp;&nbsp;<span style="color: #a29c9c;">二十字以内</span>

				</div>
			</div>
		</div>

		<div class="control-group">
			<label class="control-label">改进项：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<tbody id="improvementsList">
					</tbody>
				</table>

				<script type="text/template" id="improvementsTpl">//<!--
						<tr id="improvementsList{{idx}}" style="white-space: nowrap;">
							<td class="hide">
								<input id="improvementsList{{idx}}_id" name="improvementsList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="improvementsList{{idx}}_delFlag" name="improvementsList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>
								<label>{{indexNum}}、标题：{{row.improvedtitle}} </label>
							</td>
							<td>
								<label>权重：{{row.weight}}%</label>
							</td>
							<td>
								<label>责任人：{{row.principal}}</label>
							</td>
							<td style="text-align:center;">
									<div class="" style="display:inline-block;margin-left:0px !important;">
									<span style="display:block;">进度：</span>
										<div id="progress{{idx}}" class="progressnew">
			    					<div id="progress_bg{{idx}}" class="progress_bgnew">
			        					<div id="progress_bar{{idx}}" class="progress_barnew" style="width:{{row.progrcess}}px;"></div>
			    					</div>
			    					<div id="progress_btn{{idx}}" onmousemove="btnClick({{idx}})" class="progress_btnnew" style="left:{{row.progrcess}}px;"></div>
			    					<div id="text{{idx}}" class="textnew">{{row.improvementprogress}}%</div>
								</div>
								<input id="improvementsList{{idx}}_improvementprogress" readonly name="improvementsList[{{idx}}].improvementprogress" type="hidden" value="{{row.improvementprogress}}" class="input-small "/>
							</div>
							</td>
							<td>
								<label style="white-space: nowrap" style="padding-top:0px;">完成时间：{{row.finishtime}}</label>
							</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<%--<td style="text-align:right;">改进项内容：{{row.content}}</td>--%>
							<td colspan="5">
								改进项内容：{{row.content}}
								<%--<textarea id="improvementsList{{idx}}_content" readonly name="improvementsList[{{idx}}].content" rows="5" style="width:98%;margin-bottom:18px;" cols="1000" maxlength="50000">{{row.content}}</textarea>--%>
							</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<%--<td style="text-align:right;">实施历史：{{row.attribute2}}</td>--%>
							<td colspan="5">
								<p style="color:black;line-height: 20px;">实施历史：</p>
								<%--<input class="rowdata" type="hidden" name="da_{{row.id}}" value="{{row.attribute2}}"/>--%>		
								<%--<pre id="da_{{row.id}}" style="width:89%;"></pre>--%>

								<input class="rowdata" type="hidden" name="da_{{row.id}}" value="{{row.attribute2}}"/>
								<p id="da_{{row.id}}" style="text-indent: 2em;line-height: 20px;"></p>
							</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<td colspan="5">实施日志：
								<input id="improvementsList{{idx}}_attribute6" name="improvementsList[{{idx}}].attribute6" style="width:98%;margin-bottom:18px;" type="text" value="{{row.attribute6}}" class="input-small "/>
							</td>
						</tr>
						<tr>
							<td colspan="5">改进项成果：
								<input id="improvementsList{{idx}}_attachment" name="improvementsList[{{idx}}].attachment" type="hidden" value="{{row.attachment}}" maxlength="1024"/>
								<sys:ckfinder input="improvementsList{{idx}}_attachment" type="files" uploadPath="/zhuzi/formation" selectMultiple="true"/>
                            </td>
						</tr>
						<c:if test="${ecppConfig.attribute1 ==1}">
						<tr id="improvementsListText{{idx}}">
							<td style="text-align:right;">1阶段措施实施情况小结：</td>
							<td colspan="4">
								<textarea id="improvementsList{{idx}}_attribute3" name="improvementsList[{{idx}}].attribute3" rows="5" style="width:98%;margin-bottom:18px;" cols="1000" maxlength="50000">{{row.attribute3}}</textarea>
							</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<td style="text-align:right;">1阶段提升效益：</td>
							<td colspan="4">
								<input id="improvementsList{{idx}}_money1" name="improvementsList[{{idx}}].money1" type="text" value="{{row.money1}}" class="input-small "/>元
							</td>
						</tr>
						</c:if>
						<c:if test="${ecppConfig.attribute2 ==1}">
						<tr id="improvementsListText{{idx}}">
							<td style="text-align:right;">2阶段措施实施情况小结：</td>
							<td colspan="4">
								<textarea id="improvementsList{{idx}}_attribute4" name="improvementsList[{{idx}}].attribute4" rows="5" style="width:98%;margin-bottom:18px;" cols="1000" maxlength="50000">{{row.attribute4}}</textarea>
							</td>
						</tr>
						<tr id="improvementsListText{{idx}}">
							<td style="text-align:right;">2阶段提升效益：</td>
							<td colspan="4">
								<input id="improvementsList{{idx}}money2" name="improvementsList[{{idx}}].money2" type="text" value="{{row.money2}}" class="input-small "/>元
							</td>
						</tr>
						</c:if>
						<%--<tr id="improvementsListText{{idx}}" style="border-top:1px solid #e2e2e2 !important;margin-bottom:20px !important;height:15px;">
							<td colspan="5">
							</td>
						</tr>--%>//-->
					</script>
			</div>
		</div>
		<%-- <div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<p class="con">${planinformation.remarks}</p>
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">提升历史：</label>
			<div class="controls">
				${planinformation.situationandeffect}
				<%-- <form:textarea path="situationandeffect" htmlEscape="false" rows="6" cols="400" maxlength="2048" class="input-xxlarge moreLong"/> --%>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提升日志：</label>
			<div class="controls">
				<form:input path="tishengrizhi" htmlEscape="false" rows="6" cols="400" maxlength="2048" class="input-xxlarge"/>
			</div>
		</div>

		<c:if test="${ecppConfig.attribute1 ==1}">
		<div class="control-group">
			<label class="control-label">1阶段提升效果说明：</label>
			<div class="controls">
				<form:textarea path="attribute10" htmlEscape="false" rows="6" cols="400" maxlength="2048" class="input-xxlarge moreLong"/>
			</div>
		</div>
		</c:if>
		<c:if test="${ecppConfig.attribute2 ==1}">
		<div class="control-group">
			<label class="control-label">2阶段提升效果说明：</label>
			<div class="controls">
				<form:textarea path="attribute11" htmlEscape="false" rows="6" cols="400" maxlength="2048" class="input-xxlarge moreLong"/>
			</div>
		</div>
		</c:if>
		<div class="control-group">
			<label class="control-label" style="width:130px;">改革小组建议：</label>
			<div class="controls">
				<c:forEach items="${resultrecords}" var="res" varStatus="i">
					<pre style="width:90%;">${i.index+1}.${res.opinion} <fmt:formatDate value="${res.opinionchangedate}" pattern="yyyy年 MM月 dd日  HH时:mm分"/></pre>
				</c:forEach>
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="ecpp:planinformation:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="更新"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
	<script type="text/javascript">
        var improvementsRowIdx = 0, improvementsTpl = $("#improvementsTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
        var indexNum = 1;
        $(document).ready(function() {
            var data = ${fns:toJson(planinformation.improvementsList)};
            for (var i=0; i<data.length; i++){
                addRow('#improvementsList', improvementsRowIdx, improvementsTpl, data[i],indexNum);
                improvementsRowIdx = improvementsRowIdx + 1;
                indexNum = indexNum + 1;
            }
           $(".rowdata").each(function(){
                var content = $(this).val();
                var obj = document.getElementById($(this).context.name);
               obj.style.color = "#3d99e4";
               obj.innerHTML = content;
            });
        });
	</script>
<script>
    var tag = false, ox = 0, left = 0, bgleft = 0;
    function btnClick(el) { 	
    	var str = $('#progress_btn'+el).css('left');
    	left = parseInt(str);
        $('#progress_btn'+el).mousedown(function (e) {
            ox = e.pageX - left;
            tag = true;
        });
        $(document).mouseup(function () {
            tag = false;
            
            $('#improvementsList'+el+'_improvementprogress').val(parseInt($('#text'+el).text()));
        });
        $('#progress'+el).mousemove(function (e) {//鼠标移动
            if (tag) {
                left = e.pageX - ox;
                if (left <= 0) {
                    left = 0;
                } else if (left > 300) {
                    left = 300;
                }
                $('#progress_btn'+el).css('left', left);
                $('#progress_bar'+el).width(left);
                $('#text'+el).html(parseInt((left / 300) * 100) + '%');
            }
        });
    }
</script>
</body>
</html>