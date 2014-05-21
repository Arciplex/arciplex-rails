ready = ->
  $body = $('body')
  if $body.is '.dashboard'
    $('[data-company-id]').on 'click', (e)->
      e.preventDefault()
      $_self = $(@)
      $companyId = $_self.data('company-id')
      $modal = $($_self.attr("href"))
      $links = $('a', $modal)

      $.each $links, ->
        resource = $(@).data('resource')
        $(@).attr('href', "/companies/#{$companyId}/#{resource}")



$(document).ready(ready)
$(document).on('page:load', ready)
