function addMasks() {
  $('.mask-cpf').mask("999.999.999-99");
}

// Remove mask on submit
function removeMasks() {
  $('form').submit(function () {
    $('.mask-cpf').mask("99999999999");
  });
}

addMasks();
removeMasks();
