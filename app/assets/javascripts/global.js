$(document).ready(function() {
  keybindings();
  $('.magnific-image').magnificPopup({
    type: 'image'
  });
  $('.magnific-gallery').each(function() { // the containers for all your galleries
    $(this).magnificPopup({
        delegate: 'img', // the selector for gallery item
        type: 'image',
        gallery: {
          enabled:true
        }
    });
  });
  //$('.card-image').matchHeight();

  $('.cart-btn').tooltip();

  $('.tooltip-item').tooltip();

  $('.order-address-form').validate();

  formLabel();
  if ( $('.homepage').length ) {
    fireworks();
  }

});

$(document).on("turbolinks:load", function() {
  keybindings();
  var gaUrl = window.location.href;

  dataLayer.push({
    'event':'pageView',
    'virtualUrl': gaUrl
  });

  $('.magnific-image').magnificPopup({
    type: 'image'
  });
  $('.magnific-gallery').each(function() { // the containers for all your galleries
    $(this).magnificPopup({
        delegate: 'img', // the selector for gallery item
        type: 'image',
        gallery: {
          enabled:true
        }
    });
  });
  //$('.card-image').matchHeight();

  $('.cart-btn').tooltip();

  $('.tooltip-item').tooltip();

  $('.order-address-form').validate();

  formLabel();
  if ( $('.homepage').length ) {
    fireworks();
  }

  $('.posts').waitForImages(function() {
    // All descendant images have loaded, now slide up.
    $(this).masonry({
      // options...
      itemSelector: '.post',
      columnWidth: '.post'
    });
  });

  $( "select" ).select2({
    theme: "bootstrap"
  });

});

$('.posts').masonry({
  // options...
  itemSelector: '.post',
  columnWidth: '.post'
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

var keybindings = function() {
  $(document).keydown(function(e) {
      switch(e.which) {
          case 37: // left
            $('.previous_page').click();
          break;

          //case 38: // up
          //break;

          case 39: // right
            $('.next_page').click();
          break;

          //case 40: // down
          //break;

          default: return; // exit this handler for other keys
      }
      e.preventDefault(); // prevent the default action (scroll / move caret)
  });
}
