ready = ->
    $body = $('body')

    if $body.is '.home'
        skrollr.init
            forceHeight: true
            smoothScrolling: true

$(document).ready ready
$(document).on 'page:load', ready
