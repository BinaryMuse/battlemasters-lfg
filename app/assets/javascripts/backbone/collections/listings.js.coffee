window.app ?= {}

class app.Listings extends Backbone.Collection
  url: '/listings'
  model: app.Listing

  updateListTime: =>
    modelsToRemove = []
    for model in @models
      model.updateListTime()
      if model.get('time_in_list') > 60
        modelsToRemove.push model

    for model in modelsToRemove
      @remove model
