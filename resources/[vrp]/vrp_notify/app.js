$(document).ready(function(){
	window.addEventListener("message",function(event){
		var html = "<div id='"+event.data.css+"' class='animated'><div id='overlay'></div><span>"+event.data.mensagem+"</span></div>"
		$(html).appendTo("#notifications").hide().show().addClass('bounceInLeft').delay(event.data.time).queue(function(next) {
      		$( this ).removeClass('bounceInLeft').addClass('bounceOutLeft').delay(1000);
      		next();
    	}).delay(500).queue(function( next ) {
	        $( this ).fadeOut(3000).hide().empty();
	    })
	});
});