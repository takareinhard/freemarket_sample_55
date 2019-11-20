$(function(){

  function separate(num){

    num = String(num);
    var len = num.length;

    if(len > 3){
        return separate(num.substring(0,len-3))+','+num.substring(len-3);
    } else {
        return num;
    }
  }

  $("#input_price").on('keyup',$("#input_price"), function() {
    var price = $(this).val();
    var mercari_margin = price * 0.1 ;
    var mercari_margin = Math.floor(mercari_margin);
    var saler_margin = price - mercari_margin;
    var mercari_margin = separate(mercari_margin);
    var saler_margin = separate(saler_margin); 
    
    if(price >= 300){
      $('#mercari-margin').text("¥"+mercari_margin);
      $('#saler-profit').text("¥"+saler_margin);
    }
    else{
      $('#mercari-margin').text("-");
      $('#saler-profit').text("-");
    }
  });
});