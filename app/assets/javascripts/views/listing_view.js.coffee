class ListingView extends Backbone.View
  tagName: "tr"

  initialize: ->
    @template = _.template $("#listing_row").html()
    @model.on 'change:time_in_list', @changeTimeInList
    @model.on 'filter:show', @show
    @model.on 'filter:hide', @hide
    @model.on 'change', @render

  render: =>
    json = @model.toJSON()
    json.time_in_list = Math.floor(json.time_in_list / 60)
    $(@el).html @template(json)
    this

  changeTimeInList: (model, value) =>
    # value is in minutes
    minutes = Math.floor(value / 60)
    @$(".time").text(minutes + " min")

  show: =>
    $(@el).show()

  hide: =>
    $(@el).hide()

  remove: =>
    $(@el).remove()

module.exports = ListingView
