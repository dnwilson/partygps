showAdvancedOptions = () ->
	if $('.advanced-event').css('display') == 'none'
		$('.advanced-event').show()
		$('.date-entry').hide()
	else
		$('.advanced-event').hide()
		$('.date-entry').show()

showEventOccurrenceType = () ->
	eventOccurrence = $('.occurrence').find(":selected").text()
	if eventOccurrence == 'WEEKLY' 
		$('.weekly').show()
		$('.monthly').hide()
		$('.annual').hide()
	else if eventOccurrence == 'MONTHLY'
		$('.weekly').hide()
		$('.monthly').show()
		$('.annual').hide()
	else if eventOccurrence == 'ANNUAL'
		$('.weekly').hide()
		$('.monthly').hide()
		$('.annual').show()
	else
		$('.weekly').hide()
		$('.monthly').hide()
		$('.annual').hide()
resetForm = () ->
	$('.style-form')[0].reset()

$ ->
	# $(document).ready(resetForm)
	# $(document).on('page:load', resetForm)
	$('.advanced-toggle').on 'click', showAdvancedOptions
	$('.occurrence').on 'change', showEventOccurrenceType
