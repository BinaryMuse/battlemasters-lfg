class MainRouter extends Backbone.Router
  initialize: (options) ->
    @app = options.app

  routes:
    '': 'main'

  main: =>
    @app.bus.trigger 'main'

module.exports = MainRouter
