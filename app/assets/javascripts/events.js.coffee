# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
function showAdvancedOptions () {
	if ($('.advanced-event').css('display') == 'none') {
		$('.advanced-event').show();
		$('.date-entry').fadeOut();
		$('.time-entry').fadeOut();
	} else{
		$('.advanced-event').hide();
		$('.date-entry').fadeIn();
		$('.time-entry').fadeIn();
	};
};

function showEventOccurrenceType() {
	var eventOccurrence = $('.occurrence').find(":selected").text();
	if ( eventOccurrence == 'WEEKLY' ) {
		$('.occurrency-type').show();
	} else{
		$('.occurrency-type').hide();
	};
}
$('.advanced-toggle').click(showAdvancedOptions);
$('.occurrence').change(showEventOccurrenceType);
