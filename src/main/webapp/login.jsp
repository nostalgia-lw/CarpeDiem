<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <link rel="shortcut icon" href="images/favicon.png" type="image/png">
    <title>欢迎使用-请先登录</title>
    <link href="css/login.css" rel="stylesheet">

    <script type="text/javascript">
        if (top.location != self.location)top.location = self.location;
    </script>
</head>
<body>
<div class="login">
    <h2><img src="images/logo.png"></h2>
    <div class="login-top">
        <h1>顶呱呱为你服务</h1>
            <input type="text" name="loginName" placeholder="请输入帐号">
            <input type="password" name="password" placeholder="请输入密码">
            <div class="forgot">
                <input class="" type="submit" value="登 录">
            </div>
    </div>
    <div class="login-bottom">
        <h3></h3>
    </div>
</div>
<div class="copyright">
    <p>Copyright &copy; 2016.Company CDDGG.COM All rights reserved. Created By: <a href="#" target="_blank"><顶呱呱集团-信息技术部></顶呱呱集团-信息技术部></a></p>
</div>
<input type="hidden" id="pathName" value="${pageContext.request.contextPath}">
<script src="${pageContext.request.contextPath}/js/jquery-2.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/artDialog/art_dialog.js"></script>
<script type="text/javascript">
    $(function () {
        var pathName =$("#pathName").val();
         $("input[type=submit]").click(function () {
             var loginName =$("input[name=loginName]").val();
             var password =$("input[name=password]").val();
             if(loginName==="" || password===""){
                 msg.info("账号和密码不能为空",1000);
                 return false;
             }
             $.ajax({
                 type:"post",
                 datatype:"json",
                 data:{loginName:loginName,password:password},
                 url:"login.html",
                 success:function (data) {
                     if(data.status===false){
                         msg.info(data.info,1000);
                     }else{
                         location.href=data.info;
                     }
                 }
             });
         });
        $("input[name=password]").keypress(function (e) {
            if(e.keyCode===13){
                var loginName =$("input[name=loginName]").val();
                var password =$("input[name=password]").val();
                if(loginName==="" || password===""){
                    msg.info("账号和密码不能为空",1000);
                    return false;
                }
                $.ajax({
                    type:"post",
                    datatype:"json",
                    data:{loginName:loginName,password:password},
                    url:"login.html",
                    success:function (data) {
                        if(data.status===false){
                            msg.info(data.info,1000);
                        }else{
                            location.href=data.info;
                        }
                    }
                });
            }
        });
    });

</script>
</body>
</html>
