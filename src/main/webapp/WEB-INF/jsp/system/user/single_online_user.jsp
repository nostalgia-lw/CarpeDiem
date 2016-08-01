<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://cddgg.com/jstl/pager" prefix="p"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
</head>
<body>
<!--操作栏 start-->
<div class="main-top">
    <div class="opera-bar">
        <ul>
            <li><a href="javascript:window.location.reload();"><i class="icon-refresh color-green"></i><span>刷新页面</span></a></li>
        </ul>
    </div>
    <div class="history">
        <i class="icon-map-marker"></i>
        <label>当前位置：</label>
        <span>系统管理</span>
        &nbsp;&rsaquo;&nbsp;
        <span>在线用户</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
	<div class="container-fluid">
 	  <div class="container-panel">
 	 	<div class="tool-view">
 	 		<div class="clearfix">
	 	 		<div class="pull-right">
				  <form action="" method="post" class="form-inline">
					   <div class="form-group">
					    <span>名称:</span>
					    <input type="text" class="form-control input-sm" value="${param.name}" name="name" placeholder="名称">
					  </div>
					   <div class="form-group">
					    <span>登录名:</span>
					    <input type="text" class="form-control input-sm" value="${param.loginName}" name="loginName" placeholder="登录名">
					  </div>
					   <div class="form-group">
					    <span>部门:</span>
					    <select class="form-control input-sm" name="orgId">
					    <option value="">选择部门</option>
				            <c:forEach var="r" items="${organizations}" varStatus="s">
				            	<option value="${r.id}" <c:if test="${user.organization.id==r.id}">selected</c:if> >${r.name}</option>
				            </c:forEach>
			              </select>
					  </div>		
					  <button type="submit" class="btn btn-primary btn-sm">立即搜索</button>
					</form>
	 	 		</div>
 	 		</div>
		</div>
				
 	 	<div class="content">
          <table class="table table-bordered table-condensed">
            <thead>
             <tr>
             <th colspan="6" style="background: #F39C1F;color: #FFFFFF;font-weight: bold;">当前在线用户</th>
             </tr>
              <tr>
                <th>名称</th>
                <th>登录名</th>
                <th>部门</th>
                <th>角色</th>
                <th>性别</th>
                <th>电话</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="key" items="${page.items}" varStatus="s">
              <tr>
                <td><a href="javascript:;" class="show-user-info" data-id="${key.id}">${key.name}</a></td>
                <td>${key.loginName}</td>
                <td>${key.organization.name}</td>
                <td>
					<c:forEach var="roleKey" items="${key.roles}" varStatus="s">
						[${roleKey.name}]
					</c:forEach>
				</td>
				<td>${key.sex}</td>
                <td>${key.phone}</td>
              </tr>
			</c:forEach>
            </tbody>
          </table>
          <div class="clearfix">
 	 		<div class="pull-right">
	           	 <p:pager pageSize="${page.pageSize}" pageNo="${page.curIndex}" url="${pageContext.request.contextPath}/user/singleOnlineUser.shtml" recordCount="${page.rowsCount}" />
 	 		</div>
            </div>
      	</div>
   	</div>
</div>
</body>
</html>