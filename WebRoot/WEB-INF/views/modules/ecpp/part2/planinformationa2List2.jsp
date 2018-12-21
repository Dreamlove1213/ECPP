<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>目标改进项管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/indexPageStyle/layer/layer.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
        });
        function page(n, s) {
            $("#pageNo").val(n);
            $("#pageSize").val(s);
            $("#searchForm").submit();
            return false;
        }

    </script>
</head>
<body>
<ul class="nav nav-tabs">
   <%-- <li><a href="${ctx}/ecpp/planinformation/a2ListWorkPlan?unit.id=${officeId}&unit.type=${type}">工作计划列表</a></li>--%>
    <li class="active"><a href="${ctx}/ecpp/planinformation/a2List2?unit.id=${officeId}&unit.type=${type}">目标列表</a></li>
</ul>
<form:form id="searchForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/a2List2?unit.id=${officeId}&unit.type=${type}" method="post"
           class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
    <ul class="ul-form">
        <li><label>目标标题：</label>
            <form:input path="plantitle" htmlEscape="false" maxlength="50" class="input-medium"/>
        </li>
        <li><label>目标类型：</label>
            <form:select path="plantype" class="input-medium">
                <form:option value="" label=""/>
                <form:options items="${fns:getDictList('ecpp_plan_type')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </li>
        <li><label>负责人：</label>
            <form:input path="planprincipal" htmlEscape="false" maxlength="20" class="input-medium"/>
        </li>
        <li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
        <li class="clearfix"></li>
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
        <th>目标完成时间</th>
        <!-- <th>备注</th> -->
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
            </td>
            <td class="alignCenter" style="white-space: nowrap;">
                    ${fns:getDictLabel(planinformation.shstatus, 'ecpp_info_status', '')}
            </td>
            <td class="alignCenter" style="white-space: nowrap;">
                <fmt:formatDate value="${planinformation.endDate}" pattern="yyyy-MM-dd"/>
            </td>
            <td class="alignCenter" style="white-space: nowrap;">
                <a href="${ctx}/ecpp/planinformation/a2ViewSh?id=${planinformation.id}">查看</a>&nbsp;
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<div class="pagination">${page}</div>
</body>
</html>