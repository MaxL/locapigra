$(document).ready(function() {
  $('.magnific-image').magnificPopup({type: 'image'});
  $('.card').matchHeight();

  $('.cart-btn').tooltip();
});

$(window).load(function() {
  //$('.card').matchHeight();
});


$(document).on('click', '#navbar-toggle', function() {
  $('#navbar-main').toggleClass('shown');
})
