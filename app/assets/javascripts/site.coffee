jQuery ->
  hideFlash = ->
    $(".flash").slideUp()
  setTimeout hideFlash, 5000

  $("[data-tooltip]").each (index, el) ->
    mouseover = (evt) ->
      windowWidth = $(window).width()
      windowMid   = windowWidth / 2
      left = evt.pageX
      top  = evt.pageY - $(window).scrollTop() + 5
      el = $("<span>").addClass("tooltip").text($(this).data('tooltip'))
      el.css({'position': 'absolute', 'top': top})
      if left < windowMid
        el.css('left': left + 5)
      else
        el.css('right': windowWidth - left + 5)
      $(this).data 'tooltip-el', el
      el.appendTo('body').show()
    mouseout = ->
      $(this).data('tooltip-el').remove()
    $(el).hover mouseover, mouseout

  $("[data-rollover]").each (index, el) ->
    mouseover = ->
      $(this).data 'orig-src', $(this).attr('src')
      $(this).attr 'src', $(this).data('rollover')
    mouseout = ->
      $(this).attr 'src', $(this).data('orig-src')
    $(el).hover mouseover, mouseout
