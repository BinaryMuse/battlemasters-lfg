class FilterView extends Backbone.View
  el: "#filter"
  events:
    # 'click a': 'showForm'
    'change #filter_faction input': 'filterFaction'

  initialize: ->
    @collection.on 'reset', @showHideFilterLink
    @collection.on 'add', @showHideFilterLink
    @collection.on 'remove', @showHideFilterLink

  showHideFilterLink: =>
    if @collection.models.length
      @showFilterLink()
    else
      @hideFilterLink()

  showFilterLink: =>
    $(@el).slideDown()

  hideFilterLink: =>
    $(@el).slideUp()

  showForm: (evt) =>
    evt.preventDefault()
    @$("form").slideDown()

  filterFaction: (evt) =>
    filter = $(evt.target).val()
    if filter == "both"
      @collection.filterBy(false)
    else
      @collection.filterBy
        faction: filter

module.exports = FilterView
