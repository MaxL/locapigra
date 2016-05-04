$(document).ready(function() {
  $('.magnific-image').magnificPopup({type: 'image'});
  $('.card').matchHeight();

  menuToggle.init();

  $('[data-toggle="tooltip"]').tooltip();
});

$(window).load(function() {
  //$('.card').matchHeight();
});

var menuToggle = {};

menuToggle.init = function iniF() {
  var $btn = $('#navbar-toggle'),
      $menu = $('#navbar-main'),
      $overlay = $('#overlay');

  $btn.click(function() {
    $menu.toggleClass('shown');
  });
};
