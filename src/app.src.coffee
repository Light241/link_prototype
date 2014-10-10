#TODO (S.Panfilov) may be instead of @ at addListener func, we should set sprite
class AccelerometerHelper
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
class DisplayHelper
    RESOLUTIONS:
        iPadRetina:
            large: 2048
            small: 1536
        iPad:
            large: 1024
            small: 768
        iPhoneSixPlus:
            large: 2208
            small: 1242
        iPhoneSix:
            large: 1334
            small: 750
        iPhoneFive:
            large: 1136
            small: 640
    isNative: cc.sys.isNative
    getDisplayWidth: ->
        cc.view.getFrameSize().width
    getDisplayHeight: ->
        cc.view.getFrameSize().height
    isResolution: (width, height) ->
        (@width is width) and (@height is height)
    isIPadRetina: ->
        isPortrait = @isResolution @RESOLUTIONS.iPadRetina.large @RESOLUTIONS.iPadRetina.small
        isLandscape = @isResolution @RESOLUTIONS.iPadRetina.small @RESOLUTIONS.iPadRetina.large
        (isPortrait or isLandscape) and @isNative
    isIPad: ->
        isPortrait = @isResolution @RESOLUTIONS.iPad.large @RESOLUTIONS.iPad.small
        isLandscape = @isResolution @RESOLUTIONS.iPad.small @RESOLUTIONS.iPad.large
        (isPortrait or isLandscape) and @isNative
    isIPhoneSixPlus: ->
        isPortrait = @isResolution @RESOLUTIONS.iPhoneSixPlus.large @RESOLUTIONS.iPhoneSixPlus.small
        isLandscape = @isResolution @RESOLUTIONS.iPhoneSixPlus.small @RESOLUTIONS.iPhoneSixPlus.large
        (isPortrait or isLandscape) and @isNative
    isIPhoneSix: ->
        isPortrait = @isResolution @RESOLUTIONS.iPhoneSix.large @RESOLUTIONS.iPhoneSix.small
        isLandscape = @isResolution @RESOLUTIONS.iPhoneSix.small @RESOLUTIONS.iPhoneSix.large
        (isPortrait or isLandscape) and @isNative
    isIPhoneFive: ->
        isPortrait = @isResolution @RESOLUTIONS.iPhoneFive.large @RESOLUTIONS.iPhoneFive.small
        isLandscape = @isResolution @RESOLUTIONS.iPhoneFive.small @RESOLUTIONS.iPhoneFive.large
        (isPortrait or isLandscape) and @isNative
    isLandscape: ->
        #TODO (S.Panfilov)
    isPortrait: ->
        !@isLandscape()
