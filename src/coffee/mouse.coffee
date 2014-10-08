class MouseHelper
    isMouseExist: ->
        cc.sys.capabilities.hasOwnProperty 'mouse'
    addMouseListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.MOUSE
            onMouseDown: (event) ->
                cc.log "Left mouse button pressed at #{event.getLocationX()}" if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
            onMouseUp: (event) ->
                cc.log "Left mouse button released at #{event.getLocationX()}" if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
        , @
    onLeftMouseDown: ->
        #TODO (S.Panfilov)
    onLeftMouseUp: ->
        #TODO (S.Panfilov)
    onMouseScroll: ->
        #TODO (S.Panfilov)
    onLeftMouseClicked: ->
        #TODO (S.Panfilov)
    onLeftMouseDoubleClicked: ->
        #TODO (S.Panfilov)