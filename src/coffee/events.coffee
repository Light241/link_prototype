'use strict'

EventsUtils = ->
    #TODO (S.Panfilov) the idea is to push listeners here when create it (in utils, helpers, etc.)
    listeners: []
    addListener: (listenerConfig) ->
        cc.eventManager.addListener listenerConfig
    removeAllListeners: ->
        cc.eventManager.removeAllListeners()
    removeListener: (listener) ->
        cc.eventManager.removeListener listener
    removeListenersForObject: (object) ->
        cc.eventManager.removeListeners object
    removeListenersByType: (type) ->
        cc.eventManager.removeListeners type
    pause: (layer, isRecursive)->
        cc.eventManager.pauseTarget layer, isRecursive
    resume: (layer, isRecursive)->
        cc.eventManager.resumeTarget layer, isRecursive