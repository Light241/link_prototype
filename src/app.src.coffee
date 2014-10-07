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
        #TODO (S.Panfilov) addListener has also a nodeOrPriority param
        cc.eventManager.addListener
            event: cc.EventListener.MOUSE
            onMouseDown: (event) ->
                cc.log "Left mouse button pressed at " + event.getLocationX() if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
            onMouseUp: (event) ->
                cc.log "Left mouse button released at " + event.getLocationX() if (event.getButton() is cc.EventMouse.BUTTON_LEFT)
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