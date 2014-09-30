var HelloWorldLayer, HelloWorldScene, g_resources, i, res;

HelloWorldLayer = cc.Layer.extend({
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

HelloWorldScene = cc.Scene.extend({
  onEnter: function() {
    var layer;
    this._super();
    layer = new HelloWorldLayer();
    this.addChild(layer);
  }
});

'use strict';

res = {
  HelloWorld_png: "res/HelloWorld.png",
  CloseNormal_png: "res/CloseNormal.png",
  CloseSelected_png: "res/CloseSelected.png",
  pureBG_png: "res/white_bg.png"
};

g_resources = [];

for (i in res) {
  g_resources.push(res[i]);
}

//# sourceMappingURL=app.js.map
