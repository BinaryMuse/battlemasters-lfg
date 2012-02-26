class FilterView extends Backbone.View
  el: "#filter"
  events:
    'click a': 'showForm'
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
    @collection.filterBy
      faction: $(evt.target).val()

module.exports = FilterView
