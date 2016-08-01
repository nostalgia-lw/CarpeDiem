<!-- Ajax获取用户信息页面 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="user-info">
<div class="info clearfix">
	<div class="img">
		<img src="${pageContext.servletContext.contextPath}/${user.avator!=null?user.avator:'upload/avator/default.jpg'}" onerror="this.src='${pageContext.servletContext.contextPath}/upload/avator/default.jpg'" alt="${user.name}" class="l">
	</div>
	<div class="r-text">
		<p>
			<span class="username">${user.name}</span> &nbsp;&nbsp;<span class="txt">${user.loginName}&nbsp;&nbsp;${user.sex} </span>
		</p>
		<p class="txt">
			<i class="icon-sitemap icon"></i> ${user.organization.name}
		</p>
		<p class="txt">
			<i class="icon-mobile-phone icon"></i> ${user.phone}
		</p>
		<p class="txt">
		<c:forEach var="r" items="${user.roles}"><span class="badge">${r.name}</span></c:forEach>
		</p>
	</div>
</div>
	<div class="description"><span style="color:#000000;">个人介绍：</span>${user.description}</div>
	<hr>
	<div class="msg-box">
	<form id="form" action="${pageContext.servletContext.contextPath}/msg/send.shtml">
	  <div class="form-group">
	    	<label>发送站内信：</label>
			<textarea class="form-control" rows="3" name="msg" placeholder="请输入站内信内容"></textarea>
	  </div>
	  <div class="form-group">
	  <input type="hidden" value="${user.id}" name="uid">
	  <button type="button" class="btn btn-primary btn-sm pull-right" onclick="sub();">发送站内信</button>
	  </div>
	  </form>
	</div>
</div>
<script>
function sub(){
	var checkMsg = checkEmpty($('[name="msg"]'),'请填写内容');
	if(checkMsg){
		$.ajax({
			type : "POST",
			data : $("#form").serialize(),
			url : $("#form").attr("action"),
			dataType : 'json',
			success:function(data) {
				if(data.status==1){
					msg.info(data.info);
					$("#form")[0].reset();
				}else{
					msg.info(data.info);
				}
			}
		});
	}
}
//验证信息
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
