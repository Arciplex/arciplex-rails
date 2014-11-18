ready = ->
    $body = $('body')

    if $body.is '.home'
        $(".brochure-container").onepage_scroll
            sectionContainer: 'section'
            easing: 'ease'
            animationTime: 1000
            pagination: false
            updateURL: false
            loop: false

        $("li.dropdown ul li a").on 'click', (e)->
            e.preventDefault()
            section = $(this).attr('href')
            index = $(section).data('index')

            $('.brochure-container').moveTo index


$(document).ready ready
$(document).on 'page:load', ready
