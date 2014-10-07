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
    isIPadRetina: ->
        isPortrait = @width is RESOLUTIONS.iPadRetina.large and @height is RESOLUTIONS.iPadRetina.small
        isLandscape = @width is RESOLUTIONS.iPadRetina.small and @height is RESOLUTIONS.iPadRetina.large
        isPortrait or isLandscape
    iPad: ->
        isPortrait = @width is RESOLUTIONS.iPad.large and @height is RESOLUTIONS.iPad.small
        isLandscape = @width is RESOLUTIONS.iPad.small and @height is RESOLUTIONS.iPad.large
        isPortrait or isLandscape
    iPhoneSixPlus: ->
        isPortrait = @width is RESOLUTIONS.iPhoneSixPlus.large and @height is RESOLUTIONS.iPhoneSixPlus.small
        isLandscape = @width is RESOLUTIONS.iPhoneSixPlus.small and @height is RESOLUTIONS.iPhoneSixPlus.large
        isPortrait or isLandscape
    iPhoneSix: ->
        isPortrait = @width is RESOLUTIONS.iPhoneSix.large and @height is RESOLUTIONS.iPhoneSix.small
        isLandscape = @width is RESOLUTIONS.iPhoneSix.small and @height is RESOLUTIONS.iPhoneSix.large
        isPortrait or isLandscape
    iPhoneFive: ->
        isPortrait = @width is RESOLUTIONS.iPhoneFive.large and @height is RESOLUTIONS.iPhoneFive.small
        isLandscape = @width is RESOLUTIONS.iPhoneFive.small and @height is RESOLUTIONS.iPhoneFive.large
        isPortrait or isLandscape
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