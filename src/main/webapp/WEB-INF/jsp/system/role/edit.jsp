<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

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
            <li><a href="javascript:history.go(-1);"><i class="icon-reply color-green"></i><span>返回</span></a></li>
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
	   <div class="row">
		   <div class="col-md-3">
	   		 <form class="form-horizontal" action="${action}" id="form" style="width: 400px;">
	   		 	<div class="form-group">
				    <label class="col-sm-4 control-label">*名称:</label>
				    <div class="col-sm-8">
			            <input type="text" name="name" value="${role.name}" placeholder="名称" class="form-control input-sm">
				    </div>
				  </div>
				  	<div class="form-group">
				    <label class="col-sm-4 control-label">*key:</label>
				    <div class="col-sm-8">
			            <input type="text" name="key" value="${role.key}" placeholder="key" class="form-control input-sm">
				    </div>
				  </div>
				   <div class="form-group">
				    <label class="col-sm-4 control-label">描述:</label>
				    <div class="col-sm-8">
  	   		 		 	<textarea name="description" placeholder="描述" class="form-control">${role.description}</textarea>
				    </div>
				  </div>
					<div class="form-group">
					    <div class="col-sm-offset-4 col-sm-8">
					      <input type="hidden" name="id" value="${role.id}" />
					      <button type="button" class="btn btn-primary btn-sm" onclick="sub();">提交</button>
					    </div>
				  </div>
          </form>
		   </div>
		   <div class="col-md-9">
				   <label>关联此角色的用户:</label>
					   <select data-placeholder="选择用户" class="user-chosen-select" multiple style="width: 100%;">
						   <c:forEach var="u" items="${users}">
							   <option value="${u.id}" <c:forEach items="${roleUsers}" var="ru">${ru.id eq u.id ?'selected':''}</c:forEach>>${u.name}(${u.loginName})</option>
						   </c:forEach>
					   </select>
			   </div>
	</div>
</div>
</div>
	<script type="text/javascript">
		$(function () {
			$('.user-chosen-select').chosen();
		});
	function sub(){
		var checkName = checkEmpty($('[name="name"]'),'请填名称');
		var checkKey = checkEmpty($('[name="key"]'),'请填写key');
		if(checkName && checkKey){
			var $choiceClose = $(".user-chosen-select").next('.chosen-container').children('.chosen-choices').find('.search-choice-close');

			var userIds = [];
			$.each($choiceClose,function(j){
				var thisIndex = $(this).attr('data-option-array-index');
				var selectOption = $('.user-chosen-select option');
				userIds.push(selectOption.get(thisIndex).value);
			});
			var param = $('#form').serializeObject();
			param.userIds = userIds;
			$.ajax({
				type : "POST",
				data : param,
				url : $("#form").attr("action"),
				dataType : 'json',
				success:function(data) {
					if(data.status==1){
						msg.info(data.info);
						setTimeout(function(){
							window.location.reload();
						},1000);
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
