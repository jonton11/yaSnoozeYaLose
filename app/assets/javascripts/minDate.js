$(document).ready(function() {
  $('#date').datetimepicker({
    minDate: moment().add(1, 'days')
  });
});
