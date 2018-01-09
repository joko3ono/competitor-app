// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery
//= require best_in_place
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(function(){
  $('.best_in_place').best_in_place();

  $('.best_in_place').bind('ajax:success', function(event){
    $(event.target).find('.error-wrapper').remove();
  });

  $('.best_in_place').bind('ajax:error', function(event, response){
    errorMessages = JSON.parse(response.responseText);
    errorWrapper = $(event.target).find('.error-wrapper');
    if(errorWrapper.length == 0){
      errorWrapper = $("<div style='display: block;' class='label label-danger error-wrapper'></div");
    }

    errorWrapper.html(errorMessages.join('<br/>'));
    $(event.target).append(errorWrapper);
  });

  $('body').on('hidden.bs.modal', '.modal', function(){
    $(this).remove();
  });
});
