class exports.Clock
  constructor: (@serverTime) ->
    @jsTime = new Date().getTime() / 1000
    @secondsAhead = @jsTime - @serverTime

  getServerTime: (@clientTime) =>
    new Date(@clientTime.getTime() - @secondsAhead)
