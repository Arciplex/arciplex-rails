ready = ->
    $body = $('body')

    if $body.is '.home'
        scrollContainer = $(".brochure-container")
        scrollContainer.onepage_scroll
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

            scrollContainer.moveTo index

        $("#down-arrow").on 'click', (e)->
            e.preventDefault()
            scrollContainer.moveTo 2


$(document).ready ready
$(document).on 'page:load', ready
