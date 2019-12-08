$(function(){
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    console.log(html);
    return html;
    
  }
  

  function appendSizeOption(size){
    var html = `<option value="${size.id}">${size.size}</option>`;
    return html;
  }

  function appendChildrenBox(insertHTML){
    var childSelectHtml = "";
    childSelectHtml = `<div class='listing-select-wrapper__added' id= 'children_wrapper'>
    <div class='listing-select-wrapper__box'>
      <select class="listing-select-wrapper__box--select" id="child_category" name="category_id">
        <option value="---" data-category="---">---</option>
        ${insertHTML}
      <select>
      <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
    </div>
  </div>`;
  $('.category-form').append(childSelectHtml);
  }

  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='listing-select-wrapper__added' id= 'grandchildren_wrapper'>
    <div class='listing-select-wrapper__box'>
      <select class="listing-select-wrapper__box--select" id="grandchild_category" name="category_id">
        <option value="---" data-category="---">---</option>
        ${insertHTML}
      <select>
      <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
    </div>
  </div>`;
  $('.category-form').append(grandchildSelectHtml);
  }

  function appendSizeBox(insertHTML){
    var sizeSelectHtml = '';
    sizeSelectHtml = `<div class="listing-product-detail__size" id= 'size_wrapper'>
                        <label class="category-form__text" for="サイズ">サイズ</label>
                        <span class='category-form__icon'>必須</span>
                        <div class='listing-select-wrapper__added--size'>
                          <div class='listing-select-wrapper__box'>
                            <select class="listing-select-wrapper__box--select" id="size" name="products_size_id">
                              <option value="---">---</option>
                              ${insertHTML}
                            <select>
                            <i class='fas fa-chevron-down listing-select-wrapper__box--arrow-down'></i>
                          </div>
                        </div>
                      </div>`;
    $('.category-form').append(sizeSelectHtml);
  }

  $("#parent_category").on('change',function(){
    var parentVal = document.getElementById("parent_category").value;
    
    if(parentVal != "---"){
      $.ajax({
        url: '/products/get_category_children',
        type: 'GET',
        data: { parent_name: parentVal},
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove();
        $('#grandchildren_wrapper').remove();
        $('#size_wrapper').remove();
        $('.sell-product-details').css('height', '220px');
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリーの取得に失敗しました');
      })
    } else {
      $('#children_wrapper').remove();
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('.sell-product-details').css('height', '190px');
    }
  });

  $('.category-form').on('change', '#child_category', function(){
    var childId = $('#child_category option:selected').data('category');
    if (childId != "---"){
      $.ajax({
        url: '/products/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove(); 
          $('#size_wrapper').remove();
          $('.sell-product-details').css('height', '270px');
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove();
      $('#size_wrapper').remove();
      $('.sell-product-details').css('height', '220px');
    }
  });

  $('.category-form').on('change', '#grandchild_category', function(){
    var grandchildId = $('#grandchild_category option:selected').data('category'); //選択された孫カテゴリーのidを取得
    if (grandchildId != "---"){
    $.ajax({
      url: '/products/get_size',
      type: 'GET',
      data: { grandchild_id: grandchildId },
      dataType: 'json'
    })
    .done(function(sizes){
      $('.sell-product-details').css('height', '360px');
      $('#size_wrapper').remove(); 
      if (sizes.length != 0) {
      var insertHTML = '';
        sizes.forEach(function(size){
          insertHTML += appendSizeOption(size);
        });
        appendSizeBox(insertHTML);
    } else {
      $('#size_wrapper').remove();
      $('.sell-product-details').css('height', '270px');
    }
    })
    .fail(function(){
      alert('サイズ取得に失敗しました');
    })
    } else {
      $('#size_wrapper').remove();
      $('.sell-product-details').css('height', '270px');
    } 
  });
});

