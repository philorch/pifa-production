// JavaScript Document

	var timesTicketsLink;
	var downArrow;
	var datesBlock;
	var addDates;
	var showtimes;
	var closeShowtimesButton;
	
	var currentIndex;
	var showtimesVisible;
	var hideTimerId;
	
	$(document).ready(init);
	
	function init() {

		timesTicketsLink = $("#times-tickets");
		downArrow = $("#down-arrow");
		datesBlock = $("#ticket-dates");
		addDates = $("#dates-container a.date");
		showtimes = $(".showtimes");
		closeShowtimesButton = $(".close-button");

		setSizesPositions();

		showtimesVisible = false;
		timesTicketsLink.mouseover(showDownArrow);
		timesTicketsLink.mouseout(hideDownArrow);
		
		datesBlock.mouseover(killFadeOutTimer);
		datesBlock.mouseout(startFadeOutTimer);
		
		showtimes.mouseover(killFadeOutTimer);
		showtimes.mouseout(startFadeOutTimer);
		
		closeShowtimesButton.click(function(e){
			e.preventDefault();
			es_hideShowtimes();
		});
		
		addDates.click(function(e){
			e.preventDefault();
			handleDateClick($(this));
		});
		
		timesTicketsLink.click(function(e){
			e.preventDefault();
			showDates();
		});
	}

	function setSizesPositions() {
		if (addDates.size() < 7) {
			block_width = 53*addDates.size()+1;
			if (block_width < 185) { block_width = 185; }
			datesBlock.width(block_width);
		}
		showtimes.css("top", datesBlock.height()+30+"px");
	}
	
	function handleDateClick(dateClicked) {
		var dateIndex = addDates.index(dateClicked);
		// console.log(dateIndex);
		if(showtimesVisible) {
			es_hideShowtimes();
			window.setTimeout(function() { es_showShowtime(dateIndex); }, 450)
		} else {
			es_showShowtime(dateIndex);
		}
	}
	
	function startFadeOutTimer() {
		hideTimerId = window.setTimeout(hideDatesAndShowtimes, 5000);
	}
	
	function killFadeOutTimer() {
		if(hideTimerId) window.clearTimeout(hideTimerId);
		hideTimerId = 0;
	}
	
	function hideDatesAndShowtimes() {
		killFadeOutTimer();
		es_hideShowtimes();	
		hideDates(300);
	}
	
	function es_showShowtime(showtimeIndex) {
		//showtimeIndex+=2;
		//console.log(showtimeIndex);
		currentIndex = showtimeIndex;
		var showtime = $(".showtimes").eq(currentIndex);
		var showtimeHeight = showtime.height();
		showtime.css("height", "0px");
		showtime.css("display", "block");
		showtime.animate({height:showtimeHeight}, {duration:300, complete: function() {
			showtimesVisible = true;	
		}});
	}
	
	function es_hideShowtimes() {
		var showtime = $(".showtimes").eq(currentIndex);
		var showtimeHeight = showtime.height();
		showtime.animate({height:0}, {duration:300, complete: function() {
			showtime.css("display", "none");
			showtime.css("height", String(showtimeHeight + "px"));
			showtimesVisible = false;
		}});
	}
	
	function showDates() {
		killFadeOutTimer();
		datesBlock.stop();
		datesBlock.fadeIn(300);
	}
	
	function hideDates(delay) {
		datesBlock.stop();
		datesBlock.delay(delay).fadeOut(300, function() {
			hideDownArrow();	
		});	
	}
	
	function showDownArrow() {
		downArrow.stop();
		downArrow.css("width", "28px");
		downArrow.animate({height:"15px"}, {duration:300});
	}
	
	function hideDownArrow() {
		downArrow.stop();
		if(!datesAreVisible())downArrow.animate({height:"0px"}, {duration:300});
	}
	
	function datesAreVisible() {
		return Boolean(datesBlock.css("display") != "none");
	}
	
	function showTimesAreVisible() {
		return showtimes.height();//Boolean( > 0);
	}
	
	