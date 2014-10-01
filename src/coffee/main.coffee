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
    ctor: ->
        @_super()
        @init()
    init: ->
        @_super()

        spriteRunner = cc.Sprite.create res.runner_png
        spriteRunner.attr
            x: 80
            y: 85

        actionTo = cc.MoveTo.create 2, cc.p 300, 85
        spriteRunner.runAction cc.Sequence.create actionTo
        @addChild spriteRunner
)

StartupScene = cc.Scene.extend(onEnter: ->
    @_super()
    @addChild new BackgroundLayer()
    @addChild new AnimationLayer()
    return
)