class EventsUtils
    #TODO (S.Panfilov) the idea is to push listeners here when create it (in utils, helpers, etc.)
    listeners: []
    addListener: (listenerConfig, nodeOrPriority) ->
        cc.eventManager.addListener listenerConfig, nodeOrPriority
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
class HexUtils

    _drawHex = (drawNode, hex) ->
        drawNode.drawPoly hex.corners, cc.color(255, 255, 255), 1, cc.color(0, 0, 255)
        drawNode

    hexes: {}
    hexesConfig:
        type: 'Pointy topped'
        coordinateSystem: 'Axial'
        startFrom: 'Left-top'
        cornersCount: 6
    setHexesConfig: (size) ->
        @hexesConfig.hexSize = size
        @hexesConfig.hexHeight = size * 2
        @hexesConfig.hexWidth = Math.sqrt(3) / 2 * @hexesConfig.hexHeight
        @hexesConfig.horizontalDistance = @hexesConfig.hexWidth
    convertCubeToAxial: (x, z) ->
        q: x
        r: z
    convertAxialToCube: (q, r) ->
        x: q
        z: r
        y: (-x) - z
    calculateHex: (centerX, centerY) ->
        hex =
            centerX: centerX
            centerY: centerY
            corners: []

        for i in [0...@hexesConfig.cornersCount]
            angle = 2 * Math.PI / @hexesConfig.cornersCount * (i + 0.5)
            hex.corners.push
                x: centerX + @hexesConfig.hexSize * Math.cos angle
                y: centerY + @hexesConfig.hexSize * Math.sin angle
        hex
    generateHexesGrid: (centerX, centerY, widthHexCount, heightHexCount) ->
        @hexes = []
        hexesCount = widthHexCount * heightHexCount
        for i in [0...hexesCount]
            hex = {}
            offset = @getOffsetForHex centerX, centerY, widthHexCount, heightHexCount, i
            hex = @calculateHex offset.x, offset.y
            axial = @getAxialCoords widthHexCount, heightHexCount, i
            hex.q = axial.q
            hex.r = axial.r
            hex.id = ObjectsUtils::getCustomPostfixId "#{hex.q}-#{hex.r}"
            hex.alias = "HEX_#{hex.q}-#{hex.r}"
            @hexes[hex.alias] = hex
        @hexes
    getOffsetForHex: (centerX, centerY, widthHexCount, heightHexCount, hexNumber) ->
        distance = @hexesConfig.horizontalDistance
        result = {}
        if hexNumber is 0
            result.x = centerX
            result.y = centerY
        else if hexNumber < widthHexCount
            result.x = centerX + (distance * hexNumber)
            result.y = centerY
        else if hexNumber is widthHexCount
            result.x = centerX + (distance / 2)
            result.y = centerY - distance
        else if hexNumber > widthHexCount
            r = hexNumber % widthHexCount
            result.x = centerX + ((distance / 2) * hexNumber)
            result.y = centerY - (distance * r)
        result
    getAxialCoords: (widthHexCount, heightHexCount, hexNumber) ->
        result = {}
        if hexNumber is 0
            result.q = 0
            result.r = 0
        else if hexNumber < widthHexCount
            result.q = hexNumber
            result.r = 0
        else if hexNumber is widthHexCount
            result.q = 0
            result.r = 1
        else if hexNumber > widthHexCount
            r = hexNumber % widthHexCount
            result.q = hexNumber - (r * widthHexCount)
            result.r = r
        result
    drawHex: (centerX, centerY) ->
        drawNode = new cc.DrawNode
        _drawHex drawNode, @calculateHex centerX, centerY

    drawHexesGrid: (hexes) ->
        hexes = hexes || @hexes
        drawNode = new cc.DrawNode
        for k of hexes
            _drawHex drawNode, hexes[k] if hexes.hasOwnProperty k
        return drawNode
    drawHexesGridNumbers: (hexes, node, zOrder) ->
        hexes = hexes || @hexes
        for k of hexes
            if hexes.hasOwnProperty k
                hexLabel = new cc.LabelTTF("#{hexes[k].q}, #{hexes[k].r}", "Arial", 10)
                hexLabel.setColor(cc.color(0, 0, 255));
                hexLabel.x = hexes[k].centerX
                hexLabel.y = hexes[k].centerY
                node.addChild hexLabel, zOrder

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
'use strict' #do not remove (never!)

BackgroundLayer = cc.Layer.extend
    ctor: ->
        @_super()
        @init()

    init: ->
        @_super()

        size = cc.winSize
        @maxWidth = cc.director.getWinSizeInPixels().width
        @maxHeight = cc.director.getWinSizeInPixels().height

        helloLabel = new cc.LabelTTF("Hello Worlds", "Arial", 38)
        helloLabel.x = size.width / 2
        helloLabel.y = 100
        @addChild helloLabel, 5

        hexSizePx = 35
        HexUtils::setHexesConfig hexSizePx
        MouseHelper::onLeftMouse @, (x, y) =>
            polyNode = HexUtils::drawHex x, y
            @addChild polyNode, 5

        hexesInRow = 2
        hexesInCol = 2
        MouseHelper::onRightMouse @, (x, y) =>
            hexesGrid = HexUtils::generateHexesGrid x, y, hexesInRow, hexesInCol
            polyNode =  HexUtils::drawHexesGrid hexesGrid
            @addChild polyNode, 5
            HexUtils::drawHexesGridNumbers hexesGrid, @, 6

        @scheduleUpdate()
    update: ->
        #update called every frame after @scheduleUpdate called

StartupScene = cc.Scene.extend onEnter: ->
    @_super()
    @addChild new BackgroundLayer()
    return
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
class ObjectsUtils
    getS4: ->
        Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
    getRandomId: ->
        "#{@getS4()}#{@getS4()}-#{@getS4()}-#{@getS4()}-#{@getS4()}-#{@getS4()}#{@getS4()}#{@getS4()}"
    getCustomPostfixId: (postfix)->
        "#{@getRandomId()}_#{postfix}"
res =
    sprite_png: "res/sprite.png"
    sprite_plist: "res/sprite.plist"
    running_png: "res/running.png"
    running_plist: "res/running.plist"
    demo_lvl_bg_png: "res/tiles/demo_lvl_bg.png"
    demo_lvl_bg_tmx: "res/tiles/demo_lvl_bg.tmx"

g_resources = []
for i of res
    g_resources.push res[i] if res.hasOwnProperty i
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