$(document).ready(function(){
  $.fn.extend({
    smoothReplace: function(content){
      this.animate({opacity: 0}, 100)
        .delay(10)
        .html(content)
        .delay(120)
        .animate({opacity: 1}, 100)
    }
  })
})
