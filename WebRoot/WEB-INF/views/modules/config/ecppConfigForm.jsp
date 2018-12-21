<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>管理提升控制信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
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
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/config/ecppConfig/form?id=${ecppConfig.id}">阶段时间控制
		<shiro:lacksPermission name="config:ecppConfig:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="ecppConfig" action="${ctx}/config/ecppConfig/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">名称：</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="80" class="input-xlarge "/>
				&nbsp;&nbsp;状态:
				<form:select path="isstart" class="input-xlarge " style="width:70px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<div class="control-label">第一阶段名称：</div>
			<div class="controls">
				<form:input path="firstname" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				&nbsp;&nbsp;状态:
				<form:select path="firstisstart" class="input-xlarge " style="width:70px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动时间：</label>
			<div class="controls">
				<input id="firststartdate" name="firststartdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.firststartdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'firstenddate\')}'})"/> 
					-
					<input id="firstenddate" name="firstenddate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.firstenddate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'firststartdate\')}'})"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第二阶段名称：</label>
			<div class="controls">
				<form:input path="secondname" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				&nbsp;&nbsp;状态:
				<form:select path="secondisstart" class="input-xlarge " style="width:70px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动时间：</label>
			<div class="controls">
				<input id="secondstartdate" name="secondstartdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.secondstartdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'secondenddate\')}'})"/> 
					-
				<input id="secondenddate" name="secondenddate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.secondenddate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'secondstartdate\')}'})"/>					
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第三阶段名称：</label>
			<div class="controls">
				<form:input path="thirdname" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				&nbsp;&nbsp;状态:
				<form:select path="thirdisstart" class="input-xlarge " style="width:70px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>				
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动时间：</label>
			<div class="controls">
				<input id="thirdstartdate" name="thirdstartdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.thirdstartdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'thirdenddate\')}'})"/> 
					-
				<input id="thirdenddate" name="thirdenddate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.thirdenddate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'thirdstartdate\')}'})"/>					
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">第四阶段名称：</label>
			<div class="controls">
				<form:input path="fouthname" htmlEscape="false" maxlength="100" class="input-xlarge "/>
				&nbsp;&nbsp;状态:
				<form:select path="fouthisstart" class="input-xlarge " style="width:70px;">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('state')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">活动时间：</label>
			<div class="controls">
				<input id="fouthstartdate" name="fouthstartdate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.fouthstartdate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'fouthenddate\')}'})"/> 
					-
				<input id="fouthenddate" name="fouthenddate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${ecppConfig.fouthenddate}" pattern="yyyy-MM-dd"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'fouthstartdate\')}'})"/>					
			</div>
		</div>
<%-- 		<div class="control-group">
			<label class="control-label">备注：</label>
			<div class="controls">
				<form:input path="remarks" htmlEscape="false" maxlength="1024" class="input-xlarge "/>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="config:ecppConfig:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>