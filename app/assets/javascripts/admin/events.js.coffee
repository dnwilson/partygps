showAdvancedOptions = () ->
	if $('.advanced-event').css('display') == 'none'
		$('.date-entry').hide()
		$('.advanced-event').show()
		$(".category-select select").val("WEEKLY");
		$('.frequency').html("<label class='col-sm-2 col-sm-2 control-label' for='event_day_of_occurrence'>When</label>
		  <div class='col-sm-10'>
		    <select class='form-control' id='event_day_of_occurrence' name='event[day_of_occurrence]'><option value='Sundays'>Sundays</option>
		    <option value='Mondays'>Mondays</option>
		    <option value='Tuesdays'>Tuesdays</option>
		    <option value='Wednesdays'>Wednesdays</option>
		    <option value='Thursdays'>Thursdays</option>
		    <option value='Fridays'>Fridays</option>
		    <option value='Saturdays'>Saturdays</option></select>
		  </div>")
	else
		$('.advanced-event').hide()
		$('.frequency').html("")
		$('.date-entry').show()

# setupSelectOptions = (list) ->
# 	fo
showEventOccurrenceType = () ->
	weeklyOptions = "<label class='col-sm-2 col-sm-2 control-label' for='event_day_of_occurrence'>When</label>
		  <div class='col-sm-10'>
		    <select class='form-control' id='event_day_of_occurrence' name='event[day_of_occurrence]'><option value='Sundays'>Sundays</option>
		    <option value='Mondays'>Mondays</option>
		    <option value='Tuesdays'>Tuesdays</option>
		    <option value='Wednesdays'>Wednesdays</option>
		    <option value='Thursdays'>Thursdays</option>
		    <option value='Fridays'>Fridays</option>
		    <option value='Saturdays'>Saturdays</option></select>
		  </div>"

	monthlyOptions = "<label class='col-sm-2 col-sm-2 control-label' for='event_frequency'>When</label><div class='col-sm-5'><select class='form-control' id='event_frequency' name='event[frequency]'><option value='First'>First</option><option value='Second'>Second</option><option value='Third'>Third</option><option value='Fourth'>Fourth</option><option value='Last'>Last</option><option value='Every Other'>Every Other</option></select></div><div class='col-offset-sm-1 col-sm-5'><select class='form-control' id='event_day_of_occurrence' name='event[day_of_occurrence]'><option value='Sundays'>Sundays</option><option value='Mondays'>Mondays</option><option value='Tuesdays'>Tuesdays</option><option value='Wednesdays'>Wednesdays</option><option value='Thursdays'>Thursdays</option><option value='Fridays'>Fridays</option><option value='Saturdays'>Saturdays</option></select></div>"

	annualOptions = "<label class='col-sm-2 col-sm-2 control-label' for='event_frequency'>When</label>
		<div class='col-sm-3'>
		  <select class='form-control' id='event_frequency' name='event[frequency]'><option value='First'>First</option>
		  <option value='Second'>Second</option>
		  <option value='Third'>Third</option>
		  <option value='Fourth'>Fourth</option>
		  <option value='Last'>Last</option>
		  <option value='Every Other'>Every Other</option></select>
		</div>
		<div class='col-offset-sm-1 col-sm-3'>
		  <select class='form-control' id='event_day_of_occurrence' name='event[day_of_occurrence]'><option value='Sundays'>Sundays</option>
		  <option value='Mondays'>Mondays</option>
		  <option value='Tuesdays'>Tuesdays</option>
		  <option value='Wednesdays'>Wednesdays</option>
		  <option value='Thursdays'>Thursdays</option>
		  <option value='Fridays'>Fridays</option>
		  <option value='Saturdays'>Saturdays</option></select>
		</div>
		<div class='col-offset-sm-1 col-sm-4'>
		  <select class='form-control' id='event_month_of_occurrence' name='event[month_of_occurrence]'><option value='January'>January</option>
		  <option value='February'>February</option>
		  <option value='March'>March</option>
		  <option value='April'>April</option>
		  <option value='May'>May</option>
		  <option value='June'>June</option>
		  <option value='July'>July</option>
		  <option value='August'>August</option>
		  <option value='September'>September</option>
		  <option value='October'>October</option>
		  <option value='November'>November</option>
		  <option value='December'>December</option></select>
		</div>"

	eventOccurrence = $('.category').find(":selected").text()
	if eventOccurrence == 'WEEKLY' || eventOccurrence == "BI-WEEKLY"
		$('.frequency').html(weeklyOptions)
	else if eventOccurrence == 'MONTHLY'
		$('.frequency').html(monthlyOptions)
	else if eventOccurrence == 'ANNUAL'
		$('.frequency').html(annualOptions)
	else
		$('.advanced-event').hide()
		$('.frequency').html("")
		$('.date-entry').show()

resetForm = () ->
	$('.style-form')[0].reset()

$ ->
	$('.advanced-toggle').on 'click', showAdvancedOptions
	$('.category').on 'change', showEventOccurrenceType
