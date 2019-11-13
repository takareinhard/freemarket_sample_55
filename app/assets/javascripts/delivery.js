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
  
  // function delivery_form_style(){
    
  //   $(fee_val).click(function(){
  //     var method_val = document.getElementById('method-form');
  //     $(method_val).style.display ="none";
    
      
  //   });
  // }
  // return delivery_form_style;
  









  // $("delivery-fee-form").change(function() {
  //   $("#delivery_method option[value='1']").remove();
  //   $("#delivery_method option[value='2']").remove();
  //   $("#delivery_method option[value='3']").remove();
  //   $("#delivery_method option[value='6']").remove();
  //   $("#delivery_method option[value='7']").remove();
  //   $("#delivery_method option[value='10']").remove();
  //   $("#delivery_method option[value='11']").remove();
  // })
});

//delivery-method-formの値の名前を変える