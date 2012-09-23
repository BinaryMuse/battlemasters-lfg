Wow = require 'wow'

class Lookup extends Backbone.Model
  validate: (attrs) ->
    unless attrs.realm? && attrs.realm != ""
      return "Need a valid realm"
    unless attrs.name? && attrs.name != ""
      return "Need a valid name"

  doLookup: =>
    url = "http://us.battle.net/api/wow/character/#{@get('realm')}/#{@get('name')}?fields=talents,stats,pvp,achievements,items&jsonp=?"
    $.jsonp
      context: this
      cache: false
      url: url
      error: (xOptions, textStatus) ->
        @trigger 'lookupFailure', textStatus
      success: (json, textStatus) ->
        if json.level < 85
          @trigger 'lookupFailure', 'lowlevel'
        else
          @trigger 'lookupSuccess', json
      timeout: 5000

  calculateRank: (data) =>
    highestRankIndex = null
    highestRankString = ""

    for achId, index in Wow.alliance_titles_progression
      if _.include(data.achievements.achievementsCompleted, achId)
        if highestRankIndex == null || index > highestRankIndex
          highestRankIndex = index
          highestRankString = Wow.alliance_titles[achId]

    for achId, index in Wow.horde_titles_progression
      if _.include(data.achievements.achievementsCompleted, achId)
        if highestRankIndex == null || index > highestRankIndex
          highestRankIndex = index
          highestRankString = Wow.horde_titles[achId]

    return highestRankString

module.exports = Lookup
