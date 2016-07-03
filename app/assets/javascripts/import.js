$('.imports.show').ready(function () {
  $.getJSON("/api/v1/import").then(function(response) {
    console.log(response)
  })
});
