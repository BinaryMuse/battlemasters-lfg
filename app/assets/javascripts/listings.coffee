jQuery ->
  $("#add_button").click ->
    $("#step_1").slideDown()
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

  capitalize = (str) ->
    (str.split(' ').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join(' ')

  startCharacterFind = (char) ->
    xhr = $.getJSON "http://us.battle.net/api/wow/character/#{char.realm}/#{char.character}?fields=talents,stats,pvp&jsonp=?", (data) ->
      $("#step_1").slideUp()
      console.log data
      gender = data.gender
      klass  = data.class
      race   = data.race
      main_spec =
        name: data.talents[0].name
        icon: data.talents[0].icon
      # alert "Found #{data.name} from #{data.realm}, the #{capitalize wow.races[data.race]} #{capitalize wow.classes[data.class]}"
      form = $("#new_listing")
      form.find("#listing_realm").val(data.realm)
      form.find("#listing_character").val(data.name)
      form.find("#listing_irc_name").val(char.irc)
      form.find("#listing_race").val(data.race)
      form.find("#listing_gender").val(data.gender)
      form.find("#listing_character_class").val(data.class)
      form.find("#listing_character_class").trigger('change')
      form.find("#listing_main_spec").val(data.talents[0].name)
      form.find("#listing_off_spec").val(data.talents[1].name)
      form.find("#listing_rating").val(data.pvp.ratedBattlegrounds.personalRating)
      form.find("#listing_resilience").val(data.stats.resil)
      $("#add_button").slideUp()
      form.slideDown()


  $("#step_1").submit (evt) ->
    $(this).find("[type='submit']").val("Fetching...")
    $(this).find('input').attr('disabled', true)
    startCharacterFind
      realm: $("#step_1_realm").val()
      character: $("#step_1_character").val()
      irc: $("#step_1_irc_name").val()
    evt.preventDefault()
