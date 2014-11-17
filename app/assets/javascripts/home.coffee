ready = ->
    $body = $('body')

    if $body.is '.home'
        controller = new ScrollMagic({globalSceneOptions: {triggerHook: "onEnter", duration: $(window).height()*2}})

        controller.scrollTo (newpos) ->
            TweenMax.to(window, 0.5, {
                scrollTo: {
                    y: newpos
                }
            })

        new ScrollScene({ triggerElement: ".home2" })
        .setTween(TweenMax.from(".home2 > *", 1,
              opacity: 0
              x: -400
        ))
        .triggerHook("onEnter")
        .addTo(controller)

        $('#down-arrow').on 'click', (e)->
            e.preventDefault();
            controller.scrollTo('.home2')


$(document).ready ready
$(document).on 'page:load', ready
