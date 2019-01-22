$(document).on('turbolinks:load', applyMasks);
$(document).ready(applyMasks)

function applyMasks() {
  $('[name*=document]').not('.disabled').inputmask('999.999.999-99')
  $('[name*=phone]').inputmask({
    mask: '99 9999[9]-9999',
    greedy: false
  })
}
