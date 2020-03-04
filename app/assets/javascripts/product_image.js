$(function(){
  $('#photo_upload').on('change', function(e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    var $preview = $("li.preview__image");

    if(file.type.indexOf("image") < 0){
      return false;
    }

    reader.onload = (function(file){
      return function(e) {
        $('ul.preview').show();
        $preview.append($('<img>').attr({
          src: e.target.result,
          width: "110px",
          class: "preview",
          title: file.name
        }));
      }
    })(file);
    reader.readAsDataURL(file);
  })
})