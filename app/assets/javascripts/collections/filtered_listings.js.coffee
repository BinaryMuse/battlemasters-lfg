Listing = require 'models/listing'
SortedCollection = require 'backbone/sorted_collection'

class FilteredListings extends SortedCollection
  model: Listing

module.exports = FilteredListings
