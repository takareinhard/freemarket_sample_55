$(function (){
  $('drop-box__upload').on('change','input[type="file"]', function(e) {
    var file = e.target.file[0],
        reader = new FileReaer(),
        $preview = $(".");
  });  
});