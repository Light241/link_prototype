class MouseHelper
    isMouseExist: ->
        cc.sys.capabilities.hasOwnProperty 'mouse'
    ###addMouseListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.MOUSE
            onMouseDown: (event) ->
                if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
                    @onLeftMouseDown()
                    cc.log "Left mouse button pressed at #{event.getLocationX()}"
            onMouseUp: (event) ->
                cc.log "Left mouse button released at #{event.getLocationX()}" if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
        , @###
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
    onLeftMouseUp: ->
        #TODO (S.Panfilov)
    onMouseScroll: ->
        #TODO (S.Panfilov)
    onLeftMouseClicked: ->
        #TODO (S.Panfilov)
    onLeftMouseDoubleClicked: ->
        #TODO (S.Panfilov)