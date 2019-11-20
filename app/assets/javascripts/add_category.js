$(function(){
  function appendOption(category){
    var html = `<option value="${category.name}" data-category="${category.id}">${category.name}</option>`;
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
          $('#brand_wrapper').remove();
          $('.sell-product-details').css('height', '280px');
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
      $('#brand_wrapper').remove();
      $('.sell-product-details').css('height', '220px');
    }
  });
})