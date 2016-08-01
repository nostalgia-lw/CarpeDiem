document.write('<script type="text/javascript" src="artDialog/src/dialog-config.js"></script>');
document.write('<script type="text/javascript" src="artDialog/src/popup.js"></script>');
document.write('<script type="text/javascript" src="artDialog/src/dialog.js"></script>');
document.write('<script type="text/javascript" src="artDialog/src/dialog-plus.js"></script>');
document.write('<script type="text/javascript" src="artDialog/src/drag.js"></script>');

/**
 * 公共提示信息接口
 * alert:没按钮的提示框
 * confirm:带按钮的提示框
 * info:没有标题和按钮的提示框，2秒自动关闭
 */
var msg = {
    alert: function (content, title) {
        var element = $('[i="dialog"]');
        if (element.length <= 0) {
            dialog({
                fixed: true,
                title: title != null && title != "" ? title : '提示信息',
                content: content,
                width: 200
            }).show();
        }
    },
    confirm: function (content, callback, title, cancelCallback) {
        dialog({
            fixed: true,
            title: title != null && title != "" ? title : '提示信息',
            content: content,
            width: 250,
            okValue: '确定',
            ok: callback,
            cancelValue: '取消',
            cancel: function () {
                if (cancelCallback && (typeof cancelCallback == "function")) {
                    cancelCallback();
                }
            }
        }).showModal();
    },
    info: function (content, timeout) {
        var d = dialog({
            width: 200,
            title: '提示信息',
            content: "<span style='color:red;'>" + content + "<span>"
        });
        d.show();
        setTimeout(function () {
            d.close().remove();
        }, timeout ? timeout : 2000);
    },
    sucs: function (content) {
        var d = dialog({
            title: '成功',
            content: "<span style='color:red;'>" + content + "<span>",
            width: 200,
            okValue: '确定',
            cancel: false,
            ok: function () {
                window.location.reload();
            }
        });
        d.show();
    },
    dialog: function (content, callback1, callback2, title) {
        dialog({
            fixed: true,
            title: title != null && title != "" ? title : '提示信息',
            content: content,
            width: 250,
            button: [
                {
                    value: '同意',
                    callback: callback1,
                    autofocus: true
                },
                {
                    value: '不同意',
                    callback: callback2
                }
            ]
        }).showModal();
    }
};


var model = {
    info: function (title, url) {
        $.ajax({
            type: "get",
            url: url,
            dataType: "html",
            success: function (html) {
                dialog({
                    fixed: true,
                    quickClose: true,
                    title: title != null && title != "" ? title : '信息弹出框',
                    content: html
                }).show();
            }
        });
    }
};

/*function tip(obj,content,align){
 var d = dialog({
 padding : 0,
 align: align != null && align != "" ? align : 'top',
 content: content,
 quickClose: true
 });
 d.show(obj);
 };*/

/**
 * 提示错误信息
 */
$.fn.err = function (title) {
    $(this).parent('div').addClass('has-error');
    $(this).tooltip({
        template: '<div class="tooltip" role="tooltip"><div class="tooltip-arrow" style="border-top-color:#d9534f"></div><div class="tooltip-inner" style="background-color:#d9534f"></div></div>',
        title: title, trigger: 'manual'
    }).tooltip('show');
    $(this).focus(function () {
        $(this).parent('div').removeClass('has-error');
        $(this).tooltip('destroy');
    });
};

/**
 * 关闭错误信息
 */
$.fn.closeErr = function () {
    $(this).parent('div').removeClass('has-error');
    $(this).tooltip('destroy');
};