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

module.exports = EventBus
