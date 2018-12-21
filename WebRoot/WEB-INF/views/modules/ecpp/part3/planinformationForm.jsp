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
            background: #fff;
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
			<label class="control-label">负责人：</label>
			<div class="controls">
				<p class="con">${planinformation.planprincipal}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">改进项信息表：</label>
			<div class="controls">
				<table id="contentTable" class="table table-striped table-bordered table-condensed">
					<thead>
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
					</thead>
					<tbody id="improvementsList">
					</tbody>
				</table>
				<script type="text/template" id="improvementsTpl">//<!--
						<tr id="improvementsList{{idx}}">
							<td class="hide">
								<input id="improvementsList{{idx}}_id" name="improvementsList[{{idx}}].id" type="hidden" value="{{row.id}}"/>
								<input id="improvementsList{{idx}}_delFlag" name="improvementsList[{{idx}}].delFlag" type="hidden" value="0"/>
							</td>
							<td>{{row.improvedtitle}}</td>
							<td>{{row.weight}}%</td>
							<td>{{row.principal}}</td>
							<td>
								<input id="improvementsList{{idx}}_attachment" name="improvementsList[{{idx}}].attachment" type="hidden" value="{{row.attachment}}" maxlength="1024"/>
								<sys:ckfinder input="improvementsList{{idx}}_attachment" type="files" uploadPath="/zhuzi/formation" selectMultiple="true"/>
							</td>
							<td>
								<div id="progress{{idx}}" class="progressnew">
			    					<div id="progress_bg{{idx}}" class="progress_bgnew">
			        					<div id="progress_bar{{idx}}" class="progress_barnew" style="width:{{row.improvementprogress}}px;"></div>
			    					</div>
			    					<div id="progress_btn{{idx}}" onmousemove="btnClick({{idx}})" class="progress_btnnew" style="left:{{row.improvementprogress}}px;"></div>
			    					<div id="text{{idx}}" class="textnew">{{row.improvementprogressTureValue}}%</div>
								</div>
								<input id="improvementsList{{idx}}_improvementprogress" name="improvementsList[{{idx}}].improvementprogress" type="hidden" value="{{row.improvementprogressTureValue}}" class="input-small "/>
							</td>
							<td><a href="${ctx}/ecpp/planinformation/contentForm/?itemid={{row.id}}">{{row.content}}</a></td>
							<td>{{row.finishtime}}</td>
							<td>{{row.remarks}}</td>
						</tr>//-->
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
		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<p class="con">${planinformation.remarks}</p>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">提升情况及效果：</label>
			<div class="controls">
				<form:textarea path="situationandeffect" htmlEscape="false" rows="12" cols="400" maxlength="2048" class="input-xxlarge moreLong"/>
			</div>
		</div>
		<!-- <div class="control-group">
			<div id="progress1" class="progressnew">
			    <div id="progress_bg1" class="progress_bgnew">
			        <div id="progress_bar1" class="progress_barnew"></div>
			    </div>
			    <div id="progress_btn1" onmousemove="btnClick(1)" class="progress_btnnew"></div>
			    <div id="text1" class="textnew">0%</div>
			</div>
		</div> -->
		<div class="form-actions">
			<shiro:hasPermission name="ecpp:planinformation:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
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