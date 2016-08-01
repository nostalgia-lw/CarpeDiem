// 加载业态数据
function initData(btName,pageNo){
	$.post(pathName+'/reservation/business_type_data.shtml',{btName:btName,pageNo:pageNo},function(result){
		var str = "";
		var datas = result.items;
		if(datas != ""){
			$.each(datas,function(i,bt){
				if(bt.parentId == 0){
					str += '<tr><td><input type="checkbox" class="btIds" value="'+bt.id+'" parent="parent"></td>'
						+ '<td> <a href="javascript:;" onclick="btParent(this,'+bt.id+');" class="btName"><i class="'+(btName == ''?'icon-plus"':'icon-minus')+'" ></i>'+bt.name+'</a></td>';
					str += '<td class="btOrgan"></td>';
					str += '<td class="btPrice"></td></tr>';
					if(bt.btList != ""){
						$.each(bt.btList,function(n,bt2){
							str += '<tr class="children'+bt.id+'"'+(btName == ''?'style="display: none;"':'')+'>'
								+'<td><input type="checkbox" class="id" value="'+bt2.id+'"></td>'
								+'<td class="btName">&nbsp;&nbsp;&nbsp;&nbsp;'+bt2.name+'</td>';
							str += '<td class="btOrgan">';
							$.each(bt2.organList,function(j,organ){
								str += organ.name +"&nbsp;";
							});
							str += '</td>';
							str += '<td class="btPrice">'+bt2.price+'</td></tr>';
						});
					}
				}
			});
			// 分页
			var count = result.rowsCount;// 总记录数
			var index = result.curIndex;// 当前页
			var total = result.pagesCount;// 总页数
			str += '<tr class="tr-border"><td colspan="5"><div class="pagger">&nbsp;共<strong>'+count+'</strong>项,第<strong>'+index+'/'+total+'</strong>页&nbsp;';
			// 上一页处理
            if (index == 1) {
                str += "<span class=\"disabled\">&lt;</span>";
            } else {
            	str += "<a href=\"javascript:pageTo("+(Number(index) - 1)+")\">&lt;</a>";
            }
			// 如果前面页数过多,显示"..."
            var start = 1;
            if (index > 4) {
                start = index - 2;
                str += "<a href=\"javascript:pageTo(1)\">1</a>";
				str += "&hellip;";
            }
            // 显示当前页附近的页
            var end = index + 2;
            if (end > total) {
                end = total;
            }
            for (var i = start; i <= end; i++) {
                if (index == i) { // 当前页号不需要超链接
                    str += "<span class=\"current\">"+i+"</span>";
                } else {
                	str += "<a href=\"javascript:pageTo("+i+")\">"+i+"</a>";
                }
            }
            // 如果后面页数过多,显示"..."
            if (end < Number(total) - 1) {
                str += "&hellip;";
            }
            if (end < total) {
            	str += "<a href=\"javascript:pageTo("+total+")\">"+total+"</a>";
            }
            // 下一页处理
            if (index == total) {
                str += "<span class=\"disabled\">&gt;</span>";
            } else {
            	str += "<a href=\"javascript:pageTo("+(Number(index) + 1)+")\">&gt;</a>";
            }
			str +='</div></td></tr>';
		}else{
			str += '<tr><td colspan="5" align="center">未查询到数据</td></tr>';
		}
		$('.btTable tbody').empty().append(str);
	},'json');
}
// 分页
function pageTo(pageNo){
	var btName = $('[name=btName]').val();
	initData(btName,pageNo);
}

//查看子级业态信息
function btParent(obj,id){
	var cla = $(obj).children("i").attr("class");
	if(cla == 'icon-plus'){
		$.post(pathName+'/reservation/business_type_data_children.shtml',{parentId:id},function(result){
			var str = "";
			$.each(result,function(n,bt2){
					str += '<tr class="children'+id+'">';
					str +='<td><input type="checkbox" class="id" value="'+bt2.id+'"></td>';
					str +='<td class="btName">&nbsp;&nbsp;&nbsp;&nbsp;'+bt2.name+'</td>';
					str += '<td class="btOrgan">';
						$.each(bt2.organList,function(j,organ){
							str += organ.name +"&nbsp;";
						});
					str += '</td>';
					str += '<td class="btPrice">'+bt2.price+'</td></tr>';
					$('.children'+id).remove();
			});
			$(obj).parent().parent().after(str);
		},'json');
		$(obj).children("i").removeClass("icon-plus").addClass("icon-minus");
	}else{
		$(obj).children("i").removeClass("icon-minus").addClass("icon-plus");
		$('.children'+id).hide();
	}
}
// 点击复选框查询子级业态信息
function btParentBox(obj,id){
	var cla = $(obj).parent().parent().children().find("i").attr("class");
	if(cla == 'icon-plus'){
		$.post(pathName+'/reservation/business_type_data_children.shtml',{parentId:id},function(result){
			var str = "";
			$.each(result,function(n,bt2){
					str += '<tr class="children'+id+'">';
					str +='<td><input type="checkbox" class="id" checked value="'+bt2.id+'"></td>';
					str +='<td class="btName">&nbsp;&nbsp;&nbsp;&nbsp;'+bt2.name+'</td>';
					str += '<td class="btOrgan">';
						$.each(bt2.organList,function(j,organ){
							str += organ.name +"&nbsp;";
						});
					str += '</td>';
					str += '<td class="btPrice">'+bt2.price+'</td></tr>';
					$('.children'+id).remove();
					// 判断选择的业态是否已经插入Table
					if(!$('#buyTable>tbody>tr').hasClass(("buyTr"+bt2.id))){
						var html = '<tr class="buyTr'+bt2.id+'"><td>'+bt2.name+'</td>';
							html +='<td>';
								$.each(bt2.organList,function(j,organ){
									html += organ.name +"&nbsp;";
								});
							html+='</td><td>'+bt2.price+'</td>'
								+'<td><select class="form-control input-sm" name="cycle" onchange="selectTotal(this)">'
								+'<option value="1">一周</option>'
								+'<option value="2">二周</option>'
								+'<option value="3">三周</option>'
								+'<option value="4">四周</option>'
								+'</select></td>'
								+'<td><input type="hidden" name="btId" value="'+bt2.id+'" />'
								+'<input type="hidden" class="btPrice" value="'+bt2.price+'" />'
								+'<input type="number" name="amount" class="form-control input-sm" onchange="total(this)" onkeyup="total(this)" min="1" max="9999" /></td>'
								+'<td><input type="hidden" name="totalPrice" /><span class="totalPrice">0</span></td>'
								+'<td><a href="javascript:;" onclick="delTr(this)"><i class="icon-trash color-red" title="删除" style="font-size: 18px;"></i></a></td>'
							+'</tr>';
						$('#buyTable').find("tbody").append(html);
					}
			});
			$(obj).parent().parent().after(str);
		},'json');
		$(obj).children("i").removeClass("icon-plus").addClass("icon-minus");
	}
}