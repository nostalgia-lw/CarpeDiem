<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

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
            <li><a href="javascript:history.go(-1);"><i class="icon-reply color-green"></i><span>返回</span></a></li>
            <li><a href="javascript:window.location.reload();"><i class="icon-refresh color-green"></i><span>刷新页面</span></a></li>
        </ul>
    </div>
    <div class="history">
        <i class="icon-map-marker"></i>
        <label>当前位置：</label>
        <span>系统管理</span>
        &nbsp;&rsaquo;&nbsp;
        <span>菜单管理</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
<div class="container-fluid">
	<div class="container-panel">
	   <div class="content">
	   		<form class="form-horizontal" action="${action}" id="form" style="width: 400px;">
				  <div class="form-group">
				    <label class="col-sm-4 control-label">*上级</label>
				    <div class="col-sm-8">
				      <select class="form-control input-sm input-sm" name="pid">
	   		 				<option value="0">无上级</option>
				            <c:forEach var="r" items="${parentTree}" varStatus="s">
				            	<option value="${r.id}" <c:if test="${pid==r.id}">selected</c:if> >${r.name}</option>
				            </c:forEach>
			              </select>
				    </div>
				  </div>
				   <div class="form-group">
				    <label class="col-sm-4 control-label">*名称:</label>
				    <div class="col-sm-8">
			            <input type="text" name="name" value="${res.name}" placeholder="名称" class="form-control input-sm">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-4 control-label">*key:</label>
				    <div class="col-sm-8">
			            <input type="text" name="key" value="${res.key}" placeholder="key" class="form-control input-sm">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-4 control-label">图标:</label>
				    <div class="col-sm-8">
			            <input type="text" name="icon" value="${res.icon}" placeholder="图标" class="form-control input-sm">
				    </div>
				  </div>
				   <div class="form-group">
				    <label class="col-sm-4 control-label">url:</label>
				    <div class="col-sm-8">
			            <input type="text" name="url" value="${res.url}" placeholder="url" class="form-control input-sm">
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-4 control-label">描述:</label>
				    <div class="col-sm-8">
  	   		 		 	<textarea name="description" placeholder="描述" class="form-control">${res.description}</textarea>
				    </div>
				  </div>
				   <div class="form-group">
				    <label class="col-sm-4 control-label">状态:</label>
				    <div class="col-sm-8">
			            <select class="form-control input-sm input-sm" name="isHide">
	   		 				<option value="0" <c:if test="${res.isHide==0}">selected</c:if>>启用</option>
			            	<option value="1" <c:if test="${res.isHide==1}">selected</c:if>>禁用</option>
			              </select>
				    </div>
				  </div>
				  <div class="form-group">
				    <label class="col-sm-4 control-label">排序:</label>
				    <div class="col-sm-8">
			            <input type="number" name="sort" value="<c:if test="${res.sort==null}">999</c:if><c:if test="${res.sort!=null}">${res.sort}</c:if>" placeholder="序号" class="form-control input-sm">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="col-sm-offset-4 col-sm-8">
				      <input type="hidden" name="id" value="${res.id}" />
				      <button type="button" class="btn btn-primary btn-sm" onclick="sub();">提交</button>
				    </div>
				  </div>
				</form>
	</div>
</div>
</div>
	<script type="text/javascript">
	function sub(){
		var checkName = checkEmpty($('[name="name"]'),'请填名称');
		var checkKey = checkEmpty($('[name="key"]'),'请填写key');
		var checkUrl = checkEmpty($('[name="url"]'),'请填写url');
		if(checkName && checkKey && checkUrl){
			$.ajax({
				type : "POST",
				data : $("#form").serialize(),
				url : $("#form").attr("action"),
				dataType : 'json',
				success:function(data) {
					if(data.status==1){
						msg.confirm(data.info,function(){
							window.location.reload();
				    	},"操作提示");
					}else{
						msg.info(data.info);
					}
				}
			});
		}
	}
	//验证信息
	//验证空信息
	function checkEmpty(obj,msg){
		var check = false;
		var val = obj.val();
		if(val == ""){
			obj.err(msg);
		}else{
			check = true;
			obj.closeErr();
		}
		return check;
	}
	</script>
</body>
</html>
