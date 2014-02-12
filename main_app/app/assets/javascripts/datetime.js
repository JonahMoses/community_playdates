var setup;
setup = function() {

    // create DatePicker from input HTML element
  $("#datepicker").kendoDatePicker();

  function startChange() {
    var startTime = start.value();

    if (startTime) {
      startTime = new Date(startTime);

      end.max(startTime);

      startTime.setMinutes(startTime.getMinutes() + this.options.interval);

      end.min(startTime);
      end.value(startTime);
    }
  }

  //init start timepicker
  var start = $("#start").kendoTimePicker({change: startChange}).data("kendoTimePicker");

  //init end timepicker
  var end = $("#end").kendoTimePicker().data("kendoTimePicker");

  //define min/max range
  start.min("8:00 AM");
  start.max("6:00 PM");

  //define min/max range
  end.min("8:00 AM");
  end.max("7:30 AM");
};

$(document).ready(setup);
// page:load is for turbolinks
$(document).on('page:load', setup);
