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
        <span>角色管理</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
<div class="container-fluid">
 	  <div class="container-panel">
 	 	<div class="tool-view">
 	 		<div class="clearfix">
	 	 		<div class="pull-left">
				  <shiro:hasPermission name="resources_add"> 
					<a href="${pageContext.servletContext.contextPath}/role/add.shtml">
						<span class="btn btn-success btn-sm">新增角色</span>
					</a>
					</shiro:hasPermission>
	 	 		</div>
	 	 		<div class="pull-right">
				  <form action="" method="post" class="form-inline">
					  <div class="form-group">
			              <span>名称:</span>
			              <input type="text" class="form-control input-sm" name="name" placeholder="名称">
			            </div>
			            <div class="form-group">
			              <span>唯一KEY:</span>
			              <input type="text" class="form-control input-sm" name="key"placeholder="唯一KEY">
			            </div>
			             <div class="form-group">
		      		            <button type="submit" class="btn btn-primary btn-sm">立即搜索</button>
			            </div>
					</form>
	 	 		</div>
 	 		</div>
		</div>
				
 	 	<div class="content">
          <table class="table table-bordered table-condensed">
             <thead>
              <tr>
                <th>名称</th>
                <th>唯一KEY</th>
                <th>描述</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="items" items="${page.items}" varStatus="s">
              <tr>
                <td>${items.name}</td>
                <td>${items.key}</td>
                <td>${items.description}</td>
                <td>
                <shiro:hasPermission name="role_edit"> 
					<a href="${pageContext.servletContext.contextPath}/role/edit.shtml?id=${items.id}" class="btn btn-success btn-xs">编辑</a>
				</shiro:hasPermission>
                <shiro:hasPermission name="role_delete"> 
					<a href="${pageContext.servletContext.contextPath}/role/delete.shtml?id=${items.id}" data-info="确认删除吗?" class="confirm ajax-get btn btn-danger btn-xs">删除</a>
				</shiro:hasPermission>
				 <shiro:hasPermission name="permissions"> 
					<a href="${pageContext.servletContext.contextPath}/resources/permissions.shtml?roleId=${items.id}" class="btn btn-warning btn-xs">授权</a>
				</shiro:hasPermission>
				</td>
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
