window.app ?= {}

class app.Listing extends Backbone.Model
  defaults:
    time_in_list: ''

  initialize: ->
    @updateListTime()

  updateListTime: =>
    clientTime  = new Date()
    serverTime  = window.application.clock.getServerTime(clientTime)
    started     = new Date(@get('updated_at'))
    diff        = serverTime.getTime() - started.getTime()
    diffSeconds = diff / 1000
    diffMinutes = Math.floor diffSeconds / 60
    value       = diffMinutes
    @set 'time_in_list', value, silent: true
    @trigger 'change:time_in_list', this, value
