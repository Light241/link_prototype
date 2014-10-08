class TouchHelper
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
                target = event.getCurrentTarget();
                delta = touch.getDelta();

                cc.log "Touch moved #{touch.getLocationX()}, target: #{target}, delta: #{delta}"
            onTouchEnded: (touch, ended) ->
                cc.log "Touch ended #{touch.getLocationX()}"
            onTouchCancelled: (touch, event) ->
                cc.log "Touch cancelled #{touch.getLocationX()}"
        , @
    addMultiTouchListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.TOUCH_ALL_AT_ONCE
            onTouchesBegan: (touches, event) ->
                cc.log "Touches began #{touches[0].getLocationX()}"
                cc.log "Touches began #{touches[1].getLocationX()}"
            onTouchesMoved: (touches, event) ->
                cc.log "Touches moved #{touches[2].getLocationX()}"
        , @