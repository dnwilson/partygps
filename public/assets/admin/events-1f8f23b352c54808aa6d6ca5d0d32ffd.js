(function() {
  var resetForm, showAdvancedOptions, showEventOccurrenceType;

  showAdvancedOptions = function() {
    if ($('.advanced-event').css('display') === 'none') {
      $('.advanced-event').show();
      return $('.date-entry').hide();
    } else {
      $('.advanced-event').hide();
      return $('.date-entry').show();
    }
  };

  showEventOccurrenceType = function() {
    var eventOccurrence;
    eventOccurrence = $('.occurrence').find(":selected").text();
    if (eventOccurrence === 'WEEKLY') {
      $('.weekly').show();
      $('.monthly').hide();
      return $('.annual').hide();
    } else if (eventOccurrence === 'MONTHLY') {
      $('.weekly').hide();
      $('.monthly').show();
      return $('.annual').hide();
    } else if (eventOccurrence === 'ANNUAL') {
      $('.weekly').hide();
      $('.monthly').hide();
      return $('.annual').show();
    } else {
      $('.weekly').hide();
      $('.monthly').hide();
      return $('.annual').hide();
    }
  };

  resetForm = function() {
    return $('.style-form')[0].reset();
  };

  $(function() {
    $('.advanced-toggle').on('click', showAdvancedOptions);
    return $('.occurrence').on('change', showEventOccurrenceType);
  });

}).call(this);
