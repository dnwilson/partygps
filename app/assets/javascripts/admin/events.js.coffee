showAdvancedOptions = () ->
	if $('.advanced-event').css('display') == 'none'
		$('.advanced-event').show()
		$('.date-entry').fadeOut()
		$('.time-entry').fadeOut()
	else
		$('.advanced-event').hide()
		$('.date-entry').fadeIn()
		$('.time-entry').fadeIn()

showEventOccurrenceType = () ->
	eventOccurrence = $('.occurrence').find(":selected").text()
	if eventOccurrence == 'WEEKLY' 
		$('.occurrency-type').show()
	else
		$('.occurrency-type').hide()

$ ->
	$('.advanced-toggle').on 'click', showAdvancedOptions
	$('.occurrence').on 'change', showEventOccurrenceType
