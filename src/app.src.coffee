
HelloWorldLayer = cc.Layer.extend(
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

HelloWorldScene = cc.Scene.extend(onEnter: ->
    @_super()
    layer = new HelloWorldLayer()
    @addChild layer
    return
)
'use strict'

res =
    HelloWorld_png: "res/HelloWorld.png"
    CloseNormal_png: "res/CloseNormal.png"
    CloseSelected_png: "res/CloseSelected.png"
    pureBG_png: "res/white_bg.png"

g_resources = []
for i of res
    g_resources.push res[i]