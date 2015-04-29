$(document).ready(function() {

	$('#pics').click(function(e){
	  var section = "about"
	  if ($(this).data("type") != "undefined") {
	  	section = $(this).data("type");
	  }
	  $.colorbox({href:"/"+section+"/pics", close:"<p></p>"});
	  return false;
	});

	$('#promo-border').live('click', function() {
		window.location = $(this).attr('data-link');
	});

	$('#promo-sliding-container').cycle({
		after: onSliderAfter,
  	    fx:     'scrollLeft',
  	    timeout: 9000,
  	    pager:  '#promo-button-container'
  	});


  	$('div.scroll-container').slimScroll({
        height: '160px',
        disableFadeOut: true,
        distance: '0px'
    });

  	//for ie7
    $("div.event-container div.showtimes div.slimScrollDiv").css('width', '0px');

});

function onSliderAfter(currSlideElement, nextSlideElement, options, forwardFlag) {
	href = $(nextSlideElement).find('a').attr('href');
	$('#promo-border').attr('data-link', href);
}