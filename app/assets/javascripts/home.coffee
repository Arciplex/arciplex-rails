ready = ->
    $body = $('body')

    if $body.is '.home'
        scrollContainer = $(".brochure-container")
        slides = $('.brochure-container .section')
        scrollContainer.fullpage
            menu: false
            navigation: false

        $("li.dropdown ul li a, li.slideTo a").on 'click', (e)->
            e.preventDefault()
            section = $(this).attr('href')
            slide = $(section)

            $.fn.fullpage.moveTo(slides.index(slide)+1)

        $("#down-arrow").on 'click', (e)->
            e.preventDefault()
            $.fn.fullpage.moveTo 2

        $('#about-us').interactive_bg()

$(document).ready ready
$(document).on 'page:load', ready
