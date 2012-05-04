ListingView = require('views/listing_view')

class ListingsView extends Backbone.View
  el: "#listing_table"
  events:
    'click th': 'sort'
    'click th': 'sort'

  initialize: ->
    @app = @options.app
    @collection.on 'reset', @render
    @collection.on 'add', @addListing
    @collection.on 'remove', @removeListing
    # Super ugly hack
    @collection.sortByColumn 'time_in_list'
    @collection.sortByColumn 'time_in_list'

  render: =>
    $(@el).show()
    @$("tbody tr:not(.empty)").remove()
    _.each @collection.models, (model) =>
      @addListing model, false
    @updatePlaceholder()

  updatePlaceholder: =>
    if @collection.models.length == 0
      @$(".empty").show()
    else
      @$(".empty").hide()

  addListing: (model, resort = true) =>
    console.log 'adding a listing'
    view = new ListingView(model: model)
    model.view = view
    @$("tbody").append view.render().el
    @updatePlaceholder()
    @collection.sort() if @collection.comparator && resort

  removeListing: (model) =>
    model.view.remove()
    @updatePlaceholder()

  sort: (evt) =>
    target = $(evt.target)
    unless target.data('sort')?
      target = target.parents('th')
    sortBy = $(target).data('sort')
    @collection.sortByColumn sortBy if sortBy?

module.exports = ListingsView
