var AnimationLayer, BackgroundLayer, StartupScene;

BackgroundLayer = cc.Layer.extend({
  demoLvlMap: null,
  map01: null,
  mapWidth: 0,
  mapIndex: 0,
  ctor: function() {
    this._super();
    return this.init();
  },
  init: function() {
    this._super();
    this.demoLvlMap = cc.TMXTiledMap.create(res.demo_lvl_bg_tmx);
    this.addChild(this.demoLvlMap);
    this.mapWidth = this.demoLvlMap.getContentSize().width;
    return this.scheduleUpdate();
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
  }
});

//# sourceMappingURL=main.js.map
