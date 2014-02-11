$ ->
  $('select').each ->
    $(this).selectpicker() unless $(this).parents('#blank_template').length
  