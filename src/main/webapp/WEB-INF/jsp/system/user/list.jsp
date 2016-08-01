<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib uri="http://cddgg.com/jstl/pager" prefix="p"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
<link href="${pageContext.request.contextPath}/js/jqueryChosen/chosen.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jqueryChosen/chosen.jquery.js"></script>
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
        <span>用户管理</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
	<div class="container-fluid">
 	  <div class="container-panel">
 	 	<div class="tool-view">
 	 		<div class="clearfix">
	 	 		<div class="pull-left">
					<a href="${pageContext.servletContext.contextPath}/user/add.shtml">
						<span class="btn btn-success btn-sm">新增用户</span>
					</a>
	 	 		</div>
	 	 		<div class="pull-right">
				  <form action="" method="post" class="form-inline">
					   <div class="form-group">
					    <span>名称:</span>
					    <input type="text" class="form-control input-sm" name="name" placeholder="名称">
					  </div>
					   <div class="form-group">
					    <span>登录名:</span>
					    <input type="text" class="form-control input-sm" name="loginName" placeholder="登录名">
					  </div>
					   <div class="form-group">
					    <span>部门:</span>
					    <select class="form-control input-sm orgselect" name="orgId">
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
              	<th style="width: 30px;"><input type="checkbox" class="check-all"></th>
              	<th>ID</th>
                <th>名称</th>
                <th>登录名</th>
                <th>部门</th>
                <th>角色</th>
                <th>性别</th>
                <th>电话</th>
                <th>禁用</th>
                <th>操作</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="key" items="${page.items}" varStatus="s">
              <tr>
             	<td><input type="checkbox" class="ids"></td>
             	<td>${key.id}</td>
                <td>${key.name}</td>
                <td>${key.loginName}</td>
                <td>${key.organization.name}</td>
                <td>
					<c:forEach var="roleKey" items="${key.roles}" varStatus="s">
						[${roleKey.name}]
					</c:forEach>
				</td>
				<td>${key.sex}</td>
                <td>${key.phone}</td>
                <td>
                	<c:if test="${key.locked==0}">
                		正常
                	</c:if>
                	<c:if test="${key.locked==1}">
                		<a href="javascript:void(0);" style="color: #d9534f;">禁用</a>
               		</c:if>
             		 </td>
                <td>
                	<shiro:hasPermission name="user_edit"> 
			             <a href="${pageContext.servletContext.contextPath}/user/edit.shtml?id=${key.id}" class="btn btn-success btn-xs">编辑</a>
					</shiro:hasPermission>
	                <shiro:hasPermission name="user_delete"> 
						<a href="${pageContext.servletContext.contextPath}/user/delete.shtml?id=${key.id}" data-info="确认删除吗?" class="confirm ajax-get btn btn-danger btn-xs">删除</a>
					</shiro:hasPermission>
				</td>
              </tr>
			</c:forEach>
            </tbody>
          </table>
          <div class="clearfix">
 	 		<div class="pull-left">
 	 			<!--  <div class="btn-group" role="group">
				    <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				      	其他操作
				      <span class="caret"></span>
				    </button>
				    <ul class="dropdown-menu">
				      <li><a href="#">排序</a></li>
				      <li><a href="#">禁用</a></li>
				      <li><a href="#">删除</a></li>
				    </ul>
				  </div> -->
 	 		</div>
 	 		<div class="pull-right">
	           	 <p:pager pageSize="${page.pageSize}" pageNo="${page.curIndex}" url="" recordCount="${page.rowsCount}" />
 	 		</div>
            </div>
      	</div>
   	</div>
</div>
<script type="text/javascript">
	$(".orgselect").chosen();//下拉插件
	</script>
</body>
</html>