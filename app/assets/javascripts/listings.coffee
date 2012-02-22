#   class app.Lookup extends Backbone.Model
#     validate: (attrs) ->
#       unless attrs.realm? && attrs.realm != ""
#         return "Realm cannot be blank."
#       unless attrs.character? && attrs.character != ""
#         return "Character name cannot be blank."
#
#       null
#
#     lookup: =>
#       url = "http://us.battle.net/api/wow/character/#{@get('realm')}/#{@get('character')}?fields=talents,stats,pvp,achievements&jsonp=?"
#       $.jsonp
#         context: this
#         cache: false
#         url: url
#         error: (xOptions, textStatus) ->
#           @trigger 'lookupFailure', textStatus
#         success: (json, textStatus) ->
#           @trigger 'lookupSuccess', json
#         timeout: 5000
#
#   class app.Form extends Backbone.View
#     el: "#add_form"
#     events:
#       'submit #step_1': 'submitStep1'
#
#     initialize: ->
#       @parent = @options.container
#       @parent.on 'showForm', @showStep1
#
#     showStep1: =>
#       @$('#step_1').slideDown()
#
#     hideStep1: =>
#       @$('#step_1').slideUp()
#
#     showNewListing: =>
#       @$('#new_listing').slideDown()
#
#     hideNewListing: =>
#       @$('#new_listing').slideUp()
#
#     submitStep1: (evt) =>
#       evt.preventDefault()
#
#       lookup = new app.Lookup
#         realm: @$('#step_1_realm').val()
#         character: @$('#step_1_character').val()
#
#       if lookup.isValid()
#         lookup.on 'lookupFailure', @lookupFailure
#         lookup.on 'lookupSuccess', @lookupSuccess
#         lookup.lookup()
#         @disableStep1()
#       else
#         alert "Please enter a realm and character name"
#
#     lookupFailure: (status) =>
#       if status == "timeout"
#         alert "Couldn't fetch your character from the Battle.net API. The API may not be working at this time. Please try again in a few minutes."
#       if status == "error"
#         alert "Couldn't find your character. Are you sure you spelled your realm and character name correctly?"
#       @enableStep1()
#
#     lookupSuccess: (data) =>
#       if data.level < 85
#         alert "You must be level 85 to join the list"
#         @enableStep1()
#         return
#
#       @populateAddForm(data)
#       @showNewListing()
#       @hideStep1()
#       $("#add_button").slideUp()
#
#     populateAddForm: (data) =>
#       form = @$("#new_listing")
#       form.find("#listing_realm").val(data.realm)
#       form.find("#listing_character").val(data.name)
#       form.find("#listing_race").val(data.race)
#       form.find("#display_race").text(capitalize window.wow.races[data.race])
#       form.find("#listing_gender").val(data.gender)
#       form.find("#listing_character_class").val(data.class)
#       form.find("#display_character_class").text(capitalize window.wow.classes[data.class])
#       @filterSpec(form, data.class)
#       form.find("#listing_main_spec").val(data.talents[0].name)
#       form.find("#listing_off_spec").val(data.talents[1].name)
#       form.find("#listing_rating").val(data.pvp.ratedBattlegrounds.personalRating)
#       form.find("#listing_resilience").val(data.stats.resil)
#       form.find("#display_rating").text(data.pvp.ratedBattlegrounds.personalRating)
#       form.find("#display_resilience").text(data.stats.resil)
#       console.log '1'
#       rank = @calculateRank(data)
#       console.log '2'
#       form.find("#listing_rank").val(rank)
#       console.log '3'
#       form.find("#display_rank").text(rank)
#       console.log '4'
#
#     filterSpec: (form, klass) =>
#       selects = $("#listing_main_spec, #listing_off_spec")
#       selects.empty()
#       for spec, icon of wow.specs[klass]
#         option = $("<option>").val(spec).text(spec)
#         selects.append option
#
#     calculateRank: (data) ->
#       highestRankIndex = null
#       highestRankString = ""
#
#       console.log data
#       for achId, index in wow.alliance_titles_progression
#         console.log achId
#         if _.include(data.achievements.achievementsCompleted, achId)
#           console.log 'yarp'
#           if highestRankIndex == null || index > highestRankIndex
#             highestRankIndex = index
#             highestRankString = wow.alliance_titles[achId]
#
#       for achId, index in wow.horde_titles_progression
#         console.log achId
#         if _.include(data.achievements.achievementsCompleted, achId)
#           console.log 'yarp2'
#           if highestRankIndex == null || index > highestRankIndex
#             highestRankIndex = index
#             highestRankString = wow.horde_titles[achId]
#
#       return highestRankString
#
#     disableStep1: =>
#       @$('#step_1 input').attr('disabled', true)
#       @$('#step_1 input[type=submit]').val("Fetching...")
#
#     enableStep1: =>
#       @$('#step_1 input').attr('disabled', false)
#       @$('#step_1 input[type=submit]').val("Add My Character")
#
#   class app.AppView extends Backbone.View
#     el: ".container"
#     events:
#       'click #add_button': 'showForm'
#
#     initialize: ->
#       @form = new app.Form(container: this)
#
#     showForm: =>
#       @trigger 'showForm'
