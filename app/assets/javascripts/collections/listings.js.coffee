Listing = require 'models/listing'

class Listings extends Backbone.Collection
  url: '/listings'
  model: Listing

  updateListTime: =>
    modelsToRemove = []
    for model in @models
      model.updateListTime()
      if model.get('time_in_list') > 60
        modelsToRemove.push model

    for model in modelsToRemove
      @remove model

  sortByColumn: (col) =>
    @comparator = (model) =>
      model.get(col)
    @sort()

module.exports = Listings
