<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <link rel="shortcut icon" href="${pageContext.servletContext.contextPath}/images/favicon.png" type="image/png">
  <title>找不到访问的地址</title>
  <link href="${pageContext.request.contextPath}/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
  <style type="text/css">
  	*{margin:0;padding:0;font-family:Microsoft YaHei}
  </style>
</head>

<body>
<div class="container-fluid">
      <div class="page-header">
        <h1>找不到访问的地址</h1>
      </div>
      <p class="lead">找不到访问的地址，若有疑问，请联系管理员！</p>
      <p class="small">若有疑问,请联系：@刘磊3030073 @汤宏3030074 @黄德诚3030525</p>
      <p>
	      <a href="${pageContext.servletContext.contextPath}/login.jsp">重新登录</a>&nbsp;&nbsp;&nbsp;
	      <a href="${pageContext.servletContext.contextPath}/main.shtml">返回首页</a>
      </p>
    </div>
</body>
</html>
