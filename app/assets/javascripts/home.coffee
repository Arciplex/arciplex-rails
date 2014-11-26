ready = ->
    $body = $('body')

    if $body.is '.home'
        skrollr.init
            forceHeight: true
            smoothScrolling: true

        $('#down-arrow').on 'click', (e) ->
            e.preventDefault()

            $('html, body').animate
                scrollTop: $('#home2').offset().top
            , 700

$(document).ready ready
$(document).on 'page:load', ready
