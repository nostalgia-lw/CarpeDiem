<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<div class="content" style="width: 400px;">
<p>发送人：<a href="javascript:;" class="show-user-info" data-id="${message.sender.id}">${message.sender.name}</a>(<fmt:formatDate pattern="YYYY/MM/dd HH:mm:ss"  value="${message.sendTime}" />)</p>
<p>接收人：<a href="javascript:;" class="show-user-info" data-id="${message.toUser.id}">${message.toUser.name}</a>(<c:if test="${message.readTime==null}">未读</c:if>
             <c:if test="${message.readTime!=null}"><fmt:formatDate pattern="YYYY/MM/dd HH:mm:ss"  value="${message.readTime}" /></c:if>)</p>
 <hr>
<p>${message.content}</p>
</div>
