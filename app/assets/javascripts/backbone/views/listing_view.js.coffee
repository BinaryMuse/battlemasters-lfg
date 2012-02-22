window.app ?= {}

class app.ListingView extends Backbone.View
  tagName: "tr"

  initialize: ->
    @template = _.template $("#listing_row").html()
    @model.on 'change', @render

  render: =>
    $(@el).html @template(@model.toJSON())
    this

  remove: =>
    $(@el).remove()
