var AnimationLayer, BackgroundLayer, StartupScene;

BackgroundLayer = cc.Layer.extend({
  ctor: function() {
    this._super();
    return this.init();
  },
  init: function() {
    var centerPos, spriteBG, winSize;
    this._super();
    winSize = cc.director.getWinSize();
    centerPos = cc.p(winSize.width / 2, winSize.height / 2);
    spriteBG = cc.Sprite.create(res.pureBG_png);
    spriteBG.setPosition(centerPos);
    return this.addChild(spriteBG);
  }
});

AnimationLayer = cc.Layer.extend({
  ctor: function() {
    this._super();
    return this.init();
  },
  init: function() {
    var actionTo, spriteRunner;
    this._super();
    spriteRunner = cc.Sprite.create(res.runner_png);
    spriteRunner.attr({
      x: 80,
      y: 85
    });
    actionTo = cc.MoveTo.create(2, cc.p(300, 85));
    spriteRunner.runAction(cc.Sequence.create(actionTo));
    return this.addChild(spriteRunner);
  }
});

StartupScene = cc.Scene.extend({
  onEnter: function() {
    this._super();
    this.addChild(new BackgroundLayer());
    this.addChild(new AnimationLayer());
  }
});

//# sourceMappingURL=main.js.map
