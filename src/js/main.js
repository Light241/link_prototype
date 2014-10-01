var BackgroundLayer, StartupScene;

BackgroundLayer = cc.Layer.extend({
  sprite: null,
  ctor: function() {
    var size;
    this._super();
    size = cc.winSize;
    this.sprite = new cc.Sprite(res.pureBG_png);
    this.sprite.attr({
      x: size.width / 2,
      y: size.height / 2,
      scale: 0.5,
      rotation: 180
    });
    this.addChild(this.sprite, 0);
    this.sprite.runAction(cc.sequence(cc.rotateTo(2, 0), cc.scaleTo(2, 1, 1)));
    return true;
  }
});

StartupScene = cc.Scene.extend({
  onEnter: function() {
    var layer;
    this._super();
    layer = new BackgroundLayer();
    this.addChild(layer);
  }
});

//# sourceMappingURL=main.js.map
