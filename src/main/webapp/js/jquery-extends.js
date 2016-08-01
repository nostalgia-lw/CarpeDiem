/**
 * 将form表单内的数据转换JSON对象
 */
$.fn.serializeObject = function() {
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name]) {
            if (!o[this.name].push) {
                o[this.name] = [ o[this.name] ];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};
/**
 * 将JSON数据填充至该form表单，表单的name与json的key保持高度一致
 */
$.fn.reverseSerialize = function(sourceDatas){
	//取出form中的各个表单元素，无法获取并填充hidden以及display:none的元素.
	this.children().find("input,select,textarea").each(function(){
		//如果没有值，不做处理
		if(sourceDatas[this.name] == null || sourceDatas[this.name] == undefined){
		}else{
			this.value = sourceDatas[this.name];
			//如果为textarea则通过html赋值
			if(this.tagName == "textarea"){
				this.innerHTML = sourceDatas[this.name];
			}
		}
	});
};

/**
 * 封装的异步上传方法
 */
jQuery
.extend({
	createUploadIframe : function(id, uri) {
		// create frame
		var frameId = 'jUploadFrame' + id;

		if (window.ActiveXObject) {
			var io =document.createElement("iframe");
			 io.id=frameId;
			 io.name=frameId;
			if (typeof uri == 'boolean') {
				io.src = 'javascript:false';
			} else if (typeof uri == 'string') {
				io.src = uri;
			}
		} else {
			var io = document.createElement('iframe');
			io.id = frameId;
			io.name = frameId;
		}
		io.style.position = 'absolute';
		io.style.top = '-1000px';
		io.style.left = '-1000px';

		document.body.appendChild(io);

		return io;
	},
	createUploadForm : function(id, fileElementId, data) {
		// create form
		var formId = 'jUploadForm' + id;
		var fileId = 'jUploadFile' + id;
		var form = jQuery('<form  action="" method="POST" name="'
				+ formId + '" id="' + formId
				+ '" enctype="multipart/form-data"></form>');
		if (data) {
			for ( var i in data) {
				jQuery(
						'<input type="hidden" name="' + i + '" value="'
								+ data[i] + '" />').appendTo(form);
			}
		}
		for ( var i = 0; i < fileElementId.length; i++) {
			var oldElement = jQuery('#' + fileElementId[i]);
			var newElement = jQuery(oldElement).clone();
			jQuery(oldElement).attr('id', fileElementId[i]);
			jQuery(oldElement).attr('name', fileElementId[i]);
			jQuery(oldElement).before(newElement);
			jQuery(oldElement).appendTo(form);
		}
		// set attributes
		jQuery(form).css('position', 'absolute');
		jQuery(form).css('top', '-1200px');
		jQuery(form).css('left', '-1200px');
		jQuery(form).appendTo('body');
		return form;
	},

	ajaxFileUpload : function(s) {
		s = jQuery.extend({}, jQuery.ajaxSettings, s);
		var id = s.fileElementId[0];
		var form = jQuery.createUploadForm(id, s.fileElementId,s.data);
		var io = jQuery.createUploadIframe(id, s.secureuri);
		var frameId = 'jUploadFrame' + id;
		var formId = 'jUploadForm' + id;

		if (s.global && !jQuery.active++) {
			// Watch for a new set of requests
			jQuery.event.trigger("ajaxStart");
		}
		var requestDone = false;
		// Create the request object
		var xml = {};
		if (s.global) {
			jQuery.event.trigger("ajaxSend", [ xml, s ]);
		}

		var uploadCallback = function(isTimeout) {
			// Wait for a response to come back
			var io = document.getElementById(frameId);
			try {
				if (io.contentWindow) {
					xml.responseText = io.contentWindow.document.body ? io.contentWindow.document.body.innerHTML
							: null;
					xml.responseXML = io.contentWindow.document.XMLDocument ? io.contentWindow.document.XMLDocument
							: io.contentWindow.document;

				} else if (io.contentDocument) {
					xml.responseText = io.contentDocument.document.body ? io.contentDocument.document.body.innerHTML
							: null;
					xml.responseXML = io.contentDocument.document.XMLDocument ? io.contentDocument.document.XMLDocument
							: io.contentDocument.document;
				}
			} catch (e) {
				jQuery.handleError(s, xml, null, e);
			}
			if (xml || isTimeout == "timeout") {
				requestDone = true;
				var status;
				try {
					status = isTimeout != "timeout" ? "success"
							: "error";
					// Make sure that the request was successful or
					// notmodified
					if (status != "error") {
						// process the data (runs the xml through
						// httpData regardless of callback)
						var data = jQuery.uploadHttpData(xml,
								s.dataType);
						if (s.success) {
							// ifa local callback was specified, fire it
							// and pass it the data
							s.success(data, status);
						}
						;
						if (s.global) {
							// Fire the global callback
							jQuery.event.trigger("ajaxSuccess", [ xml,
									s ]);
						}
						;
					} else {
						jQuery.handleError(s, xml, status);
					}

				} catch (e) {
					status = "error";
					// jQuery.handleError(s, xml, status, e);
				}
				;
				if (s.global) {
					// The request was completed
					jQuery.event.trigger("ajaxComplete", [ xml, s ]);
				}
				;

				// Handle the global AJAX counter
				if (s.global && !--jQuery.active) {
					jQuery.event.trigger("ajaxStop");
				}
				;
				if (s.complete) {
					s.complete(xml, status);
				}
				;

				jQuery(io).unbind();

				setTimeout(function() {
					try {
						jQuery(io).remove();
						jQuery(form).remove();

					} catch (e) {
						jQuery.handleError(s, xml, null, e);
					}

				}, 100);

				xml = null;

			}
			;
		}
		// Timeout checker
		if (s.timeout > 0) {
			setTimeout(function() {

				if (!requestDone) {
					// Check to see ifthe request is still happening
					uploadCallback("timeout");
				}

			}, s.timeout);
		}
		try {
			var form = jQuery('#' + formId);
			jQuery(form).attr('action', s.url);
			jQuery(form).attr('method', 'POST');
			jQuery(form).attr('target', frameId);
			if (form.encoding) {
				form.encoding = 'multipart/form-data';
			} else {
				form.enctype = 'multipart/form-data';
			}
			jQuery(form).submit();

		} catch (e) {
			jQuery.handleError(s, xml, null, e);
		}
		if (window.attachEvent) {
			document.getElementById(frameId).attachEvent('onload',
					uploadCallback);
		} else {
			document.getElementById(frameId).addEventListener('load',
					uploadCallback, false);
		}
		return {
			abort : function() {
			}
		};

	},

	uploadHttpData : function(r, type) {
		var data = !type;
		data = type == "xml" || data ? r.responseXML : r.responseText;
		// ifthe type is "script", eval it in global context
		if (type == "script") {
			jQuery.globalEval(data);
		}

		// Get the JavaScript object, ifJSON is used.
		if (type == "json") {
			//由于文件上传返回json的时候，会出现json串自动加上pre标签，导致转换JSON出错，默认去除PRE标签。
			if($(data)[0].tagName == "PRE"){
				data = $(data).html();
			}
			eval("data = " + data);
		}

		// evaluate scripts within html
		if (type == "html") {
			jQuery("<div>").html(data).evalScripts();
		}

		return data;
	}
});

(function($){
	/**
	 * 用json对象填充表单
	 * jsonObject json对像
	 * 调用方式$("form").deSerialize({name:'dongqihong',sex:"男"});
	 */
	$.fn.deSerialize = function(jsonObject){
		var thisForm = $(this);
		$.each(jsonObject,function(name,value) {
			thisForm.find('[name="'+name+'"]').val(value);
	    });
	};
})(jQuery);

(function($){
	/**
	 * 填充select。可选参数说明:
	 * jsonUrl json数据地址
	 * 调用方式$("select.classname").fillData({jsonUrl:'types.do'});
	 */
	$.fn.fillData = function(options){
		var defaults = {jsonUrl:""};
		var options = $.extend(defaults,options);
		var thisSelect = $(this);
		$.getJSON(options.jsonUrl, function(json){
			thisSelect.each(function() {
				$(this).empty();
				for(var i=0;i<json.length;i++){
					$(this).append("<option value='"+json[i].id+"'>"+json[i].name+"</option>");
				}
			});
		});
	};
})(jQuery);


/**
 * 文件下载，只需要配置文件路径和下载后的名称即可
 * filePath : 文件路径，如 /export/user.xls
 * fileName : 文件名称，如 用户资料表.xls
 */
$.extend({download:function(filePath,fileName){
	 window.open("../download.do?filePath="+encodeURI(filePath)+"&fileName="+encodeURI(fileName));
}});

