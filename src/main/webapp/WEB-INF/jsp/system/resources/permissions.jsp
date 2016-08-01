<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
<style type="text/css">


.mytable {
 width: 660px;
 padding: 0;
 margin: 0;
}
th {
 font: bold 13px "Trebuchet MS", Verdana, Arial, Helvetica, sans-serif;
 border-right: 1px solid #ddd;
 border-bottom: 1px solid #ddd;
 border-top: 1px solid #ddd;
 letter-spacing: 2px;
 text-transform: uppercase;
 text-align: left;
 padding: 4PX;
}
.mytable td {
 border-right: 1px solid #ddd;
 border-bottom: 1px solid #ddd;
 padding: 4px;
}

th.specalt {
 border-left: 1px solid #ddd;
 border-top: 1px solid #ddd;
 background: #FFFFFF;
}
/*---------for IE 5.x bug*/
html>body td{ font-size:13px;}

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
        <span>角色授权(${role.name})</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
<div class="container-fluid">
 	  <div class="container-panel">
 	 	<div class="content">
 	 		 <form method="post" id="from" name="form">
				<table class="mytable">
					<tr>
					    <th class="specalt">一级菜单</th>
					    <th class="specalt"><span>二级菜单</span><span style="float: right;margin-right: 150px;">按扭</span></th>
					  </tr>
					<c:forEach items="${permissions}" var="k">
					<tr>
						<th class="specalt">
							<input type="checkbox" name="resId" id="menu" _key="menu_${k.id}" onclick="smenu(this,'${k.id}')" value="${k.id}">${k.name}
						</th>
						<th class="specalt">
							<table class="mytable" style="width: 100%;height: 100%;">
									<c:forEach items="${k.children}" var="kc">
								<tr>
									<th class="specalt">
										<input type="checkbox"  name="resId" id="menu" _key="menu_1_${k.id}" _key_1="menu_1_1_${kc.id}" onclick="menu_1(this,'${kc.id}','${k.id}')"  value="${kc.id}">${kc.name}
									</th>
									<th class="specalt">
										<table class="mytable" style="width: 100%;height: 100%;">
												<c:forEach items="${kc.children}" var="kcc">
											<tr>
												<th class="specalt">
									   				<input type="checkbox"  name="resId" id="menu" _key="menu_1_1_${k.id}" _key_2="menu_1_1_${kc.id}" onclick="menu_1_1(this,'${kc.id}','${k.id}')" value="${kcc.id}">${kcc.name}
												</th>
											</tr>
												</c:forEach>
										</table>
										</th>
								</tr>
									</c:forEach>
							</table>
							</th>
					</tr>
						</c:forEach>
				</table>
					<input id='roleId' name="roleId" type="hidden" value="${param.roleId}">
				</form>
				<div class="form-btns">
			   		<button type="button" class="btn btn-primary btn-sm" onclick="sub();">保存</button>
				</div>
      	</div>
   	</div>
</div>
	<script type="text/javascript">
		function smenu(obj, id) {
			$("input[_key='menu_1_" + id + "']").each(function() {
				$(this).prop("checked", obj.checked);
			});
			$("input[_key='menu_1_1_" + id + "']").each(function() {
				$(this).prop("checked", obj.checked);
			});
		};
		function menu_1(obj, id, pid) {
			$("input[_key_2='menu_1_1_" + id + "']").each(function() {
				$(this).prop("checked", obj.checked);
			});
			if (obj.checked == true) {
				$("input[_key='menu_" + pid + "']").each(function() {
					$(this).prop("checked", obj.checked);
				});
			}
		};
		function menu_1_1(obj, id, pid) {
			if (obj.checked == true) {
				$("input[_key_1='menu_1_1_" + id + "']").each(function() {
					$(this).prop("checked", obj.checked);
				});
				$("input[_key='menu_" + pid + "']").each(function() {
					$(this).prop("checked", obj.checked);
				});
			}
		}
		function sub(){
			$.ajax({
				async : false, //请勿改成异步，下面有些程序依赖此请数据
				type : "POST",
				data : $("#from").serialize(),
				url : '${pageContext.request.contextPath}/resources/add_role_res.shtml',
				dataType : 'json',
				success : function(data) {
					if(data.status==1){
						msg.confirm(data.info,function(){
							window.location.reload();
				    	},"操作提示");
					}else{
						msg.info("操作失败，请重试");
					}
				}
			});
		}
		$(function() {
			var roleId= ${role.id};
			$.ajax({
				async : false, //请勿改成异步，下面有些程序依赖此请数据
				type : "POST",
				data : {roleId:roleId},
				url : '${pageContext.request.contextPath}/resources/get_role_resources.shtml',
				dataType : 'json',
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
						$("input[name='resId']:checkbox[value='"+data[i].id+"']").prop('checked',
						'true');
					}
				}
			});
		});
	</script>
</body>
</html>
