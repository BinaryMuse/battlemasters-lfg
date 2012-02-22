window.app ?= {}

class app.MainRouter extends Backbone.Router
  initialize: (options) ->
    @app = options.app

  routes:
    '': 'main'

  main: =>
    @app.bus.trigger 'main'
