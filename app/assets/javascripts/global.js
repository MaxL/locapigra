$(document).ready(function() {
  $('.magnific-image').magnificPopup({type: 'image'});
  $('.card-image').matchHeight();

  $('.cart-btn').tooltip();

  $('.tooltip-item').tooltip();

  $('.order-address-form').validate();

  formLabel();
  if ( $('.homepage').length ) {
    fireworks();
  }

});

$(document).on("turbolinks:load", function() {
  var gaUrl = window.location.href;

  dataLayer.push({
    'event':'pageView',
    'virtualUrl': gaUrl
  });

  $('.magnific-image').magnificPopup({type: 'image'});
  $('.card-image').matchHeight();

  $('.cart-btn').tooltip();

  $('.tooltip-item').tooltip();

  $('.order-address-form').validate();

  formLabel();
  if ( $('.homepage').length ) {
    fireworks();
  }
});

// override jquery validate plugin defaults
$.validator.setDefaults({
  highlight: function(element) {
    $(element).closest('.form-group').addClass('has-error');
  },
  unhighlight: function(element) {
    $(element).closest('.form-group').removeClass('has-error');
  },
  errorElement: 'span',
  errorClass: 'help-block',
  errorPlacement: function(error, element) {
    if(element.parent('.input-group').length) {
      error.insertAfter(element.parent());
    } else {
      error.insertAfter(element);
    }
  }
});



$(document).on('click', '#navbar-toggle', function() {
  $('#navbar-main').toggleClass('shown');
});

var formLabel = function formLabelF() {
  var $formInput = $('.loca-form input.form-control[type="text"], .loca-form input.form-control[type="tel"], .loca-form input.form-control[type="email"], .loca-form input.form-control[type="password"], .loca-form textarea.form-control, .loca-form select.form-control'),
      $formLabel = $('.loca-form label');

  $formInput.each(function() {
    if ($(this).val() !== '') {
      $(this).prev('.loca-label').addClass('focussed');
    }
    $(this).focus(function() {
      $(this).prev('.loca-label').addClass('focussed');
      $(this).prop('placeholder', '');
    });
  });
};
