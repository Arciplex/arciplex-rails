ready = ->
    $body = $('body')
    $window = $(window)
    $windowsize = $(window).width()

    $window.resize ->
        $windowsize = $(window).width()

    console.log($windowsize)

    if $body.is '.home' and $windowsize > 992
        skrollr.init
            forceHeight: true
            smoothScrolling: true

        $('#down-arrow').on 'click', (e) ->
            e.preventDefault()

            $('html, body').animate
                scrollTop: $('#home2').offset().top
            , 700

        $('.slideTo a').on 'click', (e) ->
            e.preventDefault()

            href = $(this).attr 'href'
            elem = $(href)
            top = elem.offset().top

            $('html, body').animate
                scrollTop: top
            , 700

        $('.icon').hover ->
            content = $(this).attr('data-id').replace('#', '').toUpperCase()
            $(this).addClass('transition')
            $(this).attr('data-content', content)
        , ->
            $(this).removeClass('transition')
            $(this).attr('data-content', '');
        .on 'click', (e) ->
            e.preventDefault()

            id = $(this).attr('data-id')
            top = $("#{id}").offset().top

            $('html, body').animate
                scrollTop: top
            , 700

        $(window).on 'scroll', (e) ->
            speed = 8.0
            xOffset = Math.round(-window.pageXOffset)
            yOffset = Math.round(-window.pageYOffset)

            $('#about-us').find('.bg').animate
                backgroundPosition:  "#{(xOffset / speed)}px #{(yOffset / speed)}px"


$(document).ready ready
$(document).on 'page:load', ready
