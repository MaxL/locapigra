document.addEventListener("turbolinks:load", function() {
  console.log('listened');
  $('#pages').sortable({
    update: function(e, ui) {
      $.ajax({
        url: $(this).data("url"),
        type: "PATCH",
        data: $(this).sortable('serialize'),
      });
    }
  });

});
