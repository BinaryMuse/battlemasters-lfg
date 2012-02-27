class Listing extends Backbone.Model
  urlRoot: '/listings'
  defaults:
    time_in_list: 0

  incrementTimeInList: (seconds) =>
    time = @get('time_in_list') + seconds
    @set 'time_in_list', time, silent: true
    @trigger 'change:time_in_list', this, time

module.exports = Listing
