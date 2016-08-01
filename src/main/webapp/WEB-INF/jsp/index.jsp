<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="header.jsp"/>
    <style>
        .table-responsive {
            height: 370px;
        }
        .table th,td{text-align: center;}
    </style>
</head>
<body>
<div class="container-fluid">
    <div class="page-header clearfix">
        <div class="pull-left">
            <a href="javascript:window.location.reload();" class="btn btn-link btn-xs"><i class="icon-refresh"></i> 刷新页面</a>
        </div>
        <div class="pull-right crumbs">
            <i class=" icon-map-marker"></i> <span>当前位置：首页</span>
        </div>
    </div>
    <div class="alert alert-danger" role="alert">

        <p><span class="glyphicon glyphicon-exclamation-sign"></span> 通知1：下单的用户数据和资源数据与CRM是一致的</p>
        <p><span class="glyphicon glyphicon-exclamation-sign"></span> 通知2：现在所有技术部同事已经停止使用企业QQ,系统问题请直接反馈至<span style="color:red;">产品经理-高成涛</span>处，实在是八百里加急的问题请直接邮件到开发负责人汤宏的邮箱tanghong@dgg.net或钉钉</p>
    </div>
    <div class="row">
        <shiro:hasAnyRoles name="order_xdzy,root">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a href="javascript:void(0);" onclick="audit();" title="查看更多">待下单</a>
                        <span class="label label-danger">${myAuditOrder.size()}</span>
                        <div class="pull-right">
                            <c:if test="${myAuditOrder.size()>10}">
                                <a href="javascript:void(0);" onclick="audit();" title="查看更多">更多<i class="icon-double-angle-right"></i></a>
                            </c:if>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-condensed table-bordered">
                            <thead>
                            <tr>
                                <th>订单编号</th>
                                <th>客户名称</th>
                                <th>业态</th>
                                <th>下单商务</th>
                                <th>商务申请时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <c:forEach items="${myAuditOrder}" var="order" begin="0" end="9">
                                <tr>
                                    <td>${order.orderNo}</td>
                                    <td>${order.customerName}</td>
                                    <td>${order.businessTypeName}</td>
                                    <td>${order.businessUser.name}</td>
                                    <td><fmt:formatDate pattern="YYYY/MM/dd HH:mm" value="${order.createTime}"/></td>
                                    <td>
                                        <a href="javascript:;" class="btn btn-primary btn-xs" onclick="window.parent.updateTab('下单${order.orderNo}','${pageContext.servletContext.contextPath}/order/under_order.shtml?orderId=${order.id}');">
                                            下单
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty myAuditOrder}">
                                <td colspan="6" class="td-center">无待审核订单</td>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </shiro:hasAnyRoles>
        <shiro:hasAnyRoles name="order_rkzy,root">
        <div class="col-md-6">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="javascript:window.parent.updateTab('我的待核款','${pageContext.request.contextPath}/payment/stay_payment.shtml');" title="查看等多">待核款订单</a>
                     <span class="label label-danger">${orderPayRecord.size()}</span>
                    <div class="pull-right">
                        <c:if test="${orderPayRecord.size()>10}">
                            <a href="javascript:window.parent.updateTab('我的待核款','${pageContext.request.contextPath}/payment/stay_payment.shtml');" title="查看等多">更多<i class="icon-double-angle-right"></i></a>
                        </c:if>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-condensed table-bordered">
                        <thead>
                        <tr>
                            <th>核款编号(红色超期)</th>
                            <th>申请商务</th>
                            <th>申请时间</th>
                            <th>核款金额(元)</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <c:forEach items="${orderPayRecord}" var="key" begin="0" end="9">
                            <c:if test="${date.time - key.applyTime.time >0}">
                                <tr style="color: red;">
                                    <td><a href="javascript:;" onclick="window.parent.updateTab('核款${key.paymentNo}','${pageContext.servletContext.contextPath}/payment/payment_detail.shtml?id=${key.id}');"><span style="color: red;">${key.paymentNo}</span></a></td>
                                    <td>${key.order.businessUser.name}</td>
                                    <td><fmt:formatDate value="${key.applyTime}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td>￥<fmt:formatNumber type="number" value="${key.realAmount}" maxFractionDigits="2" pattern="0.00"></fmt:formatNumber></td>
                                    <td>
                                        <a href="javascript:;"
                                           onclick="window.parent.updateTab('核款','${pageContext.request.contextPath}/payment/payment_nuclear.shtml?id=${key.id}');">
                                            <span class="btn btn-info btn-xs">立即核款</span>
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                            <c:if test="${date.time - key.applyTime.time <= 0}">
                                <tr>
                                    <td><a href="javascript:;" onclick="window.parent.updateTab('核款${key.paymentNo}','${pageContext.servletContext.contextPath}/payment/payment_detail.shtml?id=${key.id}');">${key.paymentNo}</a></td>
                                    <td>${key.order.businessUser.name}</td>
                                    <td><fmt:formatDate value="${key.applyTime}" pattern="yyyy/MM/dd HH:mm"/></td>
                                    <td>￥<fmt:formatNumber type="number" value="${key.realAmount}" maxFractionDigits="2" pattern="0.00"></fmt:formatNumber></td>
                                    <td>
                                        <a href="javascript:;"
                                           onclick="window.parent.updateTab('核款','${pageContext.request.contextPath}/payment/payment_nuclear.shtml?id=${key.id}');">
                                            <span class="btn btn-info btn-xs">立即核款</span>
                                        </a>
                                    </td>
                                </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty orderPayRecord}">
                            <td colspan="5" class="td-center">无待核款订单</td>
                        </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        </shiro:hasAnyRoles>
        <shiro:hasAnyRoles name="order_htlcfzr,root">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a href="javascript:window.parent.updateTab('待分配订单','${pageContext.request.contextPath}/ob/manager_allot.shtml');" title="查看更多">待分配订单</a>
                        <span class="label label-danger">${myAllotOrderBusinessHt.size()}</span>
                        <div class="pull-right">
                            <c:if test="${myAllotOrderBusinessHt.size()>10}">
                                 <a href="javascript:window.parent.updateTab('待分配订单','${pageContext.request.contextPath}/ob/manager_allot.shtml');" title="查看更多">更多<i class="icon-double-angle-right"></i></a>
                            </c:if>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-condensed table-bordered">
                            <thead>
                            <tr>
                                <th>子订单</th>
                                <th>大业态</th>
                                <th>订单业务</th>
                                <th>下单时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <c:forEach items="${myAllotOrderBusinessHt}" var="ob" begin="0" end="9">
                                <tr>
                                    <td><a href="javascript:;"
                                           onclick="orderBusinessInfo(${ob.id});">${ob.orderBusinessNo}</a></td>
                                    <td>${ob.order.businessType.name}</td>
                                    <td>${ob.businessClass.name}</td>
                                   <td><fmt:formatDate pattern="YYYY/MM/dd HH:mm"
                                                        value="${ob.order.approvalTime}"/></td>
                                    <td>
                                        <a href="javascript:void(0);" class="btn btn-primary btn-xs assignOrderFzr"
                                           data-id="${ob.id}">分单</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty myAllotOrderBusinessHt}">
                                <td colspan="6" class="td-center">无待分配订单</td>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </shiro:hasAnyRoles>
        <shiro:hasAnyRoles name="order_lcclry,root">
            <div class="col-md-6">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <a href="javascript:window.parent.updateTab('待处理订单','${pageContext.request.contextPath}/ob/my_pending.shtml');" title="查看更多">待处理订单</a>
                        <span class="label label-danger">${myAllotOrderBusinessCL.size()}</span>
                        <div class="pull-right">
                            <c:if test="${myAllotOrderBusinessCL.size()>10}">
                                <a href="javascript:window.parent.updateTab('待处理订单','${pageContext.request.contextPath}/ob/my_pending.shtml');" title="查看更多">更多<i class="icon-double-angle-right"></i></a>
                            </c:if>
                        </div>
                    </div>
                    <div class="table-responsive">
                        <table class="table table-condensed table-bordered">
                            <thead>
                            <tr>
                                <th>子订单</th>
                                <th>订单业务</th>
                                <th>当前节点</th>
                                <th>开始时间</th>
                                <th>截至时间</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <c:forEach items="${myAllotOrderBusinessCL}" var="ob" begin="0" end="9">
                                <tr>
                                    <td><a href="javascript:;"
                                           onclick="orderBusinessInfo(${ob.id});">${ob.orderBusinessNo}</a></td>
                                    <td>${ob.businessClass.name}</td>
                                    <td>${ob.nodeName}</td>
                                    <td><fmt:formatDate pattern="YYYY/MM/dd HH:mm" value="${ob.openTime}"/></td>
                                    <td><fmt:formatDate pattern="YYYY/MM/dd HH:mm" value="${ob.endTime}"/></td>
                                    <td>
                                        <a href="javascript:void(0);" class="pendingPage" data-id="${ob.id}"
                                           data-nodeName="${ob.nodeId}" data-userId="${ob.attnUser.id}">
                                            <span class="label label-success">下一步</span>
                                        </a>
                                        <a href="javascript:void(0);" class="processBack" data-id="${ob.id}"
                                           data-nodeName="${ob.nodeName}" data-status="${ob.status}">
                                            <span class="btn btn-danger btn-xs">退回</span>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty myAllotOrderBusinessCL}">
                                <td colspan="6" class="td-center">无待处理订单</td>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </shiro:hasAnyRoles>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/order.js"></script>
<script type="text/javascript">
    function audit() {
        parent.updateTab("待下单", "${pageContext.request.contextPath}/order/place_the_order.shtml");
    }
</script>
</body>
</html>
