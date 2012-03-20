class SortedFilteredCollection extends Backbone.Collection
  initialize: ->
    @on 'add', @reapply
    @on 'remove', @reapply
    @on 'reset', @reapply

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
          @compare(data1, data2)
        else
          @compare(data2, data1)
      else
        if @sortDir == "up"
          @compare(data2, data1)
        else
          @compare(data1, data2)
    @sort()

  compare: (val1, val2) ->
    if val1 > val2
      1
    else if val2 > val1
      -1
    else
      0

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

  reapply: =>
    @sort() if @comparator?
    @refilter()

  refilter: =>
    @filterBy()

module.exports = SortedFilteredCollection
