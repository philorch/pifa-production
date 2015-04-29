// JavaScript Document
var countdownDuration = 1000; //millis
var searchLink;
var searchPopup;
var eventsLink;
var eventsPopup;
var dateDivs;
var eventsTimerId;
var searchTimerId;
var searchInput;
var defaultSearchText;

var festivalStart;
var today;

$(document).ready( init );

function init() {
	
	searchTimerId = 0;
	searchLink = $("#search");
	searchPopup = $("#search-box");
	searchInput = $("#search-field");
	
	eventsTimerId = 0;
	eventsLink = $("#events-calendar");
	eventsPopup = $("#events-popup");
	dateDivs = $("a.date:not(.current)");
	
	eventsLink.click( showEventsPopup );
	eventsLink.mouseover( stopHideCountdownEvents ); 
	eventsLink.mouseout( startCountdownToHideEvents );
	
	eventsPopup.mouseover( stopHideCountdownEvents );
	eventsPopup.mouseout( startCountdownToHideEvents );
	
	dateDivs.mouseover( showLongDate );
	dateDivs.mouseout( showShortDate );
	showLongAbbrForCurrentDate();
	
	searchLink.click( showSearchPopup);
	searchLink.mouseover( stopHideCountdowSearch );
	searchLink.mouseout( startCountdownToHideSearch );
	
	searchPopup.mouseover( stopHideCountdowSearch );
	searchPopup.mouseout( startCountdownToHideSearch );
	
	defaultSearchText = searchInput.val();
	searchInput.focus( hideDefaultText );
	searchInput.blur( startCountdownToHideSearch )
	
	beginUpdatingCountdown();
}

function showSearchPopup() {
	if(searchInput.val() == "") setSearchTextToDefault();
	searchPopup.show();
	searchPopup.css('display', 'block');
}

function hideSearchPopup() {
	searchPopup.fadeOut(300);
}

function startCountdownToHideSearch() {
	if(searchInput.is(":focus")) return;
	stopHideCountdowSearch();
	searchTimerId = window.setTimeout(hideSearchPopup, countdownDuration);
}

function stopHideCountdowSearch() {
	if(searchTimerId) window.clearTimeout(searchTimerId);
	searchTimerId = 0;
}

function setSearchTextToDefault() {
	searchInput.val(defaultSearchText);	
}

function hideDefaultText() {
	if(searchInput.val() == defaultSearchText){
		searchInput.val("")	;
	}
}

function showEventsPopup() {
	stopHideCountdownEvents();
	//positionPopup();
	//fadeInEventsPopup();
	if(eventsPopup.css("display") == "none") slideInEventsPopup();
}

function hideEventsPopup() {
	stopHideCountdownEvents();
	fadeOutEventsPopup();
}

function startCountdownToHideEvents() {
	stopHideCountdownEvents();
	eventsTimerId = window.setTimeout(hideEventsPopup, countdownDuration);
}

function stopHideCountdownEvents() {
	if(eventsTimerId) window.clearTimeout(eventsTimerId);
	eventsTimerId = 0;
}

function positionPopup() {
	var xOffset = -72 + eventsLink.width()/2; //Distance from Corner of Popup to the Arrow attached to the popup
	var yOffset = 30; //Distance from top of link to the Arrow
	var cordinates = eventsLink.offset();
	
	eventsPopup.css("top", String( (cordinates.top+yOffset) + "px") );
	eventsPopup.css("left", String((cordinates.left+xOffset) + "px"));
}

function slideInEventsPopup() {
	eventsPopup.css("paddingTop", "0px");
	eventsPopup.css("paddingBottom", "0px");
	eventsPopup.css("height", "12px");
	eventsPopup.css("display", "block");
	eventsPopup.css("width", "10px")
	eventsPopup.animate({width: "592px"}, {duration:150, complete: function(){
		eventsPopup.animate({height:"164px", paddingTop:"21px", paddingBottom:"20px;"}, {duration:200});
	}});
}

function fadeInEventsPopup() {
	eventsPopup.fadeIn(300);
}

function fadeOutEventsPopup() {
	eventsPopup.fadeOut(300);
}

function showShortDate() {
	var currentDate = $(this);
	var long_day = currentDate.find(".weekday .long-day");
	long_day.hide();
}

function showLongDate() {
	var currentDate = $(this);
	var long_day = currentDate.find(".weekday .long-day");
	long_day.show()
}

function showLongAbbrForCurrentDate() {
	var currentDate = $(".current");
	var long_day = currentDate.find(".weekday .long-day");
	long_day.show()
}

function beginUpdatingCountdown() {
	today = new Date();
	festivalStart = new Date("March 28, 2013 12:00:00");
	updateCountdown();
	if(today < festivalStart) setInterval(updateCountdown, 1000);	
}

function updateCountdown() {
	var today = new Date();
	var millisLeft = (festivalStart - today)/1000;
	var seconds = Math.floor(millisLeft%60);
	millisLeft/=60;
	var minutes = Math.floor(millisLeft%60);
	millisLeft/=60;
	var hours = Math.floor(millisLeft%24);
	millisLeft/=24;
	var days = Math.floor(millisLeft);
	
	$("#days-countdown").html(days);
	$("#hours-countdown").html(hours);
	$("#mins-countdown").html(minutes);
	$("#seconds-countdown").html(seconds);
}
