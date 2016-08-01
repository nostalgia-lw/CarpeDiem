<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<jsp:include page="../../header.jsp" />
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/zTreeStyle/zTreeStyle.css">
<script src="${pageContext.request.contextPath}/js/jquery.ztree.core-3.5.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.ztree.exedit-3.5.js"></script>

<style type="text/css">
div.zorgtreeBackground {width:250px;height:362px;text-align:left;}
.ztree li span.button.add {margin-left:2px; margin-right: -1px;margin-top: 2px; background-image:url('../css/zTreeStyle/img/addMenu.png'); vertical-align:top; *vertical-align:middle}
div.content_wrap {
width: 800px;
height: 580px;
padding-top:10px;
}
div.buttons {
padding-left:20px;
margin-top: 9px;
}
div.content_wrap div.left{
float: left;
width: 300px;
}
ul.ztree {
border: 1px solid #ddd;
background: #f8f8ff;
height: 580px;
overflow-y: scroll;
overflow-x: auto;
margin-left: 21px;
}
div.content_wrap div.right {
float: right;
width: 450px;
}
div.form-group input{
width: 200px;
}
</style>
</head>
<body>
<!--操作栏 start-->
<div class="main-top">
    <div class="opera-bar">
        <ul>
            <li><a href="javascript:window.location.reload();"><i class="icon-refresh color-green"></i><span>刷新页面</span></a></li>
        </ul>
    </div>
    <div class="history">
        <i class="icon-map-marker"></i>
        <label>当前位置：</label>
        <span>系统管理</span>
        &nbsp;&rsaquo;&nbsp;
        <span>部门管理</span>
    </div>
    <div style="clear:both"></div>
</div>
<!--操作栏 end-->
	<section>
<div class="buttons">
<button type="button" class="btn btn-primary" onclick="buttonOnClickAdd()">添根部门</button>
</div>
<div class="content_wrap">
	<div class="zorgtreeBackground left">
		<ul id="orgtree" class="ztree" ></ul>
	</div>
	<div class="right">
	<form class="form-horizontal" id="Treeform" style="display:none;">
		<input type="hidden" id="Id" value="">
        <div class="form-group">
          <label for="inputEmail3" class="col-sm-2 control-label">菜单名</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="menu_name">
          </div>
        </div>
        <div class="form-group">
          <label for="inputPassword3" class="col-sm-2 control-label">描述</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="menu_note">
          </div>
        </div>
        <div class="form-group">
          <label for="inputPassword3" class="col-sm-2 control-label">排序</label>
          <div class="col-sm-10">
            <input type="text" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" class="form-control" id="menu_dsn">
          </div>
        </div>
        <div class="form-group" style="margin-left: 226px;">
    	<button type="button" class="btn btn-primary" id="add_sub">保存</button>
        </div>
        
      </form>
      	<form class="form-horizontal" id="upTreeform" style="display:none;">
		<input type="hidden" id="Id" value="">
        <div class="form-group">
          <label for="inputEmail3" class="col-sm-2 control-label">菜单名</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="upmenu_name">
          </div>
        </div>
        <div class="form-group">
          <label for="inputPassword3" class="col-sm-2 control-label">描述</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="upmenu_note">
          </div>
        </div>
        <div class="form-group">
          <label for="inputPassword3" class="col-sm-2 control-label">排序</label>
          <div class="col-sm-10">
            <input type="text" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" class="form-control" id="upmenu_dsn">
          </div>
        </div>
        <div class="form-group" style="margin-left: 226px;">
    	<button type="button" class="btn btn-primary" id="mody_sub">修改</button>
        </div>
      </form>
      	<form class="form-horizontal" id="childTreeform" style="display:none;">
		<input type="hidden" id="Id" value="">
        <div class="form-group">
          <label for="inputEmail3" class="col-sm-2 control-label">菜单名</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="chmenu_name">
          </div>
        </div>
        <div class="form-group">
          <label for="inputPassword3" class="col-sm-2 control-label">描述</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="chmenu_note">
          </div>
        </div>
        <div class="form-group">
          <label for="inputPassword3" class="col-sm-2 control-label">排序</label>
          <div class="col-sm-10">
            <input type="text" onkeyup="this.value=this.value.replace(/[^\d]/g,'')" class="form-control" id="chmenu_dsn">
          </div>
        </div>
        <div class="form-group" style="margin-left: 226px;">
    	<button type="button" class="btn btn-primary" id="child_sub">保存</button>
        </div>
      </form>
	</div>
</div>
	</section>
