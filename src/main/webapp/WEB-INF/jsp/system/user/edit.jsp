<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
<link href="${pageContext.request.contextPath}/js/jqueryChosen/chosen.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jqueryChosen/chosen.jquery.js"></script>
<style type="text/css">
	.form-btns {
		text-align: center;
	}
</style>
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
        <span>菜单管理(${pname})</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
<div class="container-fluid">
	<div class="container-panel">
	   <div class="content">
	   		 <form class="form-horizontal" action="${action}" id="form">
	   		 <table class="table form-table table-condensed">
	   		 	<tr>
	   		 		<td class="tdleft" width="6%">*员工姓名:</td>
	   		 		<td class="tdright" width="19%"><input type="text" name="name" value="${user.name}" placeholder="员工名称" class="form-control input-sm"></td>
	   		 		<td class="tdleft" width="6%">*姓名拼音:</td>
	   		 		<td class="tdright" width="19%"><input type="text" name="pinyin" value="${user.pinyin}" placeholder="姓名拼音" class="form-control input-sm"></td>
	   		 		<td class="tdleft" width="6%">*登录名:</td>
	   		 		<td class="tdright" width="19%"><input type="text" name="loginName" value="${user.loginName}" placeholder="登录名" class="form-control input-sm"></td>
	   		 		<td class="tdleft" width="6%">*密码:</td>
	   		 		<td class="tdright" width="19%"><input type="password" name="loginPwd" value="" placeholder="新增时必须填写密码" class="form-control input-sm"></td>
	   		 	</tr>
	   		 	<tr>
	   		 		<td class="tdleft">*性别:</td>
	   		 		<td class="tdright">
	   		 			<select class="form-control input-sm" name="sex">
	   		 					<option value="" <c:if test="${user.sex==null}">selected</c:if> >请选择</option>
				            	<option value="男" <c:if test="${user.sex=='男'}">selected</c:if> >男</option>
				            	<option value="女" <c:if test="${user.sex=='女'}">selected</c:if> >女</option>
			              </select>
	   		 		</td>
	   		 		<td class="tdleft">*选择部门:</td>
	   		 		<td class="tdright">
	   		 			<select class="form-control input-sm orgselect" name="organization.id">
	   		 				<option value="">请选择部门</option>
				            <c:forEach var="r" items="${organizations}" varStatus="s">
				            	<option value="${r.id}" <c:if test="${user.organization.id==r.id}">selected</c:if> >${r.name}</option>
				            </c:forEach>
			              </select>
	   		 		</td>
	   		 		<td class="tdleft">*状态:</td>
	   		 		<td class="tdright">
	   		 			 <select class="form-control input-sm input-sm" name="locked">
	   		 				<option value="0" <c:if test="${user.locked==0}">selected</c:if>>启用</option>
			            	<option value="1" <c:if test="${user.locked==1}">selected</c:if>>禁用</option>
			              </select>
	   		 		</td>
	   		 		
	   		 	</tr>
	   		 	<tr>
	   		 	<td class="tdleft">*选择角色:</td>
	   		 		<td class="tdright" colspan="7">
						<c:forEach var="r" items="${roles}" varStatus="s">
							<label class="checkbox-inline">
				            	<input type="checkbox" name="roleId" value="${r.id}" >${r.name}
					        </label>
				            </c:forEach>
					</td>
	   		 	</tr>
	   		 </table>
	            <input type="hidden" name="id" value="${user.id}" />
          </form>
			<div class="form-btns">
			   <button type="button" class="btn btn-primary btn-sm" onclick="sub();">提交</button>
			</div>
	</div>
</div>
</div>
	<script type="text/javascript">
	$(".orgselect").chosen();//下拉插件
	$(function() {
		<c:forEach items="${user.roles}" var="k">
		$("input[name='roleId']:checkbox[value='${k.id}']").prop('checked',
				'true');
		</c:forEach>
	});
	function sub(){
		var checkName = checkEmpty($('[name="name"]'),'请填员工姓名');
		var checkLoginName = checkEmpty($('[name="loginName"]'),'请填写登录名');
		var checkOrg = checkEmpty($('[name="organization.id"]'),'请选择部门');
		
		if(checkName && checkLoginName && checkOrg){
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
