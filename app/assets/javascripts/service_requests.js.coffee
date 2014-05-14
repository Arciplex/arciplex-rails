add_more_template = ->
  $('#blank_template').html()

ready = ->
  $body = $('body')
  if $body.is '.service_requests, .orders'
    $('.add_more').on 'click', (event)->
      new_object_id = new Date().getTime()
      html = add_more_template().replace /index_to_replace_with_js/g, new_object_id
      $('#nested_items').append '<div class="new_item">' + html + '</div>'
      $('.new_item select').selectpicker()
      event.preventDefault()

$(document).ready(ready)
$(document).on('page:load', ready)
