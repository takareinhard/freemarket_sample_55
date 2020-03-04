'use strict';
const miniimages = document.querySelectorAll('.mini-image');
console.log(miniimages);
miniimages.forEach(function(item, index) {
  console.log(item);
  item.onclick = function() {
    console.log(this.src);
    console.log(bigimage.src);
    document.getElementById("bigimage").src = this.src;
  }
});