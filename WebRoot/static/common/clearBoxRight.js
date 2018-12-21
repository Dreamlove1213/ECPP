$(document).click(function(event){
	var _con=$("#aside",parent.document);
	var _con1=$("#container",parent.document);
	        var _con = $('#aside');  // 设置目标区域
	        if(!_con.is(event.target) && _con.has(event.target).length === 0){ // Mark 1
	           $(_con1).removeClass('aside-in')     //淡出消失
	        }else{$(_con1).addClass('aside-in') }
	   });