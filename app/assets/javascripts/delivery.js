$(function(){
  let methodForm = document.getElementById("method-form");
  var feeVal= $("#delivery_fee");
  var aryPayer = ['---','未定','クロネコヤマト','ゆうパック','ゆうメール']
  var aryPostage = ['---','未定','クロネコヤマト','ゆうパック','ゆうメール','らくらくメルカリ便','レターパック','普通郵便(定形、定形外)','クリックポスト','ゆうパケット']
  $(feeVal).change(function(){
    var val = $(this).val();
    $detail = $("#delivery-detail");
    $optionMet = $('#method-form option');
    if(val == 1) {
      $detail.css("height", "440px");
      $(methodForm).show();
      $optionMet.remove();
        $.each(aryPostage, function(key, value){
          $('#product_shipping_method').append($('<option>').html(value).val(value));
        }); 
    } else if (val == 2){
      $detail.css("height", "440px");
      $(methodForm).show();
      $optionMet.remove();
        $.each(aryPayer, function(key, value){
          $('#product_shipping_method').append($('<option>').html(value).val(value));
        }); 
    } else {
      $(methodForm).hide();
      $detail.css("height", "320px");
    }
  });
});