<script type="text/javascript">
var parentNode;
$(document).ready(function(){
		createTree(); 
	 $("#child_sub").click(function(){
		 	var menu_name=checkEmpty($("#chmenu_name"),"请输入部门名称");
		 	var name=$("#chmenu_name").val();
		 	var menu_note=$("#chmenu_note").val();
		 	var menu_dsn=$("#chmenu_dsn").val();
		 	var pid=parentNode.id;
		 	if(menu_name){
		 		$.post('save.shtml',{pid:pid,name:name,description:menu_note,sort:menu_dsn},function(datas){
							if(datas.status==true){
								var zTree = $.fn.zTree.getZTreeObj("orgtree");
								var vl=$.parseJSON(datas.data);
								var nodes={id:vl.id,name:vl.name,open:true,icon:'../css/zTreeStyle/img/diy/3.png'};
								zTree.addNodes(parentNode,nodes);
								$("#childTreeform").hide();
							}else{
								msg.info("添加失败,请联系管理员");
							}
		 		},'json');
		 	}
	 	});
	 $("#add_sub").click(function(){
		 	var menu_name=checkEmpty($("#menu_name"),"请输入部门名称");
		 	var name=$("#menu_name").val();
		 	var menu_note=$("#menu_note").val();
		 	var menu_dsn=$("#menu_dsn").val();
		 	if(menu_name){
		 		$.post('save.shtml',{name:name,description:menu_note,sort:menu_dsn},function(datas){
							if(datas.status==true){
								var zTree = $.fn.zTree.getZTreeObj("orgtree");
								var vl=$.parseJSON(datas.data);
								var nodes={id:vl.id,name:vl.name,open:true,icon:'../css/zTreeStyle/img/diy/1_open.png'};
								zTree.addNodes(null,nodes);
								$("#Treeform").hide();
							}else{
								msg.info("添加失败,请联系管理员");
							}
		 		},'json');
		 	}
	 	});
	 $("#mody_sub").click(function(){
		 	var menu_name=checkEmpty($("#upmenu_name"),"请输入部门名称");
		 	var name=$("#upmenu_name").val();
		 	var menu_note=$("#upmenu_note").val();
		 	var menu_dsn=$("#upmenu_dsn").val();
		 	var oId=$("#Id").val();
		 	if(menu_name){
		 		$.post('modify.shtml',{id:oId,name:name,description:menu_note,sort:menu_dsn},function(datas){
							if(datas.status==true){
								var zTree = $.fn.zTree.getZTreeObj("orgtree");
								var vl=$.parseJSON(datas.data);
								var nodes = zTree.getNodeByParam("id",vl.id, null);
								nodes.name=vl.name;
								zTree.updateNode(nodes);;
								$("#upTreeform").hide();
								msg.info("修改成功");
							}else{
								msg.info("修改失败,请联系管理员");
							}
		 		},'json');
		 	}
	 	});
});

function createTree(){
	$.fn.zTree.init($("#orgtree"),setting);   
}
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
	};
  var setting = {
		 	async:{
				enable:true,
				url:'tree.shtml',
				autoParam:["id"]
			}, 
	   check: {
              enable: true,
              nocheckInherit: true
       },
       view: {
			addHoverDom: addHoverDom,
			removeHoverDom: removeHoverDom,
			selectedMulti: true
		},
		edit: {
			enable: true,
			editNameSelectAll: true,
			showRenameBtn: false
		},
		data: {
			simpleData: {
				datatype:'json',
				enable: true
			}
		},
		callback: {
			beforeRemove: beforeRemove,
			onClick:function(event,treeId,treeNode,clickFlag){
				$("#upTreeform").show();
				$("#Treeform").hide();
				$("#childTreeform").hide();
		 		$.post('jsonEdit.shtml',{id:treeNode.id},function(data){
					 	$("#Id").val(data.id);
					 	$("#upmenu_name").val(data.name);
					 	$("#upmenu_note").val(data.description);
					 	$("#upmenu_dsn").val(data.sort);
					},'json');
			},
			onAsyncError : zTreeOnAsyncError, 
		    onAsyncSuccess : function(event, treeId, treeNode, msg){ 
		    }
		}

 }; 
 function zTreeOnAsyncError(event, treeId, treeNode, XMLHttpRequest, textStatus, errorThrown){
	alert("加载错误："+XMLHttpRequest); 
 };
 function filter(treeId, parentNode, childNodes){
	 if(!childNodes)
		return null;
		for(var i = 0, l = childNodes.length; i < l; i++){
			 childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
		}
		return childNodes; 
 };
	function beforeRemove(treeId, treeNode) {

		var zTree = $.fn.zTree.getZTreeObj("orgtree");
		
		zTree.selectNode(treeNode);
		var $_result=false;
		 	$.ajax({
		 		async:false,
		 		dataType:'json',
		 		type:'post',
		 		data:{id:treeNode.id},
		 		url:'delete.shtml',
		 		success:function(datas){
					if(datas.status=='success'){
						$_result=true;
					}
		 		}
		 	});
		return $_result;
	}
	function delTree(treeId, treeNode){
		
		
	}
	var newCount = 1;
	function addHoverDom(treeId, treeNode) {
		var sObj = $("#" + treeNode.tId + "_span");
		if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
		var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
			+ "' title='add node' onfocus='this.blur();'></span>";
		sObj.after(addStr);
		var btn = $("#addBtn_"+treeNode.tId);
		if (btn) btn.bind("click", function(){
			$("#childTreeform").show();
			$("#Treeform").hide();
			$("#upTreeform").hide();
			parentNode=treeNode;
			return false;
		});
	};
	function removeHoverDom(treeId, treeNode) {
		$("#addBtn_"+treeNode.tId).unbind().remove();
	};
	function buttonOnClickAdd(){
		$("#Treeform").show();
		document.getElementById("Treeform").reset();
		$("#upTreeform").hide();
		$("#childTreeform").hide();
	}
</script>
</body>
</html>
