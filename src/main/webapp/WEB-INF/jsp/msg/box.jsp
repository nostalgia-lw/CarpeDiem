<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://cddgg.com/jstl/pager" prefix="p"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../header.jsp" />
</head>
<body>
	<div class="container-fluid">
	<div class="page-header clearfix">
 		<div class="pull-left">
       		<a href="javascript:window.location.reload();" class="btn btn-link btn-xs"><i class="icon-refresh"></i> 刷新页面</a>
      	</div>
     	<div class="pull-right crumbs">
     		<i class=" icon-map-marker"></i> <span>当前位置：站内信</span>
      	</div>
    </div>
 	  <div class="container-panel row">
 	  	<div class="col-sm-3 col-lg-2">
            <!--     <a href="compose.html" class="btn btn-danger btn-block btn-compose-email">发送站内信</a> -->
                
                <ul class="nav nav-pills nav-stacked nav-email">
                    <li class="<c:if test="${box==1}">active</c:if>">
	                    <a href="${pageContext.servletContext.contextPath}/msg/inbox.shtml">
	                        <span class="badge pull-right inbox ">0</span>
	                        <i class="glyphicon glyphicon-inbox"></i> 收件箱
	                    </a>
                    </li>
                    <li class="<c:if test="${box==2}">active</c:if>">
	                    <a href="${pageContext.servletContext.contextPath}/msg/outbox.shtml"> 
		                    <i class="glyphicon glyphicon-send"></i> 发件箱
	                    </a>
                    </li>
                    <li class="<c:if test="${box==3}">active</c:if>">
                    	<a href="${pageContext.servletContext.contextPath}/msg/sysbox.shtml">
                    	 	<span class="badge pull-right sysbox">0</span>
                    		<i class="glyphicon glyphicon-star"></i> 系统消息
                    	</a>
                    </li>
                    <li><a href="#"><i class="glyphicon glyphicon-trash"></i> 已删除</a></li>
                </ul>
            </div>
            <div class="col-sm-9 col-lg-10">
 	 		<div class="tool-view">
 	 		<div class="clearfix">
	 	 		<div class="pull-left">
						<h3>
						<c:if test="${box==1}">收件箱</c:if>
						<c:if test="${box==2}">发件箱</c:if>
						<c:if test="${box==3}">系统消息</c:if>
						</h3>
	 	 		</div>
	 	 		<div class="pull-right">
				  <form action="" method="post" class="form-inline">
					  <div class="form-group">
					    <input type="text" class="form-control input-sm" name="keyword" value="${param.keyword}" placeholder="关键字搜索">
					  </div>
					  <button type="submit" class="btn btn-primary btn-sm">快速搜索</button>
					</form>
	 	 		</div>
 	 		</div>
		</div>
 	 	<div class="content">
          <table class="table table-bordered table-condensed">
            <thead>
              <tr>
              	<th style="width: 30px;"><input type="checkbox" class="check-all"></th>
                <th>内容</th>
                <th>发送人</th>
                <th>发送时间</th>
                <th>接收人</th>
                <th>阅读时间</th>
                <th>类型</th>
                <th>查看</th>
              </tr>
            </thead>
            <tbody>
            <c:forEach var="key" items="${page.items}" varStatus="s">
               <tr>
             	<td><input type="checkbox" class="ids" value="${key.id}"></td>
                <td><a href="javascript:;" class="read-info" data-id="${key.id}">${key.content}</a></td>
                <td><a href="javascript:showUserInfo(${key.sender.id});">${key.sender.name}</a></td>
				<td><fmt:formatDate pattern="YYYY/MM/dd HH:mm:ss"  value="${key.sendTime}" /></td>
                <td><a href="javascript:showUserInfo(${key.toUser.id});">${key.toUser.name}</a></td>
                <td><c:if test="${key.readTime==null}">未读</c:if>
                <c:if test="${key.readTime!=null}"><fmt:formatDate pattern="YYYY/MM/dd HH:mm:ss"  value="${key.readTime}" /></c:if>
                </td>
                <td>${key.type==0?"系统消息":"站内信息"}</td>
                 <td><a href="javascript:;" class="read-info" data-id="${key.id}">查看</a>|<a href="javascript:;" class="delete-info" data-id="${key.id}">删除</a></td>
              </tr>
			</c:forEach>
            </tbody>
          </table>
          <div class="clearfix">
 	 		<div class="pull-left">
 	 			 <div class="btn-group" role="group">
				    <button type="button" class="btn btn-default dropdown-toggle btn-sm" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
				      	其他操作
				      <span class="caret"></span>
				    </button>
				    <ul class="dropdown-menu">
				      <li><a href="javascript:readAll();">标记已读</a></li>
				      <li><a href="javascript:deleteAll();">删除所选</a></li>
				    </ul>
				  </div>
 	 		</div>
 	 		<div class="pull-right">
	           	 <p:pager pageSize="${page.pageSize}" pageNo="${page.curIndex}" url="" recordCount="${page.rowsCount}" />
 	 		</div>
            </div>
      	</div>
      	</div>
   	</div>
