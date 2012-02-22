window.app ?= {}

class app.ListingsView extends Backbone.View
  el: "#listing_table"

  initialize: ->
    @collection.on 'reset', @render
    @collection.on 'add', @addListing
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
    view = new app.ListingView(model: model)
    model.view = view
    @$("tbody").append view.render().el
    @updatePlaceholder()

  removeListing: (model) =>
    model.view.remove()
    @updatePlaceholder()
