var AccelerometerHelper, BackgroundLayer, DisplayHelper, EventsUtils, HexUtils, KeyboardHelper, MouseHelper, ObjectsUtils, StartupScene, TouchHelper, g_resources, i, res;

AccelerometerHelper = (function() {
  function AccelerometerHelper() {}

  AccelerometerHelper.prototype.isAccelerometerExist = function() {
    return cc.sys.capabilities.hasOwnProperty('accelerometer');
  };

  AccelerometerHelper.prototype.enabledAccelerometer = function() {
    return cc.inputManager.setAccelerometerEnabled(true);
  };

  AccelerometerHelper.prototype.disabledAccelerometer = function() {
    return cc.inputManager.setAccelerometerEnabled(false);
  };

  AccelerometerHelper.prototype.isAccelerometerEnabled = function() {
    return cc.Device.isAccelerometerEnabled;
  };

  AccelerometerHelper.prototype.addAccelerometerListener = function() {
    return cc.eventManager.addListener({
      event: cc.EventListener.ACCELERATION,
      callback: function(acc, event) {
        return cc.log("Accelerometer feel smth!");
      }
    }, this);
  };

  return AccelerometerHelper;

})();

DisplayHelper = (function() {
  function DisplayHelper() {}

  DisplayHelper.prototype.RESOLUTIONS = {
    iPadRetina: {
      large: 2048,
      small: 1536
    },
    iPad: {
      large: 1024,
      small: 768
    },
    iPhoneSixPlus: {
      large: 2208,
      small: 1242
    },
    iPhoneSix: {
      large: 1334,
      small: 750
    },
    iPhoneFive: {
      large: 1136,
      small: 640
    }
  };

  DisplayHelper.prototype.isNative = cc.sys.isNative;

  DisplayHelper.prototype.getDisplayWidth = function() {
    return cc.view.getFrameSize().width;
  };

  DisplayHelper.prototype.getDisplayHeight = function() {
    return cc.view.getFrameSize().height;
  };

  DisplayHelper.prototype.isResolution = function(width, height) {
    return (this.width === width) && (this.height === height);
  };

  DisplayHelper.prototype.isIPadRetina = function() {
    var isLandscape, isPortrait;
    isPortrait = this.isResolution(this.RESOLUTIONS.iPadRetina.large(this.RESOLUTIONS.iPadRetina.small));
    isLandscape = this.isResolution(this.RESOLUTIONS.iPadRetina.small(this.RESOLUTIONS.iPadRetina.large));
    return (isPortrait || isLandscape) && this.isNative;
  };

  DisplayHelper.prototype.isIPad = function() {
    var isLandscape, isPortrait;
    isPortrait = this.isResolution(this.RESOLUTIONS.iPad.large(this.RESOLUTIONS.iPad.small));
    isLandscape = this.isResolution(this.RESOLUTIONS.iPad.small(this.RESOLUTIONS.iPad.large));
    return (isPortrait || isLandscape) && this.isNative;
  };

  DisplayHelper.prototype.isIPhoneSixPlus = function() {
    var isLandscape, isPortrait;
    isPortrait = this.isResolution(this.RESOLUTIONS.iPhoneSixPlus.large(this.RESOLUTIONS.iPhoneSixPlus.small));
    isLandscape = this.isResolution(this.RESOLUTIONS.iPhoneSixPlus.small(this.RESOLUTIONS.iPhoneSixPlus.large));
    return (isPortrait || isLandscape) && this.isNative;
  };

  DisplayHelper.prototype.isIPhoneSix = function() {
    var isLandscape, isPortrait;
    isPortrait = this.isResolution(this.RESOLUTIONS.iPhoneSix.large(this.RESOLUTIONS.iPhoneSix.small));
    isLandscape = this.isResolution(this.RESOLUTIONS.iPhoneSix.small(this.RESOLUTIONS.iPhoneSix.large));
    return (isPortrait || isLandscape) && this.isNative;
  };

  DisplayHelper.prototype.isIPhoneFive = function() {
    var isLandscape, isPortrait;
    isPortrait = this.isResolution(this.RESOLUTIONS.iPhoneFive.large(this.RESOLUTIONS.iPhoneFive.small));
    isLandscape = this.isResolution(this.RESOLUTIONS.iPhoneFive.small(this.RESOLUTIONS.iPhoneFive.large));
    return (isPortrait || isLandscape) && this.isNative;
  };

  DisplayHelper.prototype.isLandscape = function() {};

  DisplayHelper.prototype.isPortrait = function() {
    return !this.isLandscape();
  };

  return DisplayHelper;

})();

