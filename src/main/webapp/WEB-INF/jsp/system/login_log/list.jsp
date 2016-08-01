<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://cddgg.com/jstl/pager" prefix="p"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
</head>
<body>
	<div class="container-fluid">
	<div class="page-header clearfix">
 		<div class="pull-left">
       		<a href="javascript:window.location.reload();" class="btn btn-link btn-xs"><i class="icon-refresh"></i> 刷新页面</a>
      	</div>
     	<div class="pull-right crumbs">
     		<i class=" icon-map-marker"></i> <span>当前位置：登录日志管理</span>
      	</div>
    </div>
 	  <div class="container-panel">
 	 	<div class="tool-view">
 	 		<div class="clearfix">
	 	 		<div class="pull-left">
	 	 		</div>
	 	 		<div class="pull-right">
				<!--   <form action="" method="post" class="form-inline">
					   <div class="form-group">
					    <span>名称:</span>
					    <input type="text" class="form-control input-sm" name="name" placeholder="名称">
					  </div>
					  <button type="submit" class="btn btn-primary btn-sm">立即搜索</button>
					</form> -->
	 	 		</div>
 	 		</div>
		</div>
				
 	 	<div class="content">
          <table class="table table-bordered table-condensed">
            <thead>
              <tr>
              	<th style="width: 30px;"><input type="checkbox" class="check-all"></th>
                <th>登录用户</th>
                <th>登录IP</th>
                <th>登录时间</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="key" items="${page.items}" varStatus="s">
              <tr>
             	<td><input type="checkbox" class="ids"></td>
             	<td>${key.loginer.name}</td>
                <td>${key.ip}</td>
                <td><fmt:formatDate pattern="YYYY/MM/dd HH:mm:ss"  value="${key.loginTime}" /></td>
              </tr>
			</c:forEach>
            </tbody>
          </table>
          <div class="clearfix">
 	 		<div class="pull-left">
 	 		</div>
 	 		<div class="pull-right">
	           	 <p:pager pageSize="${page.pageSize}" pageNo="${page.curIndex}" url="" recordCount="${page.rowsCount}" />
 	 		</div>
            </div>
      	</div>
   	</div>
</div>
</body>
</html>