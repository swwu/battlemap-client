_ = require("underscore")
$ = require("jquery")

drip = require("drip")

class BaseModel

  constructor: ->
    @_emitter = new drip.EventEmitter()

  on: (args...) ->
    @_emitter.on(args...)
  off: (args...) ->
    @_emitter.off(args...)
  emit: (args...) ->
    @_emitter.emit(args...)

  _doFetch: (url, cb) ->
    if @_fetchInProgress
      if cb?
        @_fetchCbs.push(cb)
    else
      @_fetchCbs = []
      if cb?
        @_fetchCbs.push(cb)
      @_fetchInProgress = true

      doResponse = (err, args...) =>
        for fetchCb in @_fetchCbs
          fetchCb(err, args...)
        @_fetchCbs = []
        @_fetchInProgress = false
      $.ajax(
        type: "GET"
        url: url
        dataType: "json"
        success: (args...) =>
          doResponse(null, args...)
        error: (args...) =>
          doResponse(true, args...)
      )

  _doPutDebounced: _.debounce( (url, attrs) ->
    doResponse = (err, args...) =>
      for putCb in @_putCbs
        putCb(err, args...)
      @_putCbs = []
      @_putInProgress = false
    $.ajax(
      type: "PUT"
      url: url
      data: JSON.stringify(attrs)
      dataType: "json"
      contentType: "application/json"
      success: (args...) =>
        doResponse(null, args...)
      error: (args...) =>
        doResponse(true, args...)
    )

  ,500)

  _doPut: (url, attrs, cb) ->
    if @_putInProgress
      if cb?
        @_putCbs.push(cb)
    else
      @_putCbs = []
      if cb?
        @_putCbs.push(cb)
      @_putInProgress = true
    # only the last send goes, with the most recent assigned attributes
    @_doPutDebounced(url, attrs)

module.exports = BaseModel