EventsUtils = (function() {
  function EventsUtils() {}

  EventsUtils.prototype.listeners = [];

  EventsUtils.prototype.addListener = function(listenerConfig, nodeOrPriority) {
    return cc.eventManager.addListener(listenerConfig, nodeOrPriority);
  };

  EventsUtils.prototype.removeAllListeners = function() {
    return cc.eventManager.removeAllListeners();
  };

  EventsUtils.prototype.removeListener = function(listener) {
    return cc.eventManager.removeListener(listener);
  };

  EventsUtils.prototype.removeListenersForObject = function(object) {
    return cc.eventManager.removeListeners(object);
  };

  EventsUtils.prototype.removeListenersByType = function(type) {
    return cc.eventManager.removeListeners(type);
  };

  EventsUtils.prototype.pause = function(layer, isRecursive) {
    return cc.eventManager.pauseTarget(layer, isRecursive);
  };

  EventsUtils.prototype.resume = function(layer, isRecursive) {
    return cc.eventManager.resumeTarget(layer, isRecursive);
  };

  return EventsUtils;

})();

HexUtils = (function() {
  var _drawHex;

  function HexUtils() {}

  _drawHex = function(drawNode, hex) {
    drawNode.drawPoly(hex.corners, cc.color(255, 255, 255), 1, cc.color(0, 0, 255));
    return drawNode;
  };

  HexUtils.prototype.hexes = {};

  HexUtils.prototype.hexesConfig = {
    type: 'Pointy topped',
    coordinateSystem: 'Axial',
    startFrom: 'Left-top',
    cornersCount: 6
  };

  HexUtils.prototype.setHexesConfig = function(size) {
    this.hexesConfig.hexSize = size;
    this.hexesConfig.hexHeight = size * 2;
    this.hexesConfig.hexWidth = Math.sqrt(3) / 2 * this.hexesConfig.hexHeight;
    this.hexesConfig.horizontalDistance = this.hexesConfig.hexWidth;
    return this.hexesConfig.verticalDistance = (3 / 4) * this.hexesConfig.hexHeight;
  };

  HexUtils.prototype.convertCubeToAxial = function(x, z) {
    return {
      q: x,
      r: z
    };
  };

  HexUtils.prototype.convertAxialToCube = function(q, r) {
    return {
      x: q,
      z: r,
      y: (-x) - z
    };
  };

  HexUtils.prototype.calculateHex = function(centerX, centerY) {
    var angle, hex, i, _i, _ref;
    hex = {
      centerX: centerX,
      centerY: centerY,
      corners: []
    };
    for (i = _i = 0, _ref = this.hexesConfig.cornersCount; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
      angle = 2 * Math.PI / this.hexesConfig.cornersCount * (i + 0.5);
      hex.corners.push({
        x: centerX + this.hexesConfig.hexSize * Math.cos(angle),
        y: centerY + this.hexesConfig.hexSize * Math.sin(angle)
      });
    }
    return hex;
  };

  HexUtils.prototype.generateHexesGrid = function(centerX, centerY, widthHexCount, heightHexCount) {
    var axial, hex, hexesCount, i, offset, _i;
    this.hexes = [];
    hexesCount = widthHexCount * heightHexCount;
    for (i = _i = 0; 0 <= hexesCount ? _i < hexesCount : _i > hexesCount; i = 0 <= hexesCount ? ++_i : --_i) {
      hex = {};
      offset = this.getOffsetForHex(centerX, centerY, widthHexCount, heightHexCount, i);
      hex = this.calculateHex(offset.x, offset.y);
      axial = this.getAxialCoords(widthHexCount, heightHexCount, i);
      hex.q = axial.q;
      hex.r = axial.r;
      hex.id = ObjectsUtils.prototype.getCustomPostfixId("" + hex.q + "-" + hex.r);
      hex.alias = "HEX_" + hex.q + "-" + hex.r;
      this.hexes[hex.alias] = hex;
    }
    return this.hexes;
  };

  HexUtils.prototype.getOffsetForHex = function(centerX, centerY, widthHexCount, heightHexCount, hexNumber) {
    var horizontalDistance, r, result, verticalDistance;
    horizontalDistance = this.hexesConfig.horizontalDistance;
    verticalDistance = this.hexesConfig.verticalDistance;
    result = {};
    if (hexNumber === 0) {
      result.x = centerX;
      result.y = centerY;
    } else if (hexNumber < widthHexCount) {
      result.x = centerX + (horizontalDistance * hexNumber);
      result.y = centerY;
    } else if (hexNumber === widthHexCount) {
      result.x = centerX + (horizontalDistance / 2);
      result.y = centerY - verticalDistance;
    } else if (hexNumber > widthHexCount) {
      r = hexNumber % widthHexCount;
      result.x = centerX + ((horizontalDistance / 2) * hexNumber);
      result.y = centerY - (verticalDistance * r);
    }
    return result;
  };

  HexUtils.prototype.getAxialCoords = function(widthHexCount, heightHexCount, hexNumber) {
    var r, result;
    result = {};
    if (hexNumber === 0) {
      result.q = 0;
      result.r = 0;
    } else if (hexNumber < widthHexCount) {
      result.q = hexNumber;
      result.r = 0;
    } else if (hexNumber === widthHexCount) {
      result.q = 0;
      result.r = 1;
    } else if (hexNumber > widthHexCount) {
      r = hexNumber % widthHexCount;
      result.q = hexNumber - (r * widthHexCount);
      result.r = r;
    }
    return result;
  };

  HexUtils.prototype.drawHex = function(centerX, centerY) {
    var drawNode;
    drawNode = new cc.DrawNode;
    return _drawHex(drawNode, this.calculateHex(centerX, centerY));
  };

  HexUtils.prototype.drawHexesGrid = function(hexes) {
    var drawNode, k;
    hexes = hexes || this.hexes;
    drawNode = new cc.DrawNode;
    for (k in hexes) {
      if (hexes.hasOwnProperty(k)) {
        _drawHex(drawNode, hexes[k]);
      }
    }
    return drawNode;
  };

  HexUtils.prototype.drawHexesGridNumbers = function(hexes, node, zOrder) {
    var hexLabel, k, _results;
    hexes = hexes || this.hexes;
    _results = [];
    for (k in hexes) {
      if (hexes.hasOwnProperty(k)) {
        hexLabel = new cc.LabelTTF("" + hexes[k].q + ", " + hexes[k].r, "Arial", 10);
        hexLabel.setColor(cc.color(0, 0, 255));
        hexLabel.x = hexes[k].centerX;
        hexLabel.y = hexes[k].centerY;
        _results.push(node.addChild(hexLabel, zOrder));
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  return HexUtils;

})();

KeyboardHelper = (function() {
  function KeyboardHelper() {}

  KeyboardHelper.prototype.isKeyboardExist = function() {
    return cc.sys.capabilities.hasOwnProperty('keyboard');
  };

  KeyboardHelper.prototype.getCurrentTarget = function(event) {
    return event.getCurrentTarget();
  };

  KeyboardHelper.prototype.addKeyboardListener = function() {
    return cc.eventManager.addListener({
      event: cc.EventListener.KEYBOARD,
      onKeyPressed: function(keyCode, event) {
        var label;
        label = event.getCurrentTarget();
        return label.setString("Key " + (keyCode.toString()) + " was pressed!");
      },
      onKeyReleased: function(keyCode, event) {
        var label;
        label = event.getCurrentTarget();
        return label.setString("Key " + (keyCode.toString()) + " was relesed!");
      }
    }, this);
  };

  return KeyboardHelper;

})();

'use strict';

BackgroundLayer = cc.Layer.extend({
  ctor: function() {
    this._super();
    return this.init();
  },
  init: function() {
    var helloLabel, hexSizePx, hexesInCol, hexesInRow, size;
    this._super();
    size = cc.winSize;
    this.maxWidth = cc.director.getWinSizeInPixels().width;
    this.maxHeight = cc.director.getWinSizeInPixels().height;
    helloLabel = new cc.LabelTTF("Hello Worlds", "Arial", 38);
    helloLabel.x = size.width / 2;
    helloLabel.y = 100;
    this.addChild(helloLabel, 5);
    hexSizePx = 35;
    HexUtils.prototype.setHexesConfig(hexSizePx);
    MouseHelper.prototype.onLeftMouse(this, (function(_this) {
      return function(x, y) {
        var polyNode;
        polyNode = HexUtils.prototype.drawHex(x, y);
        return _this.addChild(polyNode, 5);
      };
    })(this));
    hexesInRow = 5;
    hexesInCol = 2;
    MouseHelper.prototype.onRightMouse(this, (function(_this) {
      return function(x, y) {
        var hexesGrid, polyNode;
        hexesGrid = HexUtils.prototype.generateHexesGrid(x, y, hexesInRow, hexesInCol);
        polyNode = HexUtils.prototype.drawHexesGrid(hexesGrid);
        _this.addChild(polyNode, 5);
        return HexUtils.prototype.drawHexesGridNumbers(hexesGrid, _this, 6);
      };
    })(this));
    return this.scheduleUpdate();
  },
  update: function() {}
});

StartupScene = cc.Scene.extend({
  onEnter: function() {
    this._super();
    this.addChild(new BackgroundLayer());
  }
});

MouseHelper = (function() {
  function MouseHelper() {}

  MouseHelper.prototype.isMouseExist = function() {
    return cc.sys.capabilities.hasOwnProperty('mouse');
  };

  MouseHelper.prototype.onLeftMouse = function(target, callbackDown, callbackUp) {
    return cc.eventManager.addListener({
      event: cc.EventListener.MOUSE,
      onMouseDown: function(event) {
        if (event.getButton() === cc.EventMouse.BUTTON_LEFT) {
          if (callbackDown) {
            callbackDown(event.getLocationX(), event.getLocationY());
          }
          return cc.log("Left mouse button pressed at " + (event.getLocationX()));
        }
      },
      onMouseUp: function(event) {
        if (event.getButton() === cc.EventMouse.BUTTON_LEFT) {
          if (callbackUp) {
            callbackUp(event.getLocationX(), event.getLocationY());
          }
          if (event.getButton() === cc.EventMouse.BUTTON_LEFT) {
            return cc.log("Left mouse button released at " + (event.getLocationX()));
          }
        }
      }
    }, target);
  };

  MouseHelper.prototype.onRightMouse = function(target, callbackDown, callbackUp) {
    return cc.eventManager.addListener({
      event: cc.EventListener.MOUSE,
      onMouseDown: function(event) {
        if (event.getButton() === cc.EventMouse.BUTTON_RIGHT) {
          if (callbackDown) {
            callbackDown(event.getLocationX(), event.getLocationY());
          }
          return cc.log("Right mouse button pressed at " + (event.getLocationX()));
        }
      },
      onMouseUp: function(event) {
        if (event.getButton() === cc.EventMouse.BUTTON_RIGHT) {
          if (callbackUp) {
            callbackUp(event.getLocationX(), event.getLocationY());
          }
          if (event.getButton() === cc.EventMouse.BUTTON_LEFT) {
            return cc.log("Right mouse button released at " + (event.getLocationX()));
          }
        }
      }
    }, target);
  };

  return MouseHelper;

})();

ObjectsUtils = (function() {
  function ObjectsUtils() {}

  ObjectsUtils.prototype.getS4 = function() {
    return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
  };

  ObjectsUtils.prototype.getRandomId = function() {
    return "" + (this.getS4()) + (this.getS4()) + "-" + (this.getS4()) + "-" + (this.getS4()) + "-" + (this.getS4()) + "-" + (this.getS4()) + (this.getS4()) + (this.getS4());
  };

  ObjectsUtils.prototype.getCustomPostfixId = function(postfix) {
    return "" + (this.getRandomId()) + "_" + postfix;
  };

  return ObjectsUtils;

})();

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

TouchHelper = (function() {
  function TouchHelper() {}

  TouchHelper.prototype.isTouchesExist = function() {
    return cc.sys.capabilities.hasOwnProperty('touches');
  };

  TouchHelper.prototype.addOneTouchListener = function() {
    return cc.eventManager.addListener({
      event: cc.EventListener.TOUCH_ONE_BY_ONE,
      onTouchBegan: function(touch, event) {
        var locationInNode, size, target;
        target = event.getCurrentTarget();
        locationInNode = target.convertToNodeSpace(touch.getLocation());
        size = target.getContentSize();
        return cc.log("Touch began at " + (touch.getLocationX()) + ", target: " + target + ", locationInNode: " + locationInNode + ", size: " + size);
      },
      onTouchMoved: function(touch, event) {
        var delta, target;
        target = event.getCurrentTarget();
        delta = touch.getDelta();
        return cc.log("Touch moved " + (touch.getLocationX()) + ", target: " + target + ", delta: " + delta);
      },
      onTouchEnded: function(touch, ended) {
        return cc.log("Touch ended " + (touch.getLocationX()));
      },
      onTouchCancelled: function(touch, event) {
        return cc.log("Touch cancelled " + (touch.getLocationX()));
      }
    }, this);
  };

  TouchHelper.prototype.addMultiTouchListener = function() {
    return cc.eventManager.addListener({
      event: cc.EventListener.TOUCH_ALL_AT_ONCE,
      onTouchesBegan: function(touches, event) {
        cc.log("Touches began " + (touches[0].getLocationX()));
        return cc.log("Touches began " + (touches[1].getLocationX()));
      },
      onTouchesMoved: function(touches, event) {
        return cc.log("Touches moved " + (touches[2].getLocationX()));
      }
    }, this);
  };

  return TouchHelper;

})();

//# sourceMappingURL=app.js.map
