ready = ->
  $('select').each ->
    $(this).selectpicker() unless $(this).parents('#blank_template').length
    
$(document).ready(ready)
$(document).on('page:load', ready)
  