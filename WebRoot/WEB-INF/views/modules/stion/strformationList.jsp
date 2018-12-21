<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>新建机构管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
            $("#btnExport").click(function(){
                $.jBox.confirm("确认要导出通讯录数据吗？","系统提示",function(v,h,f){
                    if(v=="ok"){
                        $("#searchForm").attr("action","${ctx}/sys/user/export");
                        $("#searchForm").submit();
                    }
                },{buttonsFocus:1});
                $('.jbox-body .jbox-icon').css('top','55px');
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
		<li class="active"><a href="${ctx}/stion/strformation/">新建机构列表</a></li>
		<shiro:hasPermission name="stion:strformation:edit"><li><a href="${ctx}/stion/strformation/form">新建机构添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="strformation" action="${ctx}/stion/strformation/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>姓名：</label>
				<form:input path="name" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>职位：</label>
				<form:input path="zhiwei" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>电话：</label>
				<form:input path="dianhua" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>邮箱：</label>
				<form:input path="youxiang" htmlEscape="false" maxlength="255" class="input-medium"/>
			</li>
			<li><label>信息状态：</label>
				<form:input path="status" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>扩展字段1：</label>
				<form:input path="attribute1" htmlEscape="false" maxlength="1024" class="input-medium"/>
			</li>
			<li><label>扩展字段2：</label>
				<form:input path="attribute2" htmlEscape="false" maxlength="1024" class="input-medium"/>
			</li>
			<li><label>扩展字段3：</label>
				<form:input path="attribute3" htmlEscape="false" maxlength="1024" class="input-medium"/>
			</li>
			<li><label>扩展字段4：</label>
				<form:input path="attribute4" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>单位：</label>
				<sys:treeselect id="unit" name="unit.id" value="${strformation.unit.id}" labelName="unit.name" labelValue="${strformation.unit.name}"
					title="部门" url="/sys/office/treeData?type=2" cssClass="input-small" allowClear="true" notAllowSelectParent="true"/>
			</li>
			<li><label>创建者：</label>
				<form:input path="createBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>创建时间：</label>
				<input name="createDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${strformation.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>修改者：</label>
				<form:input path="updateBy.id" htmlEscape="false" maxlength="64" class="input-medium"/>
			</li>
			<li><label>修改时间：</label>
				<input name="updateDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${strformation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>删除标识：</label>
				<form:radiobuttons path="delFlag" items="${fns:getDictList('del_flag')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
			</li>
			<li><label>del_date：</label>
				<input name="delDate" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate"
					value="<fmt:formatDate value="${strformation.delDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</li>
			<li><label>备注：</label>
				<form:input path="remarks" htmlEscape="false" maxlength="1024" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>姓名</th>
				<th>职位</th>
				<th>电话</th>
				<th>邮箱</th>
				<th>信息状态</th>
				<th>扩展字段1</th>
				<th>扩展字段2</th>
				<th>扩展字段3</th>
				<th>扩展字段4</th>
				<th>单位</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>修改者</th>
				<th>修改时间</th>
				<th>删除标识</th>
				<th>del_date</th>
				<th>备注</th>
				<shiro:hasPermission name="stion:strformation:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="strformation">
			<tr>
				<td><a href="${ctx}/stion/strformation/form?id=${strformation.id}">
					${strformation.name}
				</a></td>
				<td>
					${strformation.zhiwei}
				</td>
				<td>
					${strformation.dianhua}
				</td>
				<td>
					${strformation.youxiang}
				</td>
				<td>
					${strformation.status}
				</td>
				<td>
					${strformation.attribute1}
				</td>
				<td>
					${strformation.attribute2}
				</td>
				<td>
					${strformation.attribute3}
				</td>
				<td>
					${strformation.attribute4}
				</td>
				<td>
					${strformation.unit.name}
				</td>
				<td>
					${strformation.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${strformation.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${strformation.updateBy.id}
				</td>
				<td>
					<fmt:formatDate value="${strformation.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${fns:getDictLabel(strformation.delFlag, 'del_flag', '')}
				</td>
				<td>
					<fmt:formatDate value="${strformation.delDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${strformation.remarks}
				</td>
				<shiro:hasPermission name="stion:strformation:edit"><td>
    				<a href="${ctx}/stion/strformation/form?id=${strformation.id}">修改</a>
					<a href="${ctx}/stion/strformation/delete?id=${strformation.id}" onclick="return confirmx('确认要删除该新建机构吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>