class SortedFilteredCollection extends Backbone.Collection
  initialize: ->
    @on 'add', @refilter
    @on 'remove', @refilter
    @on 'reset', @refilter

  sortByColumn: (col) =>
    if col == @sortBy && @sortDir == "down"
      @sortDir = "up"
    else if col == @sortBy
      @sortDir = "down"
    else
      @sortDir = "down"
    @sortBy = col

    @comparator = (model1, model2) =>
      data1 = model1.get(col)
      data2 = model2.get(col)

      if typeof data1 == "number"
        if @sortDir == "up"
          data1 > data2
        else
          data1 < data2
      else
        if @sortDir == "up"
          data1 < data2
        else
          data1 > data2
    @sort()

  filterBy: (data) =>
    if data == false
      'data is false; resetting'
      model.trigger('filter:show') for model in @models
      return

    unless data == undefined
      @filterCriteria = data

    for model in @models
      showModel = true
      for key, value of @filterCriteria
        if model.get(key) != value
          showModel = false
      if showModel
        model.trigger 'filter:show'
      else
        model.trigger 'filter:hide'

  refilter: =>
    console.log 'refiltering'
    @filterBy()

module.exports = SortedFilteredCollection
