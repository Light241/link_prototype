'use strict'

res =
    sprite_png: "res/sprite.png"
    sprite_plist: "res/sprite.plist"
    running_png: "res/running.png"
    running_plist: "res/running.plist"
    map_png: "map.png"
    map00_tmx: "map00.tmx"
    map01_tmx: "map01.tmx"

g_resources = []
for i of res
    g_resources.push res[i]