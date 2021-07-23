
$(document).ready(function(){
	window.addEventListener("message",function(event){		
		var html = "<div id="+event.data.css+"><div class='content'><div class='text'>"+event.data.mensagem+"</div></div></div>"
		$(html).appendTo("#notifications").hide().fadeIn(1000).delay(event.data.time).fadeOut(1000);
		
	})
});