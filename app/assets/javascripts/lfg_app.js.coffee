Clock = require 'clock'
EventBus = require 'event_bus'
MainRouter = require 'routers/main_router'
Listings = require 'collections/listings'
MainView = require 'views/main_view'

TIME_UPDATE = 10

class LfgApp
  constructor: ->
    @bus        = new EventBus
    @clock      = new Clock(window.rubyTime)

    @mainRouter = new MainRouter(app: this)
    @listings   = new Listings
    @mainView   = new MainView(app: this, collection: @listings)
    @firstView = false

  start: =>
    @listings.reset window.preloadListings
    Backbone.history.start(silent: false)
    setInterval @updateListings, 180 * 1000
    setInterval @updateListTime, TIME_UPDATE * 1000

  updateListings: =>
    listings = new Listings
    listings.fetch
      success: @processListings

  processListings: (listings, response) =>
    existing_ids = _.map @listings.models, (model) ->
      model.get('id')
    new_ids      = _.map listings.models, (model) ->
      model.get('id')
    to_delete = []
    for model in @listings.models
      do (model) =>
        unless _.include new_ids, model.get('id')
          to_delete.push model.get('id')
    for id in to_delete
      @listings.remove @listings.get(id)
    for model in listings.models
      do (model) =>
        unless _.include existing_ids, model.get('id')
          @listings.add model

  updateListTime: =>
    @listings.updateListTime(TIME_UPDATE)

module.exports = LfgApp
