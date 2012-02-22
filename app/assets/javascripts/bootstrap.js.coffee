_.templateSettings =
  interpolate: /\{\{(.+?)\}\}/g

class EventBus
  constructor: ->
    @events = {}
    _.extend(@events, Backbone.Events)

  on: (args...) =>
    @events.on args...

  off: (args...) =>
    @events.off args...

  trigger: (args...) =>
    @events.trigger args...

class Application
  constructor: ->
    @bus        = new EventBus

    @mainRouter = new app.MainRouter(app: this)
    @listings   = new app.Listings
    @mainView   = new app.MainView(app: this, collection: @listings)
    @firstView = false

  start: =>
    @listings.reset window.preloadListings
    Backbone.history.start(silent: false)

jQuery ->
  window.application = new Application
  window.application.start()
