setupSelects = ->
  $('select').each ->
    $(this).selectpicker() unless $(this).parents('#blank_template').length

ready = ->
  setupSelects()

  $(document).on 'fields_added.nested_form_fields', ->
    setupSelects()

$(document).ready(ready)
$(document).on('page:load', ready)
