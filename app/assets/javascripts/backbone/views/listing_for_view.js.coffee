window.app ?= {}

class app.ListingFormView extends Backbone.View
  el: "#new_listing_form"
  events:
    'submit': 'submit'

  initialize: ->
    @model.on 'lookupSuccess', @populateForm

  populateForm: (data) =>
    $(@el).slideDown()
    @$("#listing_realm").val(data.realm)
    @$("#listing_character").val(data.name)
    @$("#listing_race").val(data.race)
    @$("#display_race").text(@capitalize window.wow.races[data.race])
    @$("#listing_gender").val(data.gender)
    @$("#listing_character_class").val(data.class)
    @$("#display_character_class").text(@capitalize window.wow.classes[data.class])
    @filterSpec(data.class)
    @$("#listing_main_spec").val(data.talents[0].name)
    @$("#listing_off_spec").val(data.talents[1].name)
    @$("#listing_rating").val(data.pvp.ratedBattlegrounds.personalRating)
    @$("#listing_resilience").val(data.stats.resil)
    @$("#display_rating").text(data.pvp.ratedBattlegrounds.personalRating)
    @$("#display_resilience").text(data.stats.resil)
    rank = @model.calculateRank(data)
    @$("#listing_rank").val(rank)
    @$("#display_rank").text(rank)

  filterSpec: (klass) =>
    selects = @$("#listing_main_spec, #listing_off_spec")
    selects.empty()
    for spec, icon of wow.specs[klass]
      option = $("<option>").val(spec).text(spec)
      selects.append option

  submit: (evt) =>
    evt.preventDefault()
    creation = {}
    fields = [
      "realm", "character", "gender", "race", "character_class", "main_spec",
      "off_spec", "rating", "rank", "resilience", "notes", "irc_name"
    ]
    for field in fields
      creation[field] = @$("#listing_#{field}").val()
    newListing = new app.Listing
    newListing.save creation, {
      success: (model, response) =>
        model.updateListTime()
        @collection.add model
        @collection.sort() if @collection.comparator?
        @hide()
      error: (model, response) =>
        alert response.responseText
    }

  hide: =>
    @trigger 'added'
    $(@el).slideUp =>
      @reset()

  reset: =>
    @$("#listing_irc_name").val("")
    @$("#listing_notes").val("")

  capitalize: (str) ->
    (str.split(' ').map (word) -> word[0].toUpperCase() + word[1..-1].toLowerCase()).join(' ')
