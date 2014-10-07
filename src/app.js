var AnimationLayer, BackgroundLayer, MouseHelper, StartupScene, TouchHelper, g_resources, i, res;

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

'use strict';

MouseHelper = function() {
  return {
    isMouseExist: function() {
      return cc.sys.capabilities.hasOwnProperty('mouse');
    },
    addMouseListener: function() {
      return cc.eventManager.addListener({
        event: cc.EventListener.MOUSE,
        onMouseDown: function(event) {
          if (event.getButton() === cc.EventMouse.BUTTON_LEFT) {
            return cc.log("Left mouse button pressed at " + event.getLocationX());
          }
        },
        onMouseUp: function(event) {
          if (event.getButton() === cc.EventMouse.BUTTON_LEFT) {
            return cc.log("Left mouse button released at " + event.getLocationX());
          }
        }
      });
    },
    onLeftMouseDown: function() {},
    onLeftMouseUp: function() {},
    onLeftMouseClicked: function() {},
    onLeftMouseDoubleClicked: function() {}
  };
};

'use strict';

res = {
  sprite_png: "res/sprite.png",
  sprite_plist: "res/sprite.plist",
  running_png: "res/running.png",
  running_plist: "res/running.plist",
  demo_lvl_bg_png: "res/tiles/demo_lvl_bg.png",
  demo_lvl_bg_tmx: "res/tiles/demo_lvl_bg.tmx"
};

g_resources = [];

for (i in res) {
  if (res.hasOwnProperty(i)) {
    g_resources.push(res[i]);
  }
}

'use strict';

TouchHelper = function() {
  return {
    isTouchesExist: function() {
      return cc.sys.capabilities.hasOwnProperty('touches');
    },
    addOneTouchListener: function() {
      return cc.eventManager.addListener({
        event: cc.EventListener.TOUCH_ONE_BY_ONE,
        onTouchBegan: function(touch, event) {
          return cc.log("Touch began " + touch.getLocationX());
        },
        onTouchMoved: function(touch, event) {
          return cc.log("Touch moved " + touch.getLocationX());
        },
        onTouchEnded: function(touch, ended) {
          return cc.log("Touch Began " + touch.getLocationX());
        },
        onTouchCancelled: function(touch, event) {
          return cc.log("Touch cancelled " + touch.getLocationX());
        }
      });
    },
    addMultyTouchListener: function() {
      return cc.eventManager.addListener({
        event: cc.EventListener.TOUCH_ALL_AT_ONCE,
        onTouchesBegan: function(touches, event) {
          cc.log("Touches began " + touches[0].getLocationX());
          return cc.log("Touches began " + touches[1].getLocationX());
        },
        onTouchesMoved: function(touches, event) {
          return cc.log("Touches moved " + touches[2].getLocationX());
        }
      });
    }
  };
};

//# sourceMappingURL=app.js.map
