jQuery(document).ready(
		function() {
			// 选择流程处理人员
			$('.assignOrderFzr').click(function() {
				var id = $(this).attr('data-id');
				$.post(pathName + '/ob/allot_page.shtml', {id : id}, function(html) {
					dialog({
						id : "manager",
						fixed : true,
						padding : 10,
						title : '选择流程处理人员',
						content : html,
						width : 450
					}).showModal();
				});
			});
			// 流程下一步-选择处理人
			$('.pendingPage').click(function() {
				var id = $(this).attr('data-id');
				$.post(pathName + '/ob/pending_page.shtml', {
					id : id
				}, function(html) {
					dialog({
						id : "manager",
						fixed : true,
						padding : 10,
						title : '流程处理',
						content : html,
						width : 500,
						height : 300
					}).showModal();
				});
			});
			// 退回-选择退回处理人
			$('.processBack').click(function() {
				var id = $(this).attr('data-id');
					$.post(pathName + '/ob/back_page.shtml', {
						id : id
					}, function(html) {
						dialog({
							id : "manager",
							fixed : true,
							padding : 10,
							title : '退回-选择退回处理人',
							content : html,
							width : 450,
							height : 280
						}).showModal();
					});
			});
			// 退回-选择退回处理人
			$('.paymentPage')
					.click(
							function() {
								var orderId = $(this).attr('data-id');
								window.parent.updateTab('核款申请', pathName
										+ '/payment/payment_apply.shtml?id='
										+ orderId);
							});

			// 退回
			$('.goBack').click(function() {
				var Id = $(this).attr('data-id');
				var nodeName = $(this).attr('data-nodeName');
				var status = $(this).attr('data-status');
				msg.confirm('确定退回吗？', function() {
					$.post(pathName + '/ob/goBack.shtml', {
						Id : Id,
						nodeName : nodeName,
						status : status
					}, function(result) {
						msg.info(result.info);
						setTimeout("fn_reaload()", 1000);
					}, 'json');
				}, '消息提示');
			});
			
});

//刷新本页面
function fn_reaload() {
	location.reload();
};

// 流程记录
function processRecord(Id) {
	$.post(pathName + '/ob/process_record.shtml', {
		Id : Id
	}, function(html) {
		dialog({
			id : "manager",
			fixed : true,
			padding : 10,
			title : '流程记录',
			content : html,
			width : 500,
			height : 400
		}).showModal();
	});
}
// 子订单详情
function orderBusinessInfo(id) {
	window.parent.updateTab('子订单详情', pathName + '/ob/order_details.shtml?id='+ id);
}

//费用申请
function expenses(id){
	window.parent.updateTab('费用申请', pathName + '/expenses/application.shtml?ObId='+ id);
}

//备注弹出框
function orderRecord(orderId,obId){
	   var url=pathName+"/record/ajax_new_record_page.shtml?orderId="+orderId+"&obId="+obId;
	 	$.ajax({
		type:"get",
		url:url,
		dataType:"html",
		success:function(html){
			var d = dialog({
				fixed: true,
				title :"备注",
				content : html,
				width:300,
				okValue: '提交备注',
			    ok: function(){
			    	var checkContent = checkEmpty($('[name="content"]'),'请填写备注内容');
					if(checkContent){
						msg.confirm("请确认操作",function(){
							var param;
	    					$.ajax({
	    						type : "POST",
	    						data : $("#remark-form").serialize(),
	    						url : $("#remark-form").attr("action"),
	    						dataType : 'json',
	    						success:function(data) {
	    							if(data.status==1){
	    								$("#remark-form")[0].reset();
	    								msg.info(data.info);
	    								d.close().remove();
	    							}else{
	    								msg.info(data.info);
	    							}
	    						}
	    					});
	    				},"确认操作？");
					}
					return false;
			    },
			    cancelValue: '取消',
			    cancel: function () {}
			}).showModal();
		}
	});
}
//验证信息
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

//验证信息字符是否大于num位
function checkEmptyLength(obj,num,msg){
	var check = false;
	var val = obj.val();
	if(val.length>num){
		obj.err(msg);
	}else{
		check = true;
		obj.closeErr();
	}
	return check;
}

//计算小计以及合同金额
function calcContractMoney(calc,len) {
	var unitPriceInput = $(calc);
	unitPriceInput.val(unitPriceInput.val().replace(/[^\d.]/g, "")); // 清除“数字”和“.”以外的字符
	unitPriceInput.val(unitPriceInput.val().replace(/^\./g, ""));// 验证第一个字符是数字而不是.
	unitPriceInput.val(unitPriceInput.val().replace(/\.{2,}/g, "."));// 只保留第一个.
	unitPriceInput.val(unitPriceInput.val().replace(/^0{2,}/g, "0"));//开始不能连续输入两个0
	unitPriceInput.val(unitPriceInput.val().replace(".", "$#$").replace(/\./g,"").replace("$#$", "."));
	unitPriceInput.val(unitPriceInput.val().replace(/^(\-)*(\d+)\.(\d\d).*$/,'$1$2.$3'));// 只能输入两个小数
	var unitPrice = parseInt(unitPriceInput.val()||0);
	if(unitPrice.toString().length > len){
		unitPrice = unitPrice.toString().substring(0,11);
		unitPriceInput.val(unitPriceInput.val().replace(/^\d{12,}/g,unitPrice));
	}

	var value = calc.value;
	if('' != calc.value.replace(/\d{1,}\.{0,1}\d{0,}/,'')){
		calc.value = calc.value.match(/\d{1,}\.{0,1}\d{0,}/) == null ? '' :calc.value.match(/\d{1,}\.{0,1}\d{0,}/);
	}
	for(var i=0;;i++){
		if(/^0/.test(value) && !/^0\./.test(value) && value.length >=2){
			value= value.substring(1,value.length);
		}else {
			calc.value = value;
			break;
		}
	}
}
/*派发工单*/
function distributedOredr(Id){
	window.parent.addTab('派发工单', pathName+'/work_order/access_save.shtml?orderId='+Id);
};
