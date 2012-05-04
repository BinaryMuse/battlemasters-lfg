class SortedCollection extends Backbone.Collection
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

module.exports = SortedCollection
