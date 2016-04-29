$(document).ready(function() {
  $('.magnific-image').magnificPopup({type: 'image'});
  $('.card').matchHeight();

  menuToggle.init();
});

$(window).load(function() {
  //$('.card').matchHeight();
});

var menuToggle = {};

menuToggle.init = function iniF() {
  var $btn = $('#navbar-toggle'),
      $menu = $('#navbar-main');

  $btn.click(function() {
    $menu.toggleClass('shown');
  });
};
