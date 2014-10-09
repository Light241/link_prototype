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

        #TODO (S.Panfilov) current work point
        hexSizePx = 20
        HexUtils::setHexesConfig hexSizePx
        MouseHelper::onLeftMouse @, (x, y) =>
            polyNode = HexUtils::drawHex x, y
            @addChild polyNode, 5
        , null

        @scheduleUpdate()
    update: ->
        #update called every frame after @scheduleUpdate called

StartupScene = cc.Scene.extend onEnter: ->
    @_super()
    @addChild new BackgroundLayer()
    return