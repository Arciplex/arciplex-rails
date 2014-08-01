add_more_template = ->
  $('#blank_template').html()

ready = ->
  $body = $('body')
  if $body.is '.service_requests, .orders'

    $('.add_more').on 'click', (event)->
      new_object_id = new Date().getTime()
      html = add_more_template().replace /index_to_replace_with_js/g, new_object_id
      $('#nested_items').append '<div class="new_item" id="' + new_object_id + '">' + html + '</div>'

      $("##{new_object_id}").find('.remove-line-item').removeClass('hide').attr('data-object-id', new_object_id)

      $('.new_item select').selectpicker('render')
      event.preventDefault()

    $('#nested_items').on 'click', '.new_item .remove-line-item', (event)->
      event.preventDefault()

      id = $(this).attr('data-object-id')
      console.log id
      $("##{id}").remove()

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
      $('form').on 'change', 'select[id*="item_type"]', ->
        $selected = $(this).find(':selected').text()

        if $selected is "Control Box"
          $(this).parents('.form-group').nextAll('.additional-info')
            .toggleClass('hide')
        else
          $(this).next('.additional-info').toggleClass 'hide'


$(document).ready(ready)
$(document).on('page:load', ready)
