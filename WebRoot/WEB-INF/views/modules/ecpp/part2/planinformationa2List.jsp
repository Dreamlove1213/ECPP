<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>目标改进项管理</title>
    <meta name="decorator" content="default"/>
    <script src="${ctxStatic}/indexPageStyle/layer/layer.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            var flag = true;

            var officeId = '${officeId}';
            var type = '${type}';
            //统一通过
            $("#tongyitijiao").on("click", function () {
                var messgages = "确认要统一通过吗？";
                var status = confirm(messgages);
                if (status == true) {
                    $.post("${ctx}/ecpp/planinformation/plan2Pass", {
                        'unit.id': officeId,
                        'unit.type': type
                    }, function (data) {
                        if (data != undefined && data == 1) {
                            $.jBox.messager("通过成功！", "提示");
                            setTimeout(function () {
                                window.location = "${ctx}/ecpp/planinformation/a2List?unit.id=${officeId}&unit.type=${type}";
                            }, 1500);
                        } else {
                            $.jBox.messager("当前没有需要提交的数据！！", "提示");
                        }
                    });
                }
            });
            //统一驳回
            $("#tongyibohui").on("click", function () {
                var messgages = "确认要统一驳回吗？";
                var status = confirm(messgages);

                if (status == true) {
                    var s = flags();
                    if (!s) {
                        $.jBox.messager("当前没有需要操作的数据！！", "提示");
                    }
                    if (s) {
                        //驳回必须填写驳回的具体原因
                        layer.open({
                            type: 2,
                            title: '驳回原因',
                            maxmin: true,
                            closeBtn: 0,
                            area: ['800px', '500px'],
                            content: '${ctx}/rejectreason/rejectreason/form?unit.id=${officeId}&unit.type=${type}',
                            btn: ['关闭'], yes: function (index) {
                                $.post("${ctx}/ecpp/planinformation/plan2noPass", {
                                    'unit.id': officeId,
                                    'unit.type': type
                                }, function (data) {
                                    if (data != undefined && data == 1) {
                                        $.jBox.messager("驳回成功！", "提示");
                                        layer.close(index);
                                        setTimeout(function () {
                                            window.location = "${ctx}/ecpp/planinformation/a2List?unit.id=${officeId}&unit.type=${type}";
                                        }, 1500);
                                    } else {
                                        $.jBox.messager("当前没有需要操作的数据！！", "提示");
                                        layer.close(index);
                                    }
                                });
                            }
                        });
                    }
                }
            });

            function flags() {
                $.ajaxSettings.async = false;
                $.post("${ctx}/ecpp/planinformation/checkIsData",{
                    'unit.id': officeId,
                    'unit.type': type
                }, function (data) {
                    if (data == undefined || data == 0) {
                        flag = false;
                    }
                });
                $.ajaxSettings.async = true;
                return flag;
            }

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
    <li class="active"><a href="${ctx}/ecpp/planinformation/a2List?unit.id=${officeId}&unit.type=${type}">目标列表</a></li>
    <%-- <shiro:hasPermission name="ecpp:planin:edit"><li><a href="${ctx}/ecpp/planinformation/u2Form">新建目标</a></li></shiro:hasPermission> --%>
    <%-- <li><a href="${ctx}/ecpp/planinformation/Analysis">统计分析</a></li> --%>
</ul>
<form:form id="searchForm" modelAttribute="planinformation" action="${ctx}/ecpp/planinformation/a2List?unit.id=${officeId}&unit.type=${type}" method="post"
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
        <c:if test="${fns:getUser().name !='游客'}">
            <li class="btns"><a id="tongyitijiao" class="btn btn-primary">统一通过</a></li>
            <li class="btns"><a id="tongyibohui" class="btn btn-primary">统一驳回</a></li>
        </c:if>
        <li class="clearfix"></li>
    </ul>
</form:form>
<%--	<ul class="ul-form">

	</ul>--%>
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
                <%-- <td class="alignCenter">
                    ${planinformation.remarks}
                </td> --%>
            <td class="alignCenter" style="white-space: nowrap;">
                <a href="${ctx}/ecpp/planinformation/a2ViewSh?id=${planinformation.id}">查看</a>&nbsp;
                    <%-- <shiro:hasPermission name="qqecpp:qplaninformation:edit1223"> --%>
                    <%-- 	<a href="${ctx}/ecpp/planinformation/u2Form?id=${planinformation.id}">修改</a>&nbsp; --%>
                <c:if test="${fns:getUser().name !='游客'}">
                    <a href="${ctx}/ecpp/planinformation/delete1?id=${planinformation.id}"
                       onclick="return confirmx('确认要删除该目标改进项吗？', this.href)">删除</a>
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