// // JavaScript Document
// $(document).ready(init);
	
// 	var timerInterval;
// 	var promoEventWidth;
// 	var animSpeed;
	
// 	var promoEvents;
// 	var promoButtons;
// 	var buttonContainer;
// 	var promoSlidingContainerWidth;
// 	var promoSlidingContainer;
// 	var rotationTimerId;
	
// 	function init() {
// 		promoEventWidth = 568;
// 		timerInterval = 5000;
// 		animSpeed = 450;
// 		promoSlidingContainer = $("div#promo-sliding-container");
// 		setPromoSlidingContainerWidth();
// 		createPromoButtons();
		
// 		promoButtons.mouseover( showHoverButton );
// 		promoButtons.mouseout( showDefaultButton );
// 		promoButtons.click( clickPromoButton );
// 		startRotation();
// 	}
	
// 	function startRotation() {
// 		rotationTimerId = setInterval(moveToNextPromoEvent, timerInterval);
// 	}
	
// 	function resetRotationTimer() {
// 		clearInterval(rotationTimerId);
// 		startRotation();
// 	}
	
// 	function moveToNextPromoEvent() {
// 		var index = getNextEventIndex();
// 		moveSlideToEvent(index);
// 		var button = $("#promo-button-container img:nth-child(" + Number(index+1) + ")");
// 		setActiveButton(button);	
// 	}
	
// 	function getNextEventIndex() {
// 		var marginLeft = -Number(promoSlidingContainer.css("marginLeft").replace("px", ""));
// 		var currentEventIndex = marginLeft/promoEventWidth;
// 		return (currentEventIndex == promoEvents.length-1 ? 0 : currentEventIndex+1);
// 	}
	
// 	function setPromoSlidingContainerWidth() {
// 		promoEvents = $("div#promo-sliding-container> div");
// 		promoSlidingContainerWidth = promoEvents.length * promoEventWidth;
// 		promoSlidingContainer.css("width", String(promoSlidingContainerWidth + "px"));
// 	}
	
// 	function createPromoButtons() {
// 		buttonContainer = $("#promo-button-container");
// 		for(var i = 0; i < promoEvents.length; i++) {
// 			var newButton = '<img src="/assets/promoButtonOff.png" class="promo-button" />';
// 			buttonContainer.append(newButton);
// 		}
// 		promoButtons = $("#promo-button-container > img");
// 		setActiveButton(buttonContainer.children(":first"));
// 	}
	
// 	function clickPromoButton() {
// 		var clickedButton = $(this);
// 		var index = clickedButton.index();
// 		setActiveButton(clickedButton);
// 		moveSlideToEvent(index);
// 		resetRotationTimer();
// 	}
	
// 	function moveSlideToEvent(index) {
// 		var position = -promoEventWidth * index;
// 		promoSlidingContainer.animate({marginLeft:position}, {duration:animSpeed});	
// 	}
	
// 	function setActiveButton(selectedButton) {
// 		promoButtons.attr("src", "/assets/promoButtonOff.png");
// 		selectedButton.attr("src", "/assets/promoButtonOn.png");
// 	}
	
// 	function showHoverButton() {
// 		if( !isActiveButton($(this)) ) 
// 			$(this).attr("src", "/assets/promoButtonHover.png");
// 	}
	
// 	function showDefaultButton() {
// 		if( !isActiveButton($(this)) ) 
// 			$(this).attr("src", "/assets/promoButtonOff.png");
// 	}
	
// 	function isActiveButton(button) {
// 		return Boolean(button.attr("src") == "/assets/promoButtonOn.png");
// 	}