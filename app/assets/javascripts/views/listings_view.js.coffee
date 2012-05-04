ListingView = require('views/listing_view')

class ListingsView extends Backbone.View
  el: "#listing_table"
  events:
    'click th': 'sort'
    'click th': 'sort'

  initialize: ->
    @app = @options.app
    @collection.on 'reset', @render
    @collection.on 'add', => @collection.sort()
    @collection.on 'remove', @removeListing

  render: =>
    $(@el).show()
    @$("tbody tr:not(.empty)").remove()
    _.each @collection.models, (model) =>
      @addListing model
    @updatePlaceholder()

  updatePlaceholder: =>
    if @collection.models.length == 0
      @$(".empty").show()
    else
      @$(".empty").hide()

  addListing: (model) =>
    view = new ListingView(model: model)
    model.view = view
    @$("tbody").append view.render().el
    @updatePlaceholder()

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
