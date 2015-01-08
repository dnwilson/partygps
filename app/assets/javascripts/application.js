// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require turbolinks
//= require bootstrap
//= require jquery.dcjqaccordion.2.7
//= require jquery.scrollTo.min
//= require jquery.nicescroll
//= require jquery.sparkline
//= require common-scripts
//= require gritter/js/jquery.gritter
//= require gritter-conf
//= require bootstrap-select.min
// require_tree .
function showAdvancedOptions () {
	if ($('.advanced-event').css('display') == 'none') {
		$('.advanced-event').show();
		$('.date-entry').hide();
	} else{
		$('.advanced-event').hide();
		$('.date-entry').show();
	};
};

function showEventOccurrenceType() {
	var eventOccurrence = $('.occurrence').find(":selected").text();
	if ( eventOccurrence == 'WEEKLY' ) {
		$('.occurrency-type').show();
	} else if( eventOccurrence == 'MONTHLY' ){
		$('.occurrency-type').hide();
		$('.occurs').show();
	}
	else{
		$('.occurrency-type').hide();
	};
}
$('.advanced-toggle').click(showAdvancedOptions);
$('.occurrence').change(showEventOccurrenceType);
