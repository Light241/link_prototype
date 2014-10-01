(function() {
  'use strict';
  var g_resources, i, res;

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

}).call(this);

//# sourceMappingURL=resource.js.map
