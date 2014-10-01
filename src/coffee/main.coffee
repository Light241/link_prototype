BackgroundLayer = cc.Layer.extend(
    ctor: ->
        @_super()
        @init()

    init: ->
        @_super()

        winSize = cc.director.getWinSize()
        centerPos = cc.p winSize.width / 2, winSize.height / 2
        spriteBG = cc.Sprite.create res.pureBG_png
        spriteBG.setPosition centerPos

        @addChild spriteBG
)

AnimationLayer = cc.Layer.extend(
    spriteSheet: null
    runningAction: null
    sprite: null
    ctor: ->
        @_super()
        @init()
    init: ->
        @_super()

        cc.spriteFrameCache.addSpriteFrames res.running_plist
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
)

StartupScene = cc.Scene.extend(onEnter: ->
    @_super()
    @addChild new BackgroundLayer()
    @addChild new AnimationLayer()
    return
)