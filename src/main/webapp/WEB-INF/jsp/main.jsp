<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="shortcut icon" href="${pageContext.request.contextPath}/images/favicon.png" type="image/png">
<title>顶呱呱订单处理系统</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/tabs.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/font-awesome/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/swiper.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/orange_color.css">
<script src="${pageContext.request.contextPath}/js/jquery-2.1.1.min.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
<script src="${pageContext.request.contextPath}/artDialog/art_dialog.js"></script>
<!-- SockJS -->
<script src="${pageContext.request.contextPath}/js/websocket/sockjs-0.3.min.js"></script>
<script type="text/javascript">
	/*查询未读消息数*/
	function unread(){
		window.setInterval(weidu(),30000); 
	}
	function weidu(){
		 $.ajax({
	   			type : "GET",
	   			url : "${pageContext.servletContext.contextPath}/msg/unread.shtml",
	   			success:function(result) {
	   				if(result>0){
	   					$(".message-icon").addClass("active");
		   				$(".message-icon i").show().text(result);
		   				$(".message-icon i").css({"-webkit-animation":"twinkling 1s infinite ease-in-out"}); //在对象element中添加
	   				}else{
		   				$(".message-icon").removeClass("active");
	   				}
	   			}
	   		});
	}
		if (top.location != self.location)top.location=self.location; 
		//websocket相关
       var websocket;
       if (window.WebSocket) {
           websocket = new WebSocket("ws://"+window.location.host+"${pageContext.request.contextPath}/webSocketServer");
       } else if (window.MozWebSocket) {
           websocket = new MozWebSocket("ws://"+window.location.host+"${pageContext.request.contextPath}/webSocketServer");
       }else{
           websocket = new SockJS("http://"+window.location.host+"${pageContext.request.contextPath}/sockjs/webSocketServer");
       }
       websocket.onopen = function (evnt) {
	       	console.log('websocket.onopen');
       };
       websocket.onmessage = function (evnt) {
       		notify(evnt.data);//消息通知
       		weidu();
       		console.log('websocket.onmessage');
       };
       websocket.onerror = function (evnt) {
    		console.log('websocket.onclose');
       };
       websocket.onclose = function (evnt) {
    	   	console.log('websocket.onclose');
       };
       //html5通知
       function notify(data) {
    	   var data = eval("(" + data + ")"); 
    	   var title =  data.title;
    	   var msg =  data.msg;
    	   if (window.Notification) {
    		   console.log(window.Notification.permission);
    	       if (window.Notification.permission == 'granted'){
	    	        var instance = new window.Notification(title,{'icon':'images/favicon.png','body':msg});
	    	        instance.onclick = function () {
	    	        };
 	        		instance.onerror = function () {
 	        		};
 	        		instance.onshow = function () {
 	        			/* setTimeout(close, 3000);
 	        			function close(){
 	        				instance.close();
 	        			} */
 	        		};
 	        		instance.onclose = function () {
 	        		};
 	        		return false;
    	        } else {
    	        	window.Notification.requestPermission(function() {
    	        		console.log('Permissions state: ' + window.Notification.permission);
    	        	});
    	        }
    	    }
    	}
     </script>
     
<style type="text/css">
/* leftsead */
ul,li{margin: 0;padding: 0;border: 0;list-style:none;}
a, a:hover, a:focus {text-decoration: none;color: red;}
a:hover, a:active, a:focus {outline: none;}
#leftsead{width:161px;height:49px;position:fixed;top:125px;right:0px; z-index:100;}
#leftsead li a{height:49px;float:right;display:block;min-width:47px;max-width:161px;}
#leftsead li a .hides{margin-right:-143px;cursor:pointer;cursor:hand;}
#p3{width:112px;background-color:#EC9890;height:47px;margin-left:47px;border:1px solid #E6776C;text-align:center;line-height:47px}
#p1{width:47px;height:49px;float:left}
</style>

