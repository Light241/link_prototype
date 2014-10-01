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
  spriteSheet: null,
  runningAction: null,
  sprite: null,
  ctor: function() {
    this._super();
    return this.init();
  },
  init: function() {
    var animFrames, animation, frame, i, str, _i;
    this._super();
    cc.spriteFrameCache.addSpriteFrames(res.running_plist);
    this.spriteSheet = cc.SpriteBatchNode.create(res.running_png);
    this.addChild(this.spriteSheet);
    animFrames = [];
    for (i = _i = 0; _i <= 7; i = ++_i) {
      str = "runner" + i + ".png";
      frame = cc.spriteFrameCache.getSpriteFrame(str);
      animFrames.push(frame);
    }
    animation = cc.Animation.create(animFrames, 0.1);
    this.runningAction = cc.RepeatForever.create(cc.Animate.create(animation));
    this.sprite = cc.Sprite.create("#runner0.png");
    this.sprite.attr({
      x: 80,
      y: 85
    });
    this.sprite.runAction(this.runningAction);
    return this.spriteSheet.addChild(this.sprite);
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
