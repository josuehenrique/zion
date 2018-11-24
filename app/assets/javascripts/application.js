// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery-1.11.2.min
//= require rails-ujs
//= require jquery.easing.min
//= require bootstrap/js/bootstrap.min.js
//= require pace/pace.min.js
//= require perfect-scrollbar/perfect-scrollbar.min.js
//= require viewport/viewportchecker.js
//= require scripts
//= require bootbox.min

//= require file-upload
//= require jquery.maskedinput.min
//= require masks

//= require icheck/icheck.min.js
//= require datepicker/js/datepicker.js
//= require datepicker/js/bootstrap-datepicker.pt-BR.js
//= require boot.js

function hide_link(filter) {
  $('#' + filter).show();
  $('#link_' + filter).hide();
}

$('.fa-times').click(function() {
  $('#search-row').find('#search_keyword').val('')
});

function iCheckboxes_all(sender, targets) {
  $('#' + sender).on('ifChecked', function () {
    $('input.'+ targets).iCheck('check');
  });

  $('#' + sender).on('ifUnchecked', function () {
    $('input.'+ targets).iCheck('uncheck');
  });
}

$(document).ready(function(){
  if(environment == 'production' || environment == 'development') {
    $('input:checkbox').iCheck({checkboxClass: 'icheckbox_flat-blue'});

    setDatePicker();

    var confirmBox;

    confirmBox = function (message, element, callback) {
      bootbox.setLocale('pt');
      bootbox.confirm(message, function () {
      });

      $("button[data-bb-handler=confirm]").click(function (event) {
        event.preventDefault();
        $(".bootbox").modal("hide");
        callback();
        return false;
      });

      return $("button[data-bb-handler=cancel]").click(function (event) {
        event.preventDefault();
        $(".bootbox").modal("hide");
        return false;
      });
    };

    $.rails.allowAction = function (element) {
      var answer, message;
      message = element.data("confirm");
      answer = false;
      if (!message) {
        return true;
      }
      if ($.rails.fire(element, "confirm")) {
        confirmBox(message, element, function () {
          var allowAction, evt;
          if ($.rails.fire(element, "confirm:complete", [answer])) {
            allowAction = $.rails.allowAction;
            $.rails.allowAction = function () {
              return true;
            };
            if (element.get(0).click) {
              element.get(0).click();
            }
            return $.rails.allowAction = allowAction;
          }
        });
      }
      return false;
    };
  }
});

$('#modal-window').on('hidden.bs.modal', function (e) {
  window.location.reload(true);
});
