add_more_template = ->
  $('#blank_template').html()

ready = ->
  $body = $('body')
  if $body.is '.service_requests, .orders'

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
