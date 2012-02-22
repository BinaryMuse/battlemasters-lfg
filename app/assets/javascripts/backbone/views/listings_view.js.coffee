window.app ?= {}

class app.ListingsView extends Backbone.View
  el: "#listing_table"

  initialize: ->
    @collection.on 'reset', @render

  render: =>
    $(@el).show()
    @$("tbody tr:not(.empty)").remove()
    _.each @collection.models, (model) ->
      view = new app.ListingView(model: model)
      @$("tbody").append view.render().el
    if @collection.models.length == 0
      @$(".empty").show()
    else
      @$(".empty").hide()
