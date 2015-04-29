// JavaScript Document
	var eventWidth = 312;
	var leftEdge = -12;
	var rightEdge = 750;
	var timelineWidth = 800;
	var randomMovementDelay = 6000;
	var slidingContainerWidth;
	var numPastEvents;
	var totalEvents;
	var totalEventsForMath;
	
	var slidingContainer;
	var goldArrow;
	
	//Drag Physics Vars
	var eventsEasing = .8;
	var friction = 0.85;
	var maxSpeed = 75;
	var speed;
	var positionHistory = Array(2);
	var currentEvent = -1;
	var sliderOffsetDiff = 0;
	
	var skidTimerId;
	var dragTimerId;
	var timelineEventsTimerId;
	var randomMovementTimerId;
	var numberOfMoves = 0;
	var maxMovesCount = 5;
	
	
	$(document).ready( init );

	function init() {
		
		totalEvents = $("#sliding-container > div").length;
        if(totalEvents < 2) return;

		numPastEvents = $("#sliding-container > div.past").length;
		totalEventsForMath = totalEvents -1;
		
		goldArrow = $("#red-slider");
		goldArrow.bind('dragstart', startDrag);
		goldArrow.bind('drag', dragGoldArrow);
		goldArrow.bind('dragend', endDrag);
		
		slidingContainer = $("div#sliding-container");
		setSlidingContainerWidth();
		
		lockEventsToSlider();
        startSlidingToRandomEvents();
	}
	
	function startSlidingToRandomEvents() {
        jumpToRandomStart();
        moveSliderToRandomEvent();
		randomMovementTimerId = setInterval(moveSliderToRandomEvent, randomMovementDelay);
	}
	
	function stopSlidingToRandomEvents() {
		if(!randomMovementTimerId) return;
		setEventDimmingBasedOnDate();
        goldArrow.stop();
		clearInterval(randomMovementTimerId);
		randomMovementTimerId = 0;
	}
	
	function startDrag() {
		dragTimerId = setInterval(updatePositionHistory, 24);
		stopSlidingToRandomEvents();
	}
	
	function dragGoldArrow(event) {
		var containerOffset = getContainerOffset();
		var sliderPos = Math.min(Math.max(event.offsetX - containerOffset, leftEdge), rightEdge);
		goldArrow.css({ left: sliderPos });
	}
	
	function endDrag( event ) {
		clearInterval(dragTimerId);
		speed = positionHistory[1] - positionHistory[0];
		speed = Math.max(Math.min(speed, maxSpeed), -maxSpeed);
		skidTimerId = setInterval( skidToStop, 42); //~24 fps
	}
	
	function skidToStop() {
		var currentPosition = getSliderPosition();
		var newPosition = currentPosition + speed;
		newPosition = Math.max(Math.min(newPosition, rightEdge), leftEdge);
		goldArrow.css({ left: newPosition });
		
		speed *= friction;
		if(Math.abs(speed) < .5) clearInterval(skidTimerId);
	}
	
	function lockEventsToSlider() {
		timelineEventsTimerId = setInterval(moveSliderEvents, 42);	
	}
	
	function moveSliderEvents(gotoIdeal) {
		var currentPosition = getSlidingContainerPosition();
		var idealPercentPosition = getSliderPositionPercent();
		var idealAbsolutePosition = -( idealPercentPosition * (slidingContainerWidth - timelineWidth) );
		var effectivePosition = idealAbsolutePosition - (idealAbsolutePosition-currentPosition)*eventsEasing;
		slidingContainer.css({marginLeft: (gotoIdeal ? idealAbsolutePosition : effectivePosition) });
	}
	
	function moveSliderToCurrentEvent() {
		var currentDayPos = getCurrentDayPosition();
		autoMoveSliderToEvent(currentDayPos);
	}

    function jumpToRandomStart() {
        var randomStartPosition = getRandomStartPosition();
        moveSliderToEvent(randomStartPosition);
    }

    function moveSliderToEvent(eventPosition) {
        var percentagePos = eventPosition/slidingContainerWidth;
        var absolutePos = percentagePos*(rightEdge - leftEdge) + getContainerOffset();
        var containerOffset = getContainerOffset();

        var sliderPos = Math.min(Math.max(absolutePos - containerOffset, leftEdge), rightEdge);
        var currrentPos = Number(goldArrow.css("left").replace("px", ""));
        goldArrow.css({left:sliderPos});
        moveSliderEvents(sliderPos);
    }

	function moveSliderToRandomEvent() {
		if(numberOfMoves < maxMovesCount) {
			var randomEventPosition = getRandomDayPosition();
			animateSliderToEvent(randomEventPosition);
			numberOfMoves++;
		} else {
			stopSlidingToRandomEvents();
		}
	}
	
	function animateSliderToEvent(eventPosition) {
		var percentagePos = eventPosition/slidingContainerWidth;
		var absolutePos = percentagePos*(rightEdge - leftEdge) + getContainerOffset();
		var containerOffset = getContainerOffset();
		
		var sliderPos = Math.min(Math.max(absolutePos - containerOffset, leftEdge), rightEdge);
		var currrentPos = Number(goldArrow.css("left").replace("px", ""));
		goldArrow.animate({left:sliderPos}, {duration:5000});
	}
	
	function autoMoveSliderToEvent(eventPosition) {
		var percentagePos = eventPosition/slidingContainerWidth;
		var absolutePos = percentagePos*(rightEdge - leftEdge) + getContainerOffset();
		dragGoldArrow({offsetX:absolutePos});
		moveSliderEvents(true);
	}
	
	function updatePositionHistory(offsetX) {
		positionHistory[0] = positionHistory[1];
		positionHistory[1] = getSliderPosition();
	}
	
	function setSlidingContainerWidth() {
		var numChildren = $("#sliding-container > div").length;
		slidingContainerWidth = numChildren * eventWidth;
		slidingContainer.css("width", String(slidingContainerWidth + "px"));
	}

    function getRandomStartPosition() {
        var randomEvent = Math.round(Math.random()*totalEventsForMath);
        currentEvent = randomEvent;
        var percentOffset = eventWidth*(randomEvent/totalEventsForMath);
        var staticOffset = (eventWidth/2);
        sliderOffsetDiff = (staticOffset - percentOffset);
        //goldArrow.animate({marginLeft:String(sliderOffsetDiff +"px")}, {duration:1000});
        return randomEvent*eventWidth + percentOffset;
    }

	function getRandomDayPosition() {
        var currentEventNum = (isNaN(currentEvent) ? 0 : currentEvent );
		do{ var randomEvent = Math.round(Math.random()*totalEventsForMath); } while(randomEvent == currentEvent || Math.abs(currentEventNum - randomEvent) > 5);
		currentEvent = randomEvent;
		var percentOffset = eventWidth*(randomEvent/totalEventsForMath);
		var staticOffset = (eventWidth/2);
		sliderOffsetDiff = (staticOffset - percentOffset);
		//goldArrow.animate({marginLeft:String(sliderOffsetDiff +"px")}, {duration:1000});
		return randomEvent*eventWidth + percentOffset;
	}
	
	function getCurrentDayPosition() {
		return numPastEvents*eventWidth + eventWidth*(numPastEvents/totalEventsForMath);
	}
	
	function getContainerOffset() {
        var leftMargin = parseFloat($("#timeline-slider").css("margin-left").replace("px", ""));
		return $("#timeline-container").offset().left + leftMargin;
	}
	
	function getSliderPositionPercent() {
		var totalWidth = rightEdge - leftEdge;
		return ((getSliderPosition()-leftEdge) / totalWidth);	
	}
	
	function getSliderPosition(){
		return Number( goldArrow.css("left").replace("px", "") );
	}
	
	function getSlidingContainerPosition() {
        var currentPos = parseFloat( slidingContainer.css("margin-left").replace("px", "") );
		if(isNaN(currentPos))
            currentPos = 0;
        return currentPos;
	}
	
	function setEventDimmingBasedOnDate() {
		dimAllEvents();
		for(var i = 0; i <= totalEvents; i++){
			if(i > numPastEvents) {
				var eventToHighlight = $("#sliding-container div:nth-child(" + i + ")");	
				eventToHighlight.stop();
				highlightEvent(eventToHighlight);
			}
		}
	}

	function highlightEvent(timelineEvent) {
		timelineEvent.removeClass("past");
	}

	function dimAllEvents() {
		$(".slider-event").addClass("past");
	}

/**/