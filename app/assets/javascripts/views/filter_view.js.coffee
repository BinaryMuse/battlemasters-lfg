class FilterView extends Backbone.View
  el: "#filter"
  events:
    'change #filter_faction input': 'filterFaction'

  initialize: ->
    @filteredListings = @options.filteredListings
    @filterBy = false

    @collection.on 'reset', @reset
    @collection.on 'add', @add
    @collection.on 'remove', @remove

  filterFaction: (evt) =>
    filter = $(evt.target).val()
    if filter == "both"
      @filterBy = false
    else
      @filterBy = filter

    @commitFilter()

  reset: (collection) =>
    @commitFilter()

  add: (model) =>
    @filteredListings.add model if @filterBy == model.attributes.faction || @filterBy == false

  remove: (model) =>
    @filteredListings.remove model

  commitFilter: (collection = null) =>
    collection ?= @collection
    if @filterBy == false
      @filteredListings.reset collection.models
    else
      models = _.filter collection.models, (m) => m.attributes.faction == @filterBy
      @filteredListings.reset models

module.exports = FilterView
