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

  $('.webcomic-img').swipe({
    //Generic swipe handler for all directions
    swipeLeft:function(event, direction, distance, duration, fingerCount, fingerData) {
      console.log("swipeLeft from callback");
      $('.next_page').click();
    },
    swipeRight:function(event, direction, distance, duration, fingerCount, fingerData) {
      console.log("swipeRight from callback");
      $('.previous_page').click();
    }
  });

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

  /*$('.posts').waitForImages(function() {
    // All descendant images have loaded, now slide up.
    $(this).masonry({
      // options...
      itemSelector: '.post',
      columnWidth: '.post'
    });
  });*/

  $( "select" ).select2({
    theme: "bootstrap"
  });

  $('.webcomic-img').swipe({
    //Generic swipe handler for all directions
    swipeLeft:function(event, direction, distance, duration, fingerCount, fingerData) {
      console.log("swipeLeft from callback");
      $('.next_page').click();
    },
    swipeRight:function(event, direction, distance, duration, fingerCount, fingerData) {
      console.log("swipeRight from callback");
      $('.previous_page').click();
    }
  });

  if ( $('#infinite-scrolling').length && $('.posts').length ) {
    scroller.reset();
    scroller.init();
  }

});

var scroller = (function() {

  var myScroller = {
    counter: 0,
    init: function() {
      var self = this;
      if ( $('#infinite-scrolling').length && $('.posts').length ) {
        $(window).scroll(function(e) {
          //$('.pagination .next_page a').attr('href');
          if ( $(window).scrollTop() > $(document).height() - $(window).height() - 50 ) {
            $('.pagination').text("Loading more posts...");
            self.counter++;
            var offset = self.counter * 10;
            var url = window.location.href  + '?offset=' + offset;
            $.getScript(url);
          }
        });
        $('body').on('touchmove', function(e) {
          if ( $(window).scrollTop() > $(document).height() - $(window).height() - 20 ) {
            $('.pagination').text("Loading more posts...");
            self.counter++;
            var offset = self.counter * 10;
            var url = window.location.href  + '?offset=' + offset;
            $.getScript(url);
          }
        });
        $(window).scroll();
      }
    },

    reset: function() {
      this.counter = 0;
    }
  };

  return myScroller;
})();

/*$('.posts').masonry({
  // options...
  itemSelector: '.post',
  columnWidth: '.post'
});*/

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
