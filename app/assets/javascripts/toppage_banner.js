$(function(){
  //変数の定義
  var top_slider = $(".top__banners");
  var prev_btn   = $('.slider-control__left')
  var next_btn   = $('.slider-control__right')
  var count      = 0
  var interval   = 4000
  var indicators = ('.top__indicators')

// 前へボタン関数
  $(prev_btn).on('click',function(){
    if (count== 0){
    $(top_slider).animate({left:'-2880px'},
    500,'swing');
    $(indicators).children(":last").css({'background-color':'#fff'});
    $(indicators).children(":last").siblings().css({'background-color':'hsla(0,0%,100%,.6)'});
    count = 2
    resetTimer()
    } else if(count==1){
      $(top_slider).animate({left:'0'},
      500,'swing');
      $(indicators).children(":first").css({'background-color':'#fff'});
      $(indicators).children(":first").siblings().css({'background-color':'hsla(0,0%,100%,.6)'});
    count = 0
    resetTimer()
    } else {
      $(top_slider).animate({left:'-1440px'},
      500,'swing');
      $(indicators).children(":nth-child(2)").css({'background-color':'#fff'});
      $(indicators).children(":nth-child(2)").siblings().css({'background-color':'hsla(0,0%,100%,.6)'});
    count = 1
    resetTimer()
    };
  });
// 次へ,タイマー、関数
  function nextPreview () {
    if (count== 0){
    $(top_slider).animate({left:'-1440px'},
    500,'swing');
    $(indicators).children(":nth-child(2)").css({'background-color':'#fff'});
    $(indicators).children(":nth-child(2)").siblings().css({'background-color':'hsla(0,0%,100%,.6)'});
    count = 1
    resetTimer()
    }else if(count==1){
    $(top_slider).animate({left:'-2880px'},
    500,'swing');
    $(indicators).children(":last").css({'background-color':'#fff'});
    $(indicators).children(":last").siblings().css({'background-color':'hsla(0,0%,100%,.6)'});
    count = 2
    resetTimer()
    } else {
    $(top_slider).animate({left:'0'},
    500,'swing');
    $(indicators).children(":first").css({'background-color':'#fff'});
    $(indicators).children(":first").siblings().css({'background-color':'hsla(0,0%,100%,.6)'});
    count = 0
    resetTimer()
    };
  };

 // 次へボタン
  $(next_btn).on('click',function(){
    nextPreview ();
  });

  // タイマーを開始
  function startTimer () {
    timer = setInterval(function () {
      nextPreview ();
    }, interval);
  };

  // タイマーを停止
  function stopTimer () {
    clearInterval(timer);
  };

 //タイマーの再起動
  function resetTimer(){
    stopTimer ();
    startTimer ();
    console.log("dododod")
  };

//マウスをスライダーの上に置いたらストップ、はずしたら動く
  $(top_slider).on({
    mouseenter: stopTimer,
    mouseleave: startTimer
  });

// ウインドウが開いたらタイマースタート
  $(window).on("load", function(){
    startTimer();
  });

});