jQuery ->
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

  $("#add_button").click ->
    $("#new_listing").slideDown()
    check_values = ->
      realm = $("input#add_realm").val()
      char = $("input#add_character").val()
      if realm? && realm != "" && char? && char != ""
        alert "done"
    $("form#add input#add_realm").change check_values
    $("form#add input#add_character").change check_values

  window.original_spec_options = $("#listing_main_spec").html()
  filter_spec_lists = ->
    id = $("#listing_character_class").val()
    options = $(original_spec_options).filter("option[data-class='#{id}']")
    $("#listing_main_spec").empty().append(options)
    $("#listing_off_spec").empty().append(options.clone())

  $("#listing_character_class").change (evt) ->
    filter_spec_lists()
  filter_spec_lists()
