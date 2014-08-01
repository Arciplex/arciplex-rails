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

    $('form[id*="edit_service_request"] #submit_sr_btn').on 'click', (event)->
      event.preventDefault()
      that = $(@)
      form = that.parents('form:first')
      $.confirm
        text: "Would you like to update this Service Request?"
        confirm: (btn)->
          form = that.parents('form:first')
          form.submit()

    if $body.is '.educator'
      $('select[id*="item_type"]').on 'change', ->
        $selected = $(this).find(':selected').text()

        if $selected is "Control Box"
          $('#additional-info').toggleClass 'hide'
        else
          $('#additional-info').toggleClass 'hide'


$(document).ready(ready)
$(document).on('page:load', ready)
