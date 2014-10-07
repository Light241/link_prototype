'use strict'

#TODO (S.Panfilov) may be instead of @ at addListener func, we should set sprite
AccelerometerHelper = ->
    isAccelerometerExist: ->
        cc.sys.capabilities.hasOwnProperty 'accelerometer'
    enabledAccelerometer: ->
        cc.inputManager.setAccelerometerEnabled true
    disabledAccelerometer: ->
        cc.inputManager.setAccelerometerEnabled false
    isAccelerometerEnabled: ->
        cc.Device.isAccelerometerEnabled
    addAccelerometerListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.ACCELERATION
            callback: (acc, event) ->
                cc.log "Accelerometer feel smth!"
        , @