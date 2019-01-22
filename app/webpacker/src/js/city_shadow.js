//$(document).ready('')
$(document).on('turbolinks:load', cityShadow );
$(document).ready(cityShadow)

function cityShadow(){
  console.log('goingon')
  $city_wrapper = $('.city-image-wrapper')

  function calculateTop(){
    object_height = $city_wrapper.outerHeight()
    original_height = 430
    ratio = 1920
    finalHeight = 535
    //if (window.innerWidth >= 1140) {
      finalHeight = (original_height * window.innerWidth / 1920) + object_height
    //}
    console.log(finalHeight)
    return finalHeight
  }

  function calculateShadow(mousePosX) {
    innerWidth = window.innerWidth
    centerPoint = innerWidth / 2
    threshold = innerWidth - 200
    condition = mousePosX <= threshold+centerPoint && mousePosX >= centerPoint-threshold
    factor = mousePosX - centerPoint
    transformFormula = 'skew('+.01 * factor+'deg, 0deg) translateX('+(-0.028*factor)+'px)'

    if (condition) {
      $city_wrapper.find('.shadow').css({
        transform: transformFormula
      })
    }
  }


  $city_wrapper.css({top: calculateTop() })

  $(window).resize(function(){
    console.log('resizando')
    $city_wrapper.css({top: calculateTop() })
  })

  $(window).mousemove(function(event){
    calculateShadow(event.pageX)
  })

}
