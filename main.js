cc.game.onStart = function() {
  cc.view.adjustViewPort(true);
  cc.view.setDesignResolutionSize(1200, 800, cc.ResolutionPolicy.SHOW_ALL);
  cc.view.resizeWithBrowserSize(true);
  return cc.LoaderScene.preload(g_resources, function() {
    return cc.director.runScene(new StartupScene());
  }, this);
};

cc.game.run();

//# sourceMappingURL=main.js.map
