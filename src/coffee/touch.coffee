'use strict'

TouchHelper = ->
    isTouchesExist: ->
        cc.sys.capabilities.hasOwnProperty 'touches'
    addOneTouchListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.TOUCH_ONE_BY_ONE
            onTouchBegan: (touch, event) ->
                target = event.getCurrentTarget()
                locationInNode = target.convertToNodeSpace touch.getLocation()
                size = target.getContentSize()

                cc.log "Touch began at #{touch.getLocationX()}, target: #{target}, locationInNode: #{locationInNode}, size: #{size}"
            onTouchMoved: (touch, event) ->
                cc.log "Touch moved #{touch.getLocationX()}"
            onTouchEnded: (touch, ended) ->
                cc.log "Touch Began #{touch.getLocationX()}"
            onTouchCancelled: (touch, event) ->
                cc.log "Touch cancelled #{touch.getLocationX()}"
        , @
    addMultyTouchListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.TOUCH_ALL_AT_ONCE
            onTouchesBegan: (touches, event) ->
                cc.log "Touches began #{touches[0].getLocationX()}"
                cc.log "Touches began #{touches[1].getLocationX()}"
            onTouchesMoved: (touches, event) ->
                cc.log "Touches moved #{touches[2].getLocationX()}"
        , @