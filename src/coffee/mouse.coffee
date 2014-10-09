class MouseHelper
    isMouseExist: ->
        cc.sys.capabilities.hasOwnProperty 'mouse'
    onLeftMouse: (target, callbackDown, callbackUp) ->
        cc.eventManager.addListener
            event: cc.EventListener.MOUSE
            onMouseDown: (event) ->
                if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
                    callbackDown event.getLocationX(), event.getLocationY() if callbackDown
                    cc.log "Left mouse button pressed at #{event.getLocationX()}"
            onMouseUp: (event) ->
                if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
                    callbackUp event.getLocationX(), event.getLocationY() if callbackUp
                    cc.log "Left mouse button released at #{event.getLocationX()}" if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
        , target
    onRightMouse: (target, callbackDown, callbackUp) ->
        cc.eventManager.addListener
            event: cc.EventListener.MOUSE
            onMouseDown: (event) ->
                if (event.getButton() is cc.EventMouse.BUTTON_RIGHT)
                    callbackDown event.getLocationX(), event.getLocationY() if callbackDown
                    cc.log "Right mouse button pressed at #{event.getLocationX()}"
            onMouseUp: (event) ->
                if (event.getButton() is cc.EventMouse.BUTTON_RIGHT)
                    callbackUp event.getLocationX(), event.getLocationY() if callbackUp
                    cc.log "Right mouse button released at #{event.getLocationX()}" if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
        , target