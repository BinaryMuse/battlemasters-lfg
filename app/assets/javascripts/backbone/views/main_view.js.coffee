window.app ?= {}

class app.MainView extends Backbone.View
  initialize: ->
    @app = @options.app
    @app.bus.on 'firstView', @firstView
    @app.bus.on 'main', @resetView

    @listingsView = new app.ListingsView(collection: @collection)

  resetView: =>
    #TODO: Hide forms, etc.
