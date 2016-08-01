/*
 * 上传
 * author:zyou
 * 2016-03-23
 * 
 * 
 **/
var uploader;
var filePath='';
$.fn.my_upload = function(options){
	var upload_dom = this;
	filePath = $("#filePath").val();
	if($("#fileDiv").next(".queued-div").length<=0){
		$("#fileDiv").after("<div class=\"queued-div\"><div class=\"queued\"></div><ul class=\"upload-dis\"></ul></div>");
	}
	var defaults = {
		'trans':false, //是否通过trans来setname
		'name' : '', // 上传input的name
		'transProp':'', //trans的变量名
		'multi':false, //是否上传多个文件
		'url':filePath+'/file/upload.shtml'
	};
	var settings = $.extend({}, defaults, options);
	uploader = WebUploader.create({
	    swf: pathName+'/webUploader/js/Uploader.swf',
	    server: settings.url,
	    pick: {id:upload_dom},
	    formData: {
	    	userId: $('#userId').val(),
	    	parentId: $('#parentId').val(),
	    	moduleId:$('#moduleId').val()
        },
	    resize: false,
	    auto:true,
	    fileSingleSizeLimit:5*1024*1024
	});
	
	// 文件上传过程中创建进度条实时显示
	uploader.on( 'uploadProgress', function( file, percentage ) {
	    var $li = $("#fileDiv").next(".queued-div").find( '.progress_'+file.id ),
	    $percent = $li.find('.progress .progress-bar');
	    // 避免重复创建
	    if ($percent.length<=0) {
	        $percent = $('<div class="progress progress-striped active">' +
	          '<div class="progress-bar" role="progressbar" style="width: 0%">' +
	          '</div>' +
	        '</div>').appendTo( $li ).find('.progress-bar');
	    }

	    $percent.css( 'width', percentage * 100 + '%' );
	});
	
	// 当有文件被添加进队列的时候
	uploader.on( 'fileQueued', function( file ) {
		var $list = $("#fileDiv").next(".queued-div").find(".queued");
	    $list.append( "<div class=\"item progress_"+file.id+"\" style=\"float:left;margin-left:20px;\">" +
	        "<h4 class=\"info\">"+ file.name + "</h4><p class=\"state\">等待上传...</p><a href=\"javascript:;\" onclick=\"removes(this,'"+file.id+"')\" title='移除'><i class=\"icon-remove\"></i></a>"
	    +"</div>" );
	});
	uploader.on('error',function(type){
		 if(type=="F_EXCEED_SIZE"){
	            msg.info("文件大小不能超过5M");
	        }
	});
	uploader.on( 'uploadSuccess', function( file, ret ) {
		if("error"==ret.status){
			alert("上传失败，请重试！");
			return false;
		}
		var trans = settings.trans?'trans':'';
		if(settings.multi){
			// 添加已经上传的文件
			$("#fileDiv").next(".queued-div").find(".upload-dis").append("<li style=\"float:left;\"><i class=\"icon-tag\"></i>&nbsp;&nbsp;<a href=\""+filePath+"/file/download.shtml?id="+ret.id+"\" title=\"点击下载\">"+file.name+"</a>&nbsp;&nbsp;<a href=\"javascript:;\" class=\"upload-del\" onclick=\"delFile(this,"+ret.id+",'"+file.id+"')\" ><i class=\"icon-remove\"></i></a><input trans-param=\""+settings.transProp+"\" class=\""+trans+"\" type=\"hidden\" name=\""+settings.name+"\" value=\""+ret.id+"\" /></li>");
		}else{
			$("#fileDiv").next(".queued-div").find(".upload-dis").find("input[name=contractId]").each(function(){
				var id = $(this).val();
				$.ajax({
					async: false,
					type:"post",
					dataType:"json",
					data:{id:id},
					url:filePath+"/file/del.shtml",
					success:function(data){
					}
				});
			});
			$("#fileDiv").next(".queued-div").find(".upload-dis").html("<li style=\"float:left;\"><i class=\"icon-tag\"></i><a href=\""+filePath+"load/file/download.shtml?id="+ret.id+"\" title=\"点击下载\">"+file.name+"</a><a href=\"javascript:;\" class=\"upload-del\" onclick=\"delFile(this,"+ret.aId+",'"+file.id+"')\" ><i class=\"icon-remove\"></i></a><input trans-param=\""+settings.transProp+"\" class=\""+trans+"\" type=\"hidden\" name=\""+settings.name+"\" value=\""+ret.aId+"\" /></li>");
		}
		// 添加序号
		$("#fileDiv").next(".queued-div").find(".upload-dis").find("input[name=contractId]").each(function(index){
			var $input = $(this);
			if(settings.trans){
				$input.attr("trans-param",settings.transProp+"["+index+"]");
			}else{
				$input.attr("name",settings.name);
			}
		});
	});

	uploader.on( 'uploadError', function( file ) {
	    $("#fileDiv").next(".queued-div").find(".queued").find(".progress_"+file.id).find('p.state').text('上传出错');
	});

	uploader.on( 'uploadComplete', function( file ) {
		$("#fileDiv").next(".queued-div").find(".queued").find(".progress_"+file.id).fadeOut();
	});
	$btn = $('#ctlBtn');
	state = 'pending';
	uploader.on( 'all', function( type ) {
	        if ( type === 'startUpload' ) {
	            state = 'uploading';
	        } else if ( type === 'stopUpload' ) {
	            state = 'paused';
	        } else if ( type === 'uploadFinished' ) {
	            state = 'done';
	        }
	     /*   if ( state === 'uploading' ) {
	            $btn.text('暂停上传');
	        } else {
	            $btn.text('开始上传');
	        }*/
	    });

	$btn.on( 'click', function() {
	    if ( state === 'uploading' ) {
	        uploader.stop();
	    } else {
	        uploader.upload();
	    }
	});
	
	
}

function readOnlyAttachment(selector){
	$(selector).find(".upload_btn").remove();
	$(selector).find(".queued-div").addClass("queued-inline");
	$(selector).find(".queued-div").find(".upload-del").remove();
}

function delFile(obj,id,fileId){
	$.ajax({
		type:"post",
		dataType:"json",
		data:{id:id},
		url:filePath+"/file/del.shtml",
		success:function(data){
			$(obj).parents('.queued-div').find(".queued").find(".progress_"+fileId).remove();
			$(obj).parent().remove();
			uploader.removeFile(uploader.getFile(fileId));
		}
	});
}
function removes(obj,fileId){
	$(obj).parents('.queued-div').find(".queued").find(".progress_"+fileId).remove();
	$(obj).parent().remove();
	uploader.removeFile(uploader.getFile(fileId));
}
