class CharacterLookupView extends Backbone.View
  el: "#lookup_form"
  events:
    'submit': 'doLookup'

  initialize: ->
    @lookup = @options.lookup
    @lookup.on 'lookupSuccess', @onLookupSuccess
    @lookup.on 'lookupFailure', @onLookupFailure

  reveal: =>
    $(@el).slideDown()

  onLookupSuccess: =>
    $(@el).slideUp =>
      @enable()
      @$("#listing_realm").val("")
      @$("#listing_name").val("")

  onLookupFailure: (status) =>
    @enable()
    if status == "timeout"
      alert "Couldn't fetch your character from the Battle.net API. The API may not be working at this time. Please try again in a few minutes."
    else if status == "error"
      alert "Couldn't find your character. Are you sure you spelled your realm and character name correctly?"
    else if status == 'lowlevel'
      alert "You can only add level 85 characters to the LFG list."
    else
      alert "There was an unknown problem fetching your character. Please try again in a few moments."

  doLookup: (evt) =>
    evt.preventDefault()
    realm = @$("#listing_realm").val()
    name  = @$("#listing_name").val()
    @lookup.set 'realm': realm, 'name': name
    if @lookup.isValid()
      @disable()
      @lookup.doLookup()
    else
      alert "Please enter a valid realm and character name."

  disable: (btnText = 'Searching...') =>
    @$("input[type='text']").attr('disabled', true)
    @$("input[type='submit']").attr('disabled', true)
    button = @$("input[type='submit']")
    @origButtonText = button.val()
    button.val(btnText)

  enable: =>
    @$("input[type='text']").attr('disabled', false)
    @$("input[type='submit']").attr('disabled', false)
    button = @$("input[type='submit']")
    button.val(@origButtonText)

module.exports = CharacterLookupView
