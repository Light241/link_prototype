BackgroundLayer = cc.Layer.extend(
    sprite: null
    ctor: ->
        @_super()

        size = cc.winSize

        @sprite = new cc.Sprite(res.pureBG_png)

        @sprite.attr
            x: size.width / 2
            y: size.height / 2
            scale: 0.5
            rotation: 180

        @addChild @sprite, 0

        @sprite.runAction cc.sequence(cc.rotateTo(2, 0), cc.scaleTo(2, 1, 1))
        true
)

StartupScene = cc.Scene.extend(onEnter: ->
    @_super()
    layer = new BackgroundLayer()
    @addChild layer
    return
)
'use strict'

res =
    pureBG_png: "res/pureBG.png"

g_resources = []
for i of res
    g_resources.push res[i]