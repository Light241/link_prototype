#TODO (S.Panfilov) may be instead of @ at addListener func, we should set target (some kind of input elem or smt)
class KeyboardHelper
    isKeyboardExist: ->
        cc.sys.capabilities.hasOwnProperty 'keyboard'
    getCurrentTarget: (event) ->
        event.getCurrentTarget();
    addKeyboardListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.KEYBOARD
            onKeyPressed: (keyCode, event) ->
                label = event.getCurrentTarget();
                label.setString "Key #{keyCode.toString()} was pressed!"
            onKeyReleased: (keyCode, event) ->
                label = event.getCurrentTarget();
                label.setString "Key #{keyCode.toString()} was relesed!"
        , @