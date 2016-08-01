<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://cddgg.com/jstl/pager" prefix="p" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="../header.jsp"/>
    <%--<link href="${pageContext.request.contextPath}/js/jqueryChosen/chosen.css" rel="stylesheet" type="text/css">--%>
    <%--<script src="${pageContext.request.contextPath}/js/jqueryChosen/chosen.jquery.js"></script>--%>
</head>
<body>
<!--操作栏 start-->
<div class="main-top">
    <div class="opera-bar">
        <ul>
            <li><a href="javascript:window.location.reload();"><i class="icon-refresh color-green"></i><span>刷新页面</span></a>
            </li>
        </ul>
    </div>
    <div class="history">
        <i class="icon-map-marker"></i>
        <label>当前位置：</label>
        <span>系统管理</span>
        &nbsp;&rsaquo;&nbsp;
        <span>权限管理</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
<div class="container-fluid">
    <div class="container-panel">
        <div class="tool-view">
            <div class="clearfix">
                <div class="pull-left">
                    <a href="${pageContext.servletContext.contextPath}/ao_role/add_role">
                        <span class="btn btn-success btn-sm">新增用户</span>
                    </a>
                </div>
            </div>
        </div>

        <div class="content">
            <table class="table table-bordered table-condensed">
                <thead>
                <tr>
                    <th style="width: 30px;"><input type="checkbox" class="check-all"></th>
                    <th>ID</th>
                    <th>名称</th>
                    <th>登录名</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="key" items="${page.items}" varStatus="s">
                    <tr>
                        <td><input type="checkbox" class="ids"></td>
                        <td>${key.id}</td>
                        <td>${key.name}</td>
                        <td>${key.loginName}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="clearfix">
                <div class="pull-right">
                    <p:pager pageSize="${page.pageSize}" pageNo="${page.curIndex}" url=""
                             recordCount="${page.rowsCount}"/>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
</script>
</body>
</html>