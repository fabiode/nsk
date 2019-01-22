//$(document).ready('')

$(document).ready(function(){
  console.log('goingon')
  $city_wrapper = $('.city-image-wrapper')

  function calculateTop(){
    object_height = $city_wrapper.outerHeight()
    original_height = 430
    ratio = 1920
    return (original_height * window.innerWidth / 1920) + object_height
  }

  function calculateShadow(mousePosX) {
    //8deg => -20px
    //
    centerPoint = window.innerWidth / 2
    threshold = 200
    condition = mousePosX <= threshold+centerPoint && mousePosX >= centerPoint-threshold
    factor = mousePosX - centerPoint
    transformFormula = 'skew('+.1 * factor+'deg, 0deg) translateX('+(-0.28*factor)+'px)'

    console.log(condition)
    if (condition) {
      $city_wrapper.find('.shadow').css({
        transform: transformFormula
      })
    }
  }


  $city_wrapper.css({top: calculateTop() })

  $(window).resize(function(){
    $city_wrapper.css({top: calculateTop() })
  })

  $(window).mousemove(function(event){
    calculateShadow(event.pageX)
  })
})
