Lookup = require 'models/lookup'
CharacterLookupView = require 'views/character_lookup_view'
ListingFormView = require 'views/listing_form_view'
ListingsView = require 'views/listings_view'
FilterView = require 'views/filter_view'
FilteredListings = require 'collections/filtered_listings'

class MainView extends Backbone.View
  el: '.container'
  events:
    'click img#add_button': 'add'

  initialize: ->
    @app = @options.app
    @app.bus.on 'firstView', @firstView
    @app.bus.on 'main', @resetView

    @filteredListings = new FilteredListings

    lookup = new Lookup
    @characterLookupView  = new CharacterLookupView(lookup: lookup)
    listingFormView       = new ListingFormView(model: lookup, collection: @collection)
    filterView = new FilterView(collection: @collection, filteredListings: @filteredListings)
    listingsView = new ListingsView(collection: @filteredListings)

    lookup.on 'lookupSuccess', @hideAddButton
    listingFormView.on 'added', @showAddButton

  add: =>
    @characterLookupView.reveal()

  hideAddButton: =>
    @$("#add_button").slideUp()

  showAddButton: =>
    @$("#add_button").slideDown()

  resetView: =>
    #TODO: Hide forms, etc.

module.exports = MainView
