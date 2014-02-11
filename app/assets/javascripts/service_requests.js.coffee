$ ->
  if $('body').hasClass 'service_requests'
    template = $('#blank_template').html()
    
    $('.add_more').on 'click', (event)->
      new_object_id = new Date().getTime()
      html = template.replace /index_to_replace_with_js/g, new_object_id
      $('#nested_items').append '<div class="new_item">' + html + '</div>'
      $('.new_item select').selectpicker()
      event.preventDefault()