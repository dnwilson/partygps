showAdvancedOptions = ->
  category = $('#category-select option:selected').text();
  recurring = $('#recurring').prop('checked')
  if recurring == false
    $('.date-entry').removeClass 'hidden'
    $('.advanced-event').addClass 'hidden'    
    $('.category-select option[value=2]').attr("selected","selected");
  else
    $('.date-entry').addClass 'hidden'
    $('.advanced-event').removeClass 'hidden'

$ ->
  $('#recurring').on 'click', showAdvancedOptions
  $('.category').on 'change', showAdvancedOptions
  $( document ).ready(showAdvancedOptions)