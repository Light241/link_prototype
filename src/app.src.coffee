'use strict'

RESOLUTIONS =
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

DisplayHelper = ->
    isNative: cc.sys.isNative
    searchPaths: jsb.fileUtils.getSearchPaths()
    displayWidth: cc.view.getFrameSize().width
    displayHeight: cc.view.getFrameSize().height
    isResolution: width, height ->
        (@width is width) and (@height is height)
    isIPadRetina: ->
        isPortrait = @isResolution RESOLUTIONS.iPadRetina.large RESOLUTIONS.iPadRetina.small
        isLandscape = @isResolution RESOLUTIONS.iPadRetina.small RESOLUTIONS.iPadRetina.large
        (isPortrait or isLandscape) and @isNative
    iPad: ->
        isPortrait = @isResolution RESOLUTIONS.iPad.large RESOLUTIONS.iPad.small
        isLandscape = @isResolution RESOLUTIONS.iPad.small RESOLUTIONS.iPad.large
        (isPortrait or isLandscape) and @isNative
    iPhoneSixPlus: ->
        isPortrait = @isResolution RESOLUTIONS.iPhoneSixPlus.large RESOLUTIONS.iPhoneSixPlus.small
        isLandscape = @isResolution RESOLUTIONS.iPhoneSixPlus.small RESOLUTIONS.iPhoneSixPlus.large
        (isPortrait or isLandscape) and @isNative
    iPhoneSix: ->
        isPortrait = @isResolution RESOLUTIONS.iPhoneSix.large RESOLUTIONS.iPhoneSix.small
        isLandscape = @isResolution RESOLUTIONS.iPhoneSix.small RESOLUTIONS.iPhoneSix.large
        (isPortrait or isLandscape) and @isNative
    iPhoneFive: ->
        isPortrait = @isResolution RESOLUTIONS.iPhoneFive.large RESOLUTIONS.iPhoneFive.small
        isLandscape = @isResolution RESOLUTIONS.iPhoneFive.small RESOLUTIONS.iPhoneFive.large
        (isPortrait or isLandscape) and @isNative
    isLandscape: ->
        #TODO (S.Panfilov)
    isPortrait: ->
        !@isLandscape()
BackgroundLayer = cc.Layer.extend
    demoLvlMap: null
    map01: null
    mapWidth: 0
    mapIndex: 0
    ctor: ->
        @_super()
        @init()

    init: ->
        @_super()

        @demoLvlMap = cc.TMXTiledMap.create res.demo_lvl_bg_tmx
        @addChild @demoLvlMap
        @mapWidth = @demoLvlMap.getContentSize().width

        @scheduleUpdate();

AnimationLayer = cc.Layer.extend
    spriteSheet: null
    runningAction: null
    sprite: null
    ctor: ->
        @_super()
        @init()

    init: ->
        @_super()

        cc.spriteFrameCache.addSpriteFrames res.running_plist #TODO (S.Panfilov) second arg
        @spriteSheet = cc.SpriteBatchNode.create res.running_png
        @addChild @spriteSheet

        animFrames = []
        for i in [0..7]
            str = "runner" + i + ".png"
            frame = cc.spriteFrameCache.getSpriteFrame str
            animFrames.push frame

        animation = cc.Animation.create animFrames, 0.1
        @runningAction = cc.RepeatForever.create cc.Animate.create animation
        @sprite = cc.Sprite.create "#runner0.png"
        @sprite.attr
            x:80
            y:85
        @sprite.runAction @runningAction;
        @spriteSheet.addChild @sprite;

StartupScene = cc.Scene.extend onEnter: ->
    @_super()
    @addChild new BackgroundLayer()
    #@addChild new AnimationLayer() #TODO (S.Panfilov) turn on
    return
'use strict'

MouseHelper = ->
    isMouseExist: ->
        cc.sys.capabilities.hasOwnProperty 'mouse'
    addMouseListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.MOUSE
            onMouseDown: (event) ->
                cc.log "Left mouse button pressed at " + event.getLocationX() if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
            onMouseUp: (event) ->
                cc.log "Left mouse button released at " + event.getLocationX() if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
        , @
    onLeftMouseDown: ->
        #TODO (S.Panfilov)
    onLeftMouseUp: ->
        #TODO (S.Panfilov)
    onLeftMouseClicked: ->
        #TODO (S.Panfilov)
    onLeftMouseDoubleClicked: ->
        #TODO (S.Panfilov)
'use strict'

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
'use strict'

TouchHelper = ->
    isTouchesExist: ->
        cc.sys.capabilities.hasOwnProperty 'touches'
    addOneTouchListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.TOUCH_ONE_BY_ONE
            onTouchBegan: (touch, event) ->
                cc.log "Touch began " + touch.getLocationX()
            onTouchMoved: (touch, event) ->
                cc.log "Touch moved " + touch.getLocationX()
            onTouchEnded: (touch, ended) ->
                cc.log "Touch Began " + touch.getLocationX()
            onTouchCancelled: (touch, event) ->
                cc.log "Touch cancelled " + touch.getLocationX()
        , @
    addMultyTouchListener: ->
        cc.eventManager.addListener
            event: cc.EventListener.TOUCH_ALL_AT_ONCE
            onTouchesBegan: (touches, event) ->
                cc.log "Touches began " + touches[0].getLocationX()
                cc.log "Touches began " + touches[1].getLocationX()
            onTouchesMoved: (touches, event) ->
                cc.log "Touches moved " + touches[2].getLocationX()
        , @