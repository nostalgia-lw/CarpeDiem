<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    request.setAttribute("ctx", pageContext.getRequest().getServletContext().getContextPath());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>顶呱呱订单处理系统</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/png">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap-datetimepicker.min.css" rel="stylesheet"
          type="text/css">
    <link href="${pageContext.request.contextPath}/css/font-awesome/font-awesome.min.css" rel="stylesheet"
          type="text/css">
    <link href="${pageContext.request.contextPath}/css/docs.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/mainFrame.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath}/css/pagger.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/js/jquery-2.1.1.min.js"></script>
    <script>
        var pathName = getRootPath();
        //js获取项目根路径
        function getRootPath(){
            //获取当前网址
            var curWwwPath=window.document.location.href;
            //获取主机地址之后的目录
            var pathName=window.document.location.pathname;
            var pos=curWwwPath.indexOf(pathName);
            //获取主机地址，
            var localhostPath=curWwwPath.substring(0,pos);
            return(localhostPath);
        }
    </script>
    <script src="${pageContext.request.contextPath}/js/jquery.form.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/jquery-extends.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-datetimepicker.min.js"></script>
    <script src="${pageContext.request.contextPath}/bootstrap/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <script src="${pageContext.request.contextPath}/artDialog/art_dialog.js"></script>
    <script src="${pageContext.request.contextPath}/js/custom.js"></script>
    <script src="${pageContext.request.contextPath}/My97DatePicker/WdatePicker.js"></script>
    <script src="${pageContext.request.contextPath}/js/aop.js"></script>
    <script src="${pageContext.request.contextPath}/js/data.format.min.js"></script>

