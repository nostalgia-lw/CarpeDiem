jQuery(document).ready(function() {
//全选的实现
	$(".check-all").click(function(){
		$(".ids").prop("checked", this.checked);
	});
	$(".ids").click(function(){
		var option = $(".ids");
		option.each(function(i){
			if(!this.checked){
				$(".check-all").prop("checked", false);
				return false;
			}else{
				$(".check-all").prop("checked", true);
			}
		});
	});
	
	//高级搜索
	$("#advanced-search-btn").click(function(){
		$('.chosen-container').css("width","153px");
		if(!$(".advanced-search").is(":animated")){ 
			$(".advanced-search").slideToggle();
		}
	});

   //ajax get请求
   $('.ajax-get').click(function(){
       var target = ($(this).attr('href')) || (target = $(this).attr('url'));
       var info =$(this).attr('data-info');
       msg.confirm(info,function(){
	       if (target) {
	    	   $.ajax({
	   			type : "GET",
	   			url : target,
	   			dataType : 'json',
	   			success:function(data) {
		             if (data.status==1) {
		            	 msg.info(data.info);
						setTimeout(function(){
							if (data.url) {
								location.href=data.url;
							}else{
								location.reload();
							}
						},1000);
		             }else{
		            	 msg.info(data.info);
		             }
	   			}
	   		});
	       }
       },"操作提示");
       return false;
   });
   //员工信息弹出框
   $('.show-user-info').bind("click",function(){
	   var id=$(this).attr('data-id');
	   showUserInfo(id);
   });
   
});
function showUserInfo(id){
	model.info("员工信息",pathName+"/user/ajax_user_info.shtml?id="+id); 
}