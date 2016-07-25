$(document).ready(function() {
  $('.magnific-image').magnificPopup({type: 'image'});
  $('.card').matchHeight();
  $('.product-card-item').matchHeight();

  $('.cart-btn').tooltip();

  $('.order-address-form').validate();
});

$(document).on("page:load", function() {
  console.log('test');
  $('.magnific-image').magnificPopup({type: 'image'});
  $('.card').matchHeight();
  $('.product-card-item').matchHeight();

  $('.cart-btn').tooltip();

  $('.order-address-form').validate();
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

$(window).load(function() {
  //$('.card').matchHeight();
});


$(document).on('click', '#navbar-toggle', function() {
  $('#navbar-main').toggleClass('shown');
})