</head>
<body>
	<div class="header">
        <h1 class="logo"><img src="images/logo.png"></h1>
        <div class="nav-box">
	        <div class="nav demo one-box">
	            <ul class="nav-parent one-ul swiper-wrapper">
	                <li class="swiper-slide">
	                    <a href="javascript:;" onclick="addTab('首页','${pageContext.servletContext.contextPath}/index.jsp')"><i class="icon-home"></i><span>首页</span></a>
	                </li>
	            	<c:forEach var="key" items="${menu}">
	                 <li class="swiper-slide">
	                    <a href="javascript:void(0);"><i class="${key.icon} <c:if  test="${key.icon=='' || key.icon==null}">icon-list</c:if>"></i><span>${key.name}</span></a>
	                    <ul class="nav-child">
	                    <c:forEach var="kc" items="${key.children}">
	                        <li><a href="javascript:;" onclick="addTab('${kc.name}','${pageContext.servletContext.contextPath}${kc.resUrl}','${kc.resKey}')">
	                       	 <i class="${kc.icon} <c:if test="${kc.icon=='' || kc.icon==null}">icon-caret-right</c:if>" ></i>${kc.name}</a></li>
	                    </c:forEach>
	                    </ul>
	                </li>
	                </c:forEach>
	            </ul>
	                <!-- 左右切换 -->
	                <div class="nexts nav_LR">
	                    <a href="javascript:void(0)" class="prev border_r nav_L"> </a>
	                    <a href="javascript:void(0)" class="next nav_R"> </a>
	               </div>
	        </div>
        </div>
        <div style="clear:both"></div>
        <div class="main-slider">
            <!-- <a href="javascript:;" class="slider-close sliderClick"><i></i></a> -->
            <ul>
                <!-- <li class="background">
                    <a href="javascript:;" title="换肤"><i class="icon-dashboard"></i></a>
                    <div class="color-box">
                        <a href="javascript:;" title="绿色" class="color-green"></a>
                        <a href="javascript:;" title="红色" class="color-red"></a>
                        <a href="javascript:;" title="深蓝" class="color-deepBlue"></a>
                        <a href="javascript:;" title="浅蓝" class="color-lightBlue"></a>
                    </div>
                </li> -->
                <li><a href="javascript:updateTab('站内信','${pageContext.servletContext.contextPath}/msg/inbox.shtml');" class="message-icon" title="站内信消息记录"><span class="icon-bell"></span><i>0</i></a></li>
                <!-- <li><a href="javascript:logoutFun();" class="exit-icon" title="退出登录"><i class="icon-off"></i></a></li> -->
                <li class="user-li">
                    <a href="javascript:updateTab('个人设置','${pageContext.servletContext.contextPath}/user/user_seting.shtml');" class="user-img"><img src="${pageContext.servletContext.contextPath}${loger.avator!=null?loger.avator:'upload/avator/default.jpg'}" onerror="this.src='${pageContext.servletContext.contextPath}/upload/avator/default.jpg'"></a>
                  <%--   <div class="user-txt">
                        <p class="user-name">
                        <span class="top-span" title="${loger.name}">
                         ${loger.name}
                        </span>
                       </p>
                    </div> --%>
                    <div class="g-user-card">
                        <div class="card-inner">
                            <div class="card-top">
                                <img src="${pageContext.servletContext.contextPath}${loger.avator!=null?loger.avator:'upload/avator/default.jpg'}" onerror="this.src='${pageContext.servletContext.contextPath}/upload/avator/default.jpg'" alt="${loger.name}" class="l">
                                <span class="name text-ellipsis">${loger.name}</span>
                                <input type="hidden" id="seatNumber" value="${loger.seatNumber }">
                                <p class="meta">
                                	<span>帐号：${loger.loginName}</span>
                                	<span>部门：${loger.organization.name}</span>
                                </p>
                                <p class="meta">
                               	 角色：
                                <c:forEach var="r" items="${loger.roles}" varStatus="s">
									${s.count==1?"":", "}${r.name}
								</c:forEach>
                                </p>
                            </div>
                            <div class="card-sets clearfix">
                                <a href="javascript:updateTab('个人设置','${pageContext.servletContext.contextPath}/user/user_seting.shtml');" class="l">个人设置</a>
                                <a href="javascript:logoutFun();" class="r">退出</a>
                            </div>
                        </div>
                        <i class="card-arr"></i>
                    </div>
                </li>
            </ul>
        </div>
    </div>
    <div id="content" class="easyui-tabs" style="width: 100%">
    </div>
  <!--   <div class="bottom clearfix">
    <div class="l">
	    顶呱呱信息化平台- 订单处理系统
    </div>
    </div> -->
