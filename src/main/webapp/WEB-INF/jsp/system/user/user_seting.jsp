<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
<link href="${pageContext.request.contextPath}/js/jqueryChosen/chosen.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jqueryChosen/chosen.jquery.js"></script>
</head>
<body>
<div class="container-fluid">
	<div class="page-header clearfix">
 		<div class="pull-left">
       		<a href="javascript:window.location.reload();" class="btn btn-link btn-xs"><i class="icon-refresh"></i> 刷新页面</a>
      	</div>
     	<div class="pull-right crumbs">
     		<i class=" icon-map-marker"></i> <span>当前位置：个人设置 &gt; 个人资料</span>
      	</div>
    </div>
	 <div class="container-panel" style="min-height: 600px;">
	 <div class="container">
	 <div class="user-info">
<div class="info clearfix">
	<div class="img">
		<img src="${pageContext.servletContext.contextPath}${user.avator!=null?user.avator:'upload/avator/default.jpg'}" onerror="this.src='${pageContext.servletContext.contextPath}/upload/avator/default.jpg'" alt="${loger.name}" class="l">
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
</div>
	 <hr>
	 <div class="row">
 	  	<div class="col-md-2">
                <ul class="nav nav-pills nav-stacked">
                    <li class="active">
	                    <a href="#setprofile" aria-controls="home" role="tab" data-toggle="tab">
	                        <i class="icon-edit"></i>&nbsp;个人资料
	                    </a>
                    </li>
                    <li>
	                    <a href="#setavator" aria-controls="home" role="tab" data-toggle="tab"> 
		                    <i class="icon-eye-open"></i>&nbsp;头像设置
	                    </a>
                    </li>
                    <li>
                    	<a href="#setpwd" aria-controls="home" role="tab" data-toggle="tab">
                    		<i class="icon-key"></i>&nbsp;修改密码
                    	</a>
                    </li>
                     <li>
                    	<a href="${pageContext.servletContext.contextPath}/login_log/me.shtml">
                    		<i class="icon-file-alt"></i>&nbsp;&nbsp;登录日志
                    	</a>
                    </li>
                </ul>
            </div>
        <div class="col-md-4">
        	<div class="tab-content">
			    <div role="tabpanel" class="tab-pane active" id="setprofile">
					<form id="sub-profile" action="${pageContext.servletContext.contextPath}/user/setprofile.shtml" method="post">
						  <div class="form-group">
						    <label>*姓名：</label>
						    <input type="text" class="form-control" name="name" value="${user.name}" placeholder="名称">
						  </div>
						   <div class="form-group">
						    <label>*部门：</label>
						    <select class="form-control input-sm orgselect" name="organization.id">
					            <c:forEach var="r" items="${organizations}" varStatus="s">
					            	<option value="${r.id}" <c:if test="${user.organization.id==r.id}">selected</c:if> >${r.name}</option>
					            </c:forEach>
			              </select>
						  </div>
						  <div class="form-group">
						    <label>*性别：</label>
						    <select class="form-control" name="sex">
			   		 			<option value="" <c:if test="${user.sex==null}">selected</c:if> >请选择</option>
						        <option value="男" <c:if test="${user.sex=='男'}">selected</c:if> >男</option>
						        <option value="女" <c:if test="${user.sex=='女'}">selected</c:if> >女</option>
					           </select>
						  </div>
						   <div class="form-group">
						    <label>联系电话：</label>
						    <input type="text" class="form-control" name="phone" value="${user.phone}" placeholder="联系电话">
						  </div>
						  <div class="form-group">
						    <label>坐席号：</label>
						    <input type="text" class="form-control" name="seatNumber" value="${user.seatNumber}" placeholder="坐席号">
						  </div>
						  <div class="form-group">
						    <label>个人介绍：</label>
						    <textarea class="form-control" name="description" placeholder="个人简介" rows="3">${user.description}</textarea>
						  </div>
						  <div class="form-group">
							  <label>代理人：</label>
							  <select id="theAgentId" class="form-control input-sm userList" name="theAgentId">
								  <option value="">请选择代理人</option>
								  <c:forEach var="u" items="${users}">
									  <option value="${u.id}" <c:if test="${user.theAgentId==u.id}">selected</c:if>>${u.name}</option>
								  </c:forEach>
							  </select>
						  </div>
						  <div class="form-group">
						 		 <button type="button" class="btn btn-success btn-block" onclick="setProfile();">保存</button>
						  </div>
				</form>
				</div>
			    	<div role="tabpanel" class="tab-pane" id="setavator">
						<div class="form-group">
			              <label>设置头像：</label>
			              	<div class="litpic_show">
							    <div style="float:left;">
							    	<input type="hidden" name="avator" id="litpic" value="${user.avator}"/>
							    </div>
							    <div class="litpic_tip"></div>
							    <div id="litpic_show"> 
							    	<img src="${pageContext.servletContext.contextPath}/${user.avator!=null?user.avator:'upload/avator/default.jpg'}" onerror="this.src='${pageContext.servletContext.contextPath}/upload/avator/default.jpg'" width="150" height="150">
							    </div>
								<div class="litpic_btn">
							        <button type="button" class="btn btn-success btn-block">添加图片</button>
							        <input id="fileupload" type="file" name="avatorFile">
							    </div>
							</div>
			            </div>
					</div>
					<div role="tabpanel" class="tab-pane" id="setpwd">
						<form id="sub-pwd" action="${pageContext.servletContext.contextPath}/user/setpwd.shtml" method="post">
						  <div class="form-group">
						    <label>*当前密码：</label>
						    <input type="password" class="form-control" name="nowPwd" placeholder="请输入当前密码">
						  </div>
						  <div class="form-group">
						    <label>*新密码：</label>
						    <input type="password" class="form-control" name="newPwd"placeholder="请输入新密码">
						  </div>
						   <div class="form-group">
						    <label>确认新密码：</label>
						    <input type="password" class="form-control" name="confirmPwd" placeholder="请再次输入新密码">
						  </div>
						   <div class="form-group">
						 		 <button type="button" class="btn btn-success btn-block" onclick="setPwd();">保存</button>
						  </div>
						</form>
					</div>
			  </div>
		</div>
		</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(".orgselect").chosen();//下拉插件
	$('#theAgentId').chosen();
	$(function(){
		//缩略图上传
		var litpic_tip = $(".litpic_tip");
		var btn = $(".litpic_btn .btn");
		$("#fileupload").wrap("<form id='myupload' action='${pageContext.servletContext.contextPath}/user/setavator.shtml' method='post' enctype='multipart/form-data'></form>");
	    $("#fileupload").change(function(){
	    	if($("#fileupload").val() == "") return;
	    	var fileName = $("#fileupload").val();
	    	var fileExtension = fileName.split('.').pop().toLowerCase();
	    	var tp ="jpg,JPG,png,PNG";
	    	//返回符合条件的后缀名在字符串中的位置
	    	var rs=tp.indexOf(fileExtension);
	    	//如果返回的结果大于或等于0，说明包含允许上传的文件类型
	    	if(rs<0){
	    		litpic_tip.html("请上传jpg,png格式图片");
	    	 	return false;
    	  }
			$("#myupload").ajaxSubmit({
				dataType:  'json',
				beforeSend: function() {
	        		$('#litpic_show').empty();
					btn.html("上传中...");
	    		},
				success: function(data) {
					if(data.status == 1){
						litpic_tip.html("上传成功");
						var img = data.data;//图
						$('#litpic_show').html("<img src='${pageContext.servletContext.contextPath}"+img+"' width='150' height='150'>");
						$("#litpic").val(img);
					}else {
						litpic_tip.html(data.state);
					}			
						btn.html("添加图片");
				},
				error:function(xhr){
					btn.html("上传失败");
					litpic_tip.html(xhr);
				}
			});
		});

	});
	function setProfile(){
		var checkName = checkEmpty($('[name="name"]'),'请填姓名');
		var checkPhone = checkEmpty($('[name="phone"]'),'请填写key');
		var checkSex = checkEmpty($('[name="sex"]'),'请选择性别');
		var checkDescription = checkLength($('[name="description"]'),'个人介绍最多250个字',0,250);
		if(checkName && checkPhone && checkSex && checkDescription){
		$.ajax({
			type : "POST",
			data : $("#sub-profile").serialize(),
			url : $("#sub-profile").attr("action"),
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
	function setPwd(){
		var checkNow = checkEmpty($('[name="nowPwd"]'),'请输入当前密码');
		var checkNew = checkLength($('[name="newPwd"]'),'请输入6-18位新密码',6,18);
		var checkConfirm = checkEmpty($('[name="confirmPwd"]'),'请再次输入新密码');
		var newP=$('[name="newPwd"]').val();
		var confirmP=$('[name="confirmPwd"]').val();
		if(confirmP!=newP){
			$('[name="confirmPwd"]').err("两次输入的密码不匹配");
			return false;
		}else{
			$('[name="confirmPwd"]').closeErr();
		}
		if(checkNow && checkNow && checkConfirm){
		$.ajax({
			type : "POST",
			data : $("#sub-pwd").serialize(),
			url : $("#sub-pwd").attr("action"),
			dataType : 'json',
			success:function(data) {
				if(data.status==1){
					msg.confirm(data.info,function(){
						window.location.href="${pageContext.servletContext.contextPath}/logout.shtml";
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
	//验证长度
	function checkLength(obj,msg,start,end){
		var check = false;
		var val = obj.val();
		if(val.length>end || val.length<start){
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
