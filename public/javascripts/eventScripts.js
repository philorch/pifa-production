// JavaScript Document

$(document).ready(init);

function init() {
	
		//Click Times & TIckets
		$("div.times-tickets").click(function() {
			if(  showTimesShowing( $(this) )  ) {
				slideIn( $(this) );
				hideShowtimes( $(this) );
			} else {
				slideOut( $(this) );
				showShowtimes( $(this) );
			}
		});
		
		
		//Click 'X' Button
		$("div.close-button").click(function() {
			var timesAndTickets = $(this).parent().parent().find("div.times-tickets");
			slideIn(timesAndTickets);
			hideShowtimes( $(this).parent() );
		});
		
		
		//Mouse Over
		$("div.times-tickets").mouseover(function() {
			if(  !showTimesShowing( $(this) )  ) 
				slideOut( $(this) );
		});
		
		//Mouse Out
		$("div.times-tickets").mouseout(function() {
			if( !showTimesShowing($(this)) )
				slideIn( $(this) )
		});
		
}

function showShowtimes(timesAndTickets) {
	var showtimes = timesAndTickets.parent().find("div.showtimes");
	var slimscroll = showtimes.find("div.slimScrollDiv");
	slimscroll.css('width', 'auto');
	showtimes.stop();
	showtimes.animate({width: '221px', paddingLeft: '16px', paddingRight: '6px' }, {duration:500});
}

function hideShowtimes(timesAndTickets) {
	var showtimes = timesAndTickets.parent().find("div.showtimes");
	var slimscroll = showtimes.find("div.slimScrollDiv");
	showtimes.stop();
	showtimes.animate({
		width: '0px',
		paddingLeft: '0px',
		paddingRight: '0px'
	}, 500, function(){
		slimscroll.css('width', '0px');
	});
}

function slideOut(timesAndTickets) {
	var arrow = timesAndTickets.parent().find("img");
	timesAndTickets.stop();
	arrow.stop();
	timesAndTickets.animate({paddingLeft: "8px", width: "202px"}, {duration:450});
	arrow.animate({width: "15px"}, {duration:150});	
}

function slideIn(timesAndTickets) {
	var arrow = timesAndTickets.parent().find("img");
	timesAndTickets.stop();
	arrow.stop();
	timesAndTickets.animate({paddingLeft: "16px", width: "194px"}, {duration:350});
	arrow.animate({width: "0px"}, {duration:150});	
}

function showTimesShowing(timesAndTickets) {
	var showtimes = $(timesAndTickets).parent().find("div.showtimes");
	var showtimesWidth = showtimes.css("width");
	return Boolean(showtimesWidth != "0px")
}
/*
function spaceEventTags() { 
	var maxTags = 6; //Assumes a default of 6 tags and if there are less it adds padding.
	var tagHeight = 22;
	
	var eventModules = document.getElementsByClassName("event-container");
	for(var i in eventModules) {
		var module = eventModules[i];
		try{
			var tagHolders = module.getElementsByClassName("event-tags");
			var allTags = tagHolders[0].getElementsByTagName("span");
			var totalTags = allTags.length;
			if(totalTags > 0) {
				var spacing = (maxTags-totalTags)*tagHeight;
				allTags[0].style.marginTop = String(spacing + "px");
			}
		} catch(exception){
			//alert(exception);
		}
		
	}
}*/