</body>

<script src="${pageContext.request.contextPath}/js/swiper.js"></script><!--一级菜单可左右滑动插件 js-->
<script>
function navSize(){
	$ul=$(window).width()-150-110-33;
    $(".nav-box").css("width",$ul);
    var $ul_wid=0;
    $(".one-ul>li").each(function(){
        $ul_wid=$ul_wid+$(this).width()+42;
        if ($ul_wid>$ul) {
            $(".nav_LR").show();
        }
        else {
            $(".nav_LR").hide();
        }
    });
}
$(window).resize(function(){
	navSize();
});
    $(function(){
    	navSize();
        //一级菜单可左右滑动插件 初始化
        var swiper = new Swiper('.demo', {
            slidesPerView: 'auto',
            paginationClickable: true,
            prevButton:'.prev',
            nextButton:'.next'
        });
    	/*查询未读消息数*/
    	unread();
    	 /*添加首页Tab*/
    	addIndexTab();
        //头部侧滑效果
        var isfirst=true;
        $(".sliderClick").click(function(){
        	  if(isfirst==true) {
  	        	var sliderW = $('.main-slider').width()-10+"px";
  	        	console.log("-"+sliderW);
                  $(this).parent().animate({right:"-"+sliderW});
              }
              else{
                  $(this).parent().animate({right:"0px"});
              }
              isfirst=!isfirst;
        });
    });
   
    /*添加首页Tab*/
	function addIndexTab(){
		var height=setSize();
		var index=' <iframe scrolling="auto" frameborder="0"  src="index.shtml" style="width:100%;height:'+height+';"></iframe>';
        $('#content').tabs('add',{
            height:height,
            title:"首页",
            content:index,
            closable:false
        });
	}
	/*添加Tab*/
    function addTab(title, url,name){
        if ($('#content').tabs('exists', title)){
            $('#content').tabs('select', title);
            iframe_h();
        } else {
        	var height=setSize();
            var content = "";
        	if(name != ''){
        		$('#leftsead #tel').children('a').attr("onclick",name+".window.callDown()");
        		content = '<iframe name='+name+' scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:'+height+'"></iframe>';
        	}else{
        		content = '<iframe name='+name+' scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:'+height+'"></iframe>';
        	}
            $('#content').tabs('add',{
            	height:height,
                title:title,
                content:content,
                closable:true
            });
            iframe_h();
        }
    }
	//更新tab,若存在刷新，不存在添加
	function updateTab(title, url){
		if ($('#content').tabs('exists', title)){
            $('#content').tabs('select', title);
            var height=setSize();
            var tab = $('#content').tabs('getSelected');
            var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:'+height+'"></iframe>';
            $('#content').tabs('update', {
            	tab: tab,
            	options: {
            	title: title,
            	content:content
            	}
            	});
            iframe_h();
        } else {
        	addTab(title, url);
        }
	}
	//关闭当前标签
	function closeTab(){
		var tab = $('#content').tabs('getSelected');
		var index = $('#content').tabs('getTabIndex',tab);
		$('#content').tabs("close",index);
	}
    /*窗口大小改变*/
    $(window).resize(function(){
        iframe_h();
    });
    /*窗口tab内容改变*/ 
    function iframe_h(){
    	var height=setSize();
        /* $("#content").css("height",height); */
        $("iframe").css("height",height);
    }
    /*获取高度*/
    var setSize = function(){
    	var height=$(window).height()-75+'px';
    	return height;
    };
    
    function logoutFun(){
    	msg.confirm("确认要退出吗?",function(){
    		window.location.href="${pageContext.servletContext.contextPath}/logout.shtml";
    	},"退出提醒");
    }
    //关闭当前页面
    function closeTabByIndex(index){
        $('#content').tabs("close",index);
    }
    //获取当前页面
    function getCurrentIndex(){
        var tab = $('#content').tabs('getSelected');
        var index = $('#content').tabs('getTabIndex',tab);
        return index;
    }
    
</script>
</html>
