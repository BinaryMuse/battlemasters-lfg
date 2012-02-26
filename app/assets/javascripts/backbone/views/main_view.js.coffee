window.app ?= {}

class app.MainView extends Backbone.View
  el: '.container'
  events:
    'click img#add_button': 'add'

  initialize: ->
    @app = @options.app
    @app.bus.on 'firstView', @firstView
    @app.bus.on 'main', @resetView

    lookup = new app.Lookup
    @characterLookupView  = new app.CharacterLookupView(lookup: lookup)
    listingFormView       = new app.ListingFormView(model: lookup, collection: @collection)
    listingsView = new app.ListingsView(collection: @collection)

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
