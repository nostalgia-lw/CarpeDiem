<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <li><a href="javascript:history.go(-1);"><i class="icon-reply color-green"></i><span>返回</span></a></li>
            <li><a href="javascript:window.location.reload();"><i class="icon-refresh color-green"></i><span>刷新页面</span></a>
            </li>
        </ul>
    </div>
    <div class="history">
        <i class="icon-map-marker"></i>
        <label>当前位置：</label>
        <span>基础数据</span>
        &nbsp;&rsaquo;&nbsp;
        <span>权限管理</span>
        &nbsp;&rsaquo;&nbsp;
        <span>添加权限</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
<div class="container-fluid">
    <div class="container-panel">
        <div class="content">
            <form class="form-horizontal" action="${action}" id="form">
                <table class="table form-table table-condensed">
                    <tr>
                        <td class="tdleft" width="6%">*权限名称:</td>
                        <td class="tdright" width="19%"><input type="text" name="name"
                                                               placeholder="权限名称" class="form-control input-sm"></td>
                        <td class="tdleft" width="6%">*权限等级:</td>
                        <td class="tdright" width="19%"><input type="text" name="pinyin"
                                                               placeholder="权限等级" class="form-control input-sm"></td>
                    </tr>
                </table>
                <input type="hidden" name="id"/>
            </form>
            <div class="form-btns">
                <button type="button" class="btn btn-primary btn-sm" onclick="sub();">提交</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //提交
    function sub() {

    }
</script>
</body>
</html>
