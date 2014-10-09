cc.game.onStart = ->
    cc.view.adjustViewPort true
    cc.view.setDesignResolutionSize 1200, 800, cc.ResolutionPolicy.SHOW_ALL
    cc.view.resizeWithBrowserSize true

    cc.LoaderScene.preload g_resources, ->
        cc.director.runScene new StartupScene()
    , @

cc.game.run()