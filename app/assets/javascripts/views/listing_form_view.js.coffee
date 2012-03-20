Listing = require 'models/listing'
Wow = require 'wow'

class ListingFormView extends Backbone.View
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
    @$("#display_race").text(@capitalize Wow.races[data.race])
    @$("#listing_gender").val(data.gender)
    @$("#listing_character_class").val(data.class)
    @$("#display_character_class").text(@capitalize Wow.classes[data.class])
    @filterSpec(data.class)
    @$("#listing_main_spec").val(data.talents[0].name)
    @$("#listing_off_spec").val(data.talents[1].name)
    @$("#listing_rating").val(data.pvp.ratedBattlegrounds.personalRating)
    @$("#listing_resilience").val(data.stats.resil)
    @$("#listing_item_level").val(data.items.averageItemLevel)
    @$("#display_rating").text(data.pvp.ratedBattlegrounds.personalRating)
    @$("#display_resilience").text(data.stats.resil)
    @$("#display_item_level").text(data.items.averageItemLevel)
    rank = @model.calculateRank(data)
    @$("#listing_rank").val(rank)
    @$("#display_rank").text(rank)

  filterSpec: (klass) =>
    selects = @$("#listing_main_spec, #listing_off_spec")
    selects.empty()
    for spec, icon of Wow.specs[klass]
      option = $("<option>").val(spec).text(spec)
      selects.append option

  submit: (evt) =>
    evt.preventDefault()
    creation = {}
    fields = [
      "realm", "character", "gender", "race", "character_class", "main_spec",
      "off_spec", "rating", "rank", "resilience", "item_level", "notes", "irc_name"
    ]
    for field in fields
      creation[field] = @$("#listing_#{field}").val()
    newListing = new Listing
    newListing.save creation, {
      wait: true
      success: (model, response) =>
        if @collection.get(model.get('id'))?
          oldModel = @collection.get(model.get('id'))
          oldModel.set(model.attributes)
        else
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

module.exports = ListingFormView
