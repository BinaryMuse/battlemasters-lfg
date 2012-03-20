class Listing extends Backbone.Model
  urlRoot: '/listings'
  defaults:
    time_in_list: 0

  initialize: ->
    @setTruncatedName()
    @bind 'change', @setTruncatedName
    @bind 'change:irc_name', @setTruncatedName

  incrementTimeInList: (seconds) =>
    time = @get('time_in_list') + seconds
    @set 'time_in_list', time, silent: true
    @trigger 'change:time_in_list', this, time

  setTruncatedName: (model) =>
    ircName = @get('irc_name')
    return unless ircName?
    if ircName.length > 13
      name = ircName.substring(0, 12) + "..."
      @set('truncated_irc_name': name, {silent: true})
    else
      @set('truncated_irc_name': ircName, {silent: true})

module.exports = Listing
