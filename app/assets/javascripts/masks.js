function addMasks() {
  $('.mask-cpf').mask("999.999.999-99");
  $('.mask-zipcode').mask("99.999-999");
  $('.mask-phone').mask("(99) 99999-9999");
}

// Remove mask on submit
function removeMasks() {
  $('form').submit(function () {
    $('.mask-cpf').mask("99999999999");
    $('.mask-zipcode').mask("99999999");
    $('.mask-phone').mask("99999999999");
  });
}

addMasks();
removeMasks();
