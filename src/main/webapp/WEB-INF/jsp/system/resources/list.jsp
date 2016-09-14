<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
<style type="text/css">
	.sort_input{width: 30px;height: 24px;border-radius: 2px;border: 1px solid #ccc; text-align: center;}
</style>
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
        <span>菜单管理(${pname})</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
<div class="container-fluid">
 	  <div class="container-panel">
 	 	<div class="tool-view">
 	 		<div class="clearfix">
	 	 		<div class="pull-left">
					<a href="add.html?pid=${pid}">
						<span class="btn btn-success btn-sm">新增菜单</span>
					</a>
	 	 		</div>
	 	 		<div class="pull-right">
				  <form action="" method="get" class="form-inline">
					   <div class="form-group">
					    <span>上级菜单:</span>
					     <select class="form-control input-sm input-sm" name="pid">
	   		 				<option value="0">无上级</option>
				            <c:forEach var="r" items="${parentTree}" varStatus="s">
				            	<option value="${r.id}" <c:if test="${pid==r.id}">selected</c:if> >${r.name}</option>
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
			               <th>ID</th>
			                <th>名称</th>
			                <th>KEY</th>
			                <th>图标</th>
			                <th>URL地址</th>
			                <th>状态</th>
			                <th>排序</th>
			                <th>操作</th>
			              </tr>
			            </thead>
			            <tbody>
			            <c:forEach var="k" items="${page.items}">
			              <tr>
			                <td>${k.id}</td>
			                <td><a href="list.shtml?pid=${k.id}">${k.name}</a></td>
			                <td>${k.key}</td>
			                <td><i class="${k.icon}"> ${k.icon}</i></td>
			                <td>${k.url}</td>
			               <td>
			                	<c:if test="${k.isHide==1}">
			                		<a href="javascript:void(0);" style="color: #1CAF9A;" class="ishide_btn" data-val="${k.isHide}" data-id="${k.id}" title="点击禁用">启用</a>
			                	</c:if>
			                	<c:if test="${k.isHide==-1}">
			                		<a href="javascript:void(0);" style="color: #d9534f;" class="ishide_btn" data-val="${k.isHide}" data-id="${k.id}" title="点击启用">禁用</a>
			               		</c:if>
		              		 </td>
			                <td>
			                	<input type="text" class="sort_input" oninput="this.value=this.value.replace(/\D/g,'')"  data-id="${k.id}" value="${k.sort}" maxlength="3">
			                </td>
			                <td>
									<a href="edit.html?id=${k.id}" class="btn btn-success btn-xs">编辑</a>
									<a href="delete.html?id=${k.id}" data-info="确认删除吗?" class="confirm ajax-get btn btn-danger btn-xs">删除</a>
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
	<script type="text/javascript">
	$(function(){
		/*更新排序*/
		$(".sort_input").blur(function(){
			var id = $(this).attr("data-id");
			var value = $(this).val();
			$.ajax({
				type:"POST",
				url:"change_sort.shtml",
				data:{
					'id':id,
					'sort':value
				},
				dataType:"json",
				success:function(data){
					if(data.status==0){
						msg.info(data.info);
					}
				}
			});
		});
		/*切换是否禁用*/
		$(".ishide_btn").click(function(){
			var thisObj = $(this);
			var id = thisObj.attr("data-id");
			var value = thisObj.attr("data-val");
			$.ajax({
				type:"POST",
				url:"change_hide.html",
				data:{
					'id':id,
					'isHide':value
				},
				dataType : 'json',
				success:function(data) {
					console.log(data.status);
					if(data.status==1){
						if("0"==value){
							thisObj.attr("title","点击启用");
							thisObj.text("禁用");
							thisObj.css("color","#d9534f");
							thisObj.attr("data-val","1");
						}else{
							thisObj.attr("title","点击禁用");
							thisObj.text("启用");
							thisObj.css("color","#1CAF9A");
							thisObj.attr("data-val","0");
						}
					}else{
						msg.info(data.info);
					}
				}
			});
		});
	});
	</script>
</body>
</html>