</div>

<script type="text/javascript">
	$(function(){
		$.ajax({
   			type : "GET",
   			url : "${pageContext.servletContext.contextPath}/msg/unread.shtml?type=1",
   			success:function(result) {
   				$(".inbox").text(result);
   			}
   		});
		$.ajax({
   			type : "GET",
   			url : "${pageContext.servletContext.contextPath}/msg/unread.shtml?type=0",
   			success:function(result) {
   				$(".sysbox").text(result);
   			}
   		});
		 //读取信息
		   $('.read-info').click(function(){
			   var id=$(this).attr('data-id');
			   model.info("信息详细",pathName+"/msg/read.shtml?id="+id); 
		   });
		 //删除信息
		   $('.delete-info').click(function(){
			   var id=$(this).attr('data-id');
			   $.post('${pageContext.servletContext.contextPath}/msg/delete.shtml',{id:id},function(data){
				   if(data.status=='success'){
					   msg.info("删除成功!");
					   setTimeout("window.location.reload();", 1000);
				   }else{
					   msg.info("删除信息失败,请联系管理员");
				   }
			   },'json');
		   });
	});
	/**
	已读
	**/
	function readAll(){
		var _ids = $(".ids:checked");
		if(_ids.length>0){
			var ids = "";
			for (var i = 0; i < _ids.length; i++) {
				if(i==0){
					ids+="'"+_ids[i].value+"'";
				}else{
					ids+=",'"+_ids[i].value+"'";
				}
			}
			msg.confirm("确认全部标记已读？", function(){
				$.ajax({
		   			type : "post",
		   			url : "${pageContext.servletContext.contextPath}/msg/read_all.shtml",
		   			data:{ids:ids},
		   			dataType:'json',
		   			success:function(result) {
		   				if(result.status==1){
		   					msg.info(result.info);
		   					setTimeout(
									function(){
										window.location.reload();
									},
								2000);
						}else{
							msg.info(result.info);
						}
		   			}
		   		});
			}, "确认操作？");
		}
	} 
	/**
	删除
	**/
	function deleteAll(){
		var _ids = $(".ids:checked");
		if(_ids.length>0){
			var ids = "";
			for (var i = 0; i < _ids.length; i++) {
				if(i==0){
					ids+="'"+_ids[i].value+"'";
				}else{
					ids+=",'"+_ids[i].value+"'";
				}
			}
			msg.confirm("确认全部标记已读？", function(){
				$.ajax({
		   			type : "post",
		   			url : "${pageContext.servletContext.contextPath}/msg/delete_all.shtml",
		   			data:{ids:ids},
		   			dataType:'json',
		   			success:function(result) {
		   				if(result.status==1){
		   					msg.info(result.info);
		   					setTimeout(
									function(){
										window.location.reload();
									},
								2000);
						}else{
							msg.info(result.info);
						}
		   			}
		   		});
			}, "确认操作？");
		}
	} 
</script>
</body>
</html>