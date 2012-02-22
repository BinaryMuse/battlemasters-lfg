window.app ?= {}

class app.Listings extends Backbone.Collection
  url: '/listings'
  model: app.Listing
