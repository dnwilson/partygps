showAdvancedOptions = () ->
	$('.advanced-event').show()

$ -> 
	$('.advanced-toggle').on 'click', showAdvancedOptions