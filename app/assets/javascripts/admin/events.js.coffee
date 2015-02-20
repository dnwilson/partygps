showAdvancedOptions = ->
  recurring = $('#recurring').prop('checked')
  if recurring is false
    $('.date-entry').removeClass 'hidden'
    $('.advanced-event').addClass 'hidden'    
    $('#category option[value=2]').attr("selected","selected")
  else
    $('.date-entry').addClass 'hidden'
    $('.advanced-event').removeClass 'hidden'
    showRecurring()

showRecurring = ->
  category = $('#category option:selected').text()
  if category is "Weekly" or category is ""
    $('#category option[value=2]').attr("selected","selected")
    hidden_fields = ['.listed_type', '.listed_month']
    remove_fields = ['.col-sm-2', '.col-md-2']
    $('.listed_type').addClass 'hidden'
    $('.listed_month').addClass 'hidden'
    $('.listed_day').removeClass 'col-sm-2'
    $('.listed_day').removeClass 'col-md-2'
    $('.listed_day').addClass 'col-sm-10'
  else if category is "Monthly"
    hidden_fields = ['.listed_month']
    remove_fields = ['.col-sm-2', '.col-md-2']
    $('.listed_type').removeClass 'col-sm-3 hidden'
    $('.listed_day').removeClass 'hidden col-sm-10'
    $('.listed_month').removeClass 'col-sm-3'
    $('.listed_type').addClass 'col-sm-5'
    $('.listed_day').addClass 'col-sm-5'
    $('.listed_month').addClass 'hidden'
  else
    $('.listed_type').removeClass 'col-sm-5 hidden'
    $('.listed_day').removeClass 'col-sm-5 hidden col-sm-10'
    $('.listed_month').removeClass 'hidden'
    $('.listed_type').addClass 'col-sm-3'
    $('.listed_day').addClass 'col-sm-3'
    $('.listed_month').addClass 'col-sm-4'
# removeField = (args)->
#   for i in args.length by step
  

$ ->
  $('#recurring').on 'click', showAdvancedOptions
  $('.category').on 'change', showAdvancedOptions
  $( document ).ready(showAdvancedOptions)