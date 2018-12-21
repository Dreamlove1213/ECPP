<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>目标改进项管理</title>
	<meta name="decorator" content="default"/>
	<script src="${ctxStatic}/indexPageStyle/layer/layer.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#tongyitijiao").on("click",function(){
                //询问框
				var isEmpty = '${isEmpty}';

				if(isEmpty == '1'){
                    layer.confirm('当前提交列表中含有驳回后未修改的目标，确认要提交吗？', {
                        btn: ['确定','取消'] //按钮
                    }, function(){
                        $.post("${ctx}/ecpp/planinformation/u2allUp",function(data){
                            if(data.dataStatus != undefined && data.dataStatus =="1"){
                                layer.msg(data.message, {icon: 1});
                            }else if(data.dataStatus != undefined && data.dataStatus =="2"){
                                layer.msg(data.message, {icon: 1});
							}else if(data.dataStatus != undefined && data.dataStatus =="3"){
                                layer.msg(data.message, {icon: 1});
                                setTimeout(function(){location.reload(); }, 1500);
							}else if(data.dataStatus != undefined && data.dataStatus =="4"){
                                layer.msg("当前没有需要提交的数据！！", {icon: 1});
							}else{
                                layer.msg("系统异常！", {icon: 1});
							}
                        });
                    });
				}else{
                    layer.confirm('确认要提交吗？', {
                        btn: ['确定','取消'] //按钮
                    }, function(){
                        $.post("${ctx}/ecpp/planinformation/u2allUp",function(data){
                            if(data.dataStatus != undefined && data.dataStatus =="1"){
                                layer.msg(data.message, {icon: 1});
                            }else if(data.dataStatus != undefined && data.dataStatus =="2"){
                                layer.msg(data.message, {icon: 1});
                            }else if(data.dataStatus != undefined && data.dataStatus =="3"){
                                layer.msg(data.message, {icon: 1});
                                setTimeout(function(){location.reload(); }, 1500);
                            }else if(data.dataStatus != undefined && data.dataStatus =="4"){
                                layer.msg("当前没有需要提交的数据！！", {icon: 1});
                            }else{
                                layer.msg("系统异常！", {icon: 1});
                            }
                        });
                    });
				}
				//修改统一提交时，没有需要提交的内容时的提示信息



			   /* var messgages = "确认要统一提交吗？提交后不可修改！";
                var status = confirm(messgages);
                if(status == true){
                    $.post("/ecpp/planinformation/u2allUp",function(data){
                        if(data != undefined && data ==1){
                            $.jBox.messager("提交成功！","提示");
                            setTimeout(function(){location.reload(); }, 1500);
                        }else{
                            $.jBox.messager("当前没有需要提交的数据！！","提示");
                        }
                    });
				}*/
			});
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/ecpp/planinformation/u2List">目标列表</a></li>
		<shiro:hasPermission name="ecpp:planin:edit"><li><a href="${ctx}/ecpp/planinformation/u2Form">新建目标</a></li></shiro:hasPermission>
		<%-- <li><a href="${ctx}/ecpp/planinformation/Analysis">统计分析</a></li> --%>
	</ul>
	<form:form id="searchForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/u2List" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<%-- <li><label>目标标题：</label>
				<form:input path="plantitle" htmlEscape="false" maxlength="50" class="input-medium" />
			</li>
			<li><label>目标类型：</label>
				<form:select path="plantype" class="input-medium">
					<form:option value="" label=""/>
					<form:options items="${fns:getDictList('ecpp_plan_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
				</form:select>
			</li>
			<li><label>负责人：</label>
				<form:input path="planprincipal" htmlEscape="false" maxlength="20" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li> --%>
			<li>
				<span id="tongyitijiao" class="btn btn-primary">统一提交</span>
			</li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th width="50" style="text-align:center">序号</th>
				<th>归属部门/企业</th>
				<th>目标标题</th>
				<th>目标类型</th>
				<th>负责人</th>
				<th>审核状态</th>
				<th>目标提交时间</th>
				<th>目标完成时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="planinformation" varStatus="i">
			<tr>
				<td style="text-align:center">
					${i.index+1}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${planinformation.unit.name}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${planinformation.plantitle}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${fns:getDictLabel(planinformation.plantype, 'ecpp_plan_type', '')}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					${planinformation.planprincipal}
				</td><td class="alignCenter" style="white-space: nowrap;">
					${fns:getDictLabel(planinformation.shstatus, 'ecpp_info_status', '')}
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					<fmt:formatDate value="${planinformation.tijiaotime}" pattern="yyyy-MM-dd HH:mm"/>
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
					<fmt:formatDate value="${planinformation.endDate}" pattern="yyyy-MM-dd"/>
				</td>
				<td class="alignCenter" style="white-space: nowrap;">
   				<a href="${ctx}/ecpp/planinformation/u2View?id=${planinformation.id}">查看</a>&nbsp;
				<%-- <shiro:hasPermission name="qqecpp:qplaninformation:edit1223"> --%>
				<c:if test="${planinformation.shstatus == 2 || planinformation.status == 0}">
					<a href="${ctx}/ecpp/planinformation/u2Form?id=${planinformation.id}">修改</a>&nbsp;
					<a href="${ctx}/ecpp/planinformation/delete?id=${planinformation.id}" onclick="return confirmx('确认要删除该目标改进项吗？', this.href)">删除</a>
				</c:if>
				<%-- </shiro:hasPermission> --%>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<c:if test="${fns:getUser().name !='游客'}">
		<c:if test="${not empty rejectreason}">
			<div style="padding: 15px;">
				<p>驳回原因：</p>
				<p>${rejectreason.description}</p>
			</div>
		</c:if>
	</c:if>
	<div class="pagination">${page}</div>
</body>
</html>