'use strict'

HexUtils = ->
    #add(center, polar(size, 2 * PI / 6 * (i + 0.5))
    hexes: []
    addHex: (centerX, centerY, size)->
        hex =
            cornersCount: 6
            centerX: centerX
            centerY: centerY
            size: size

        for i in [0..hex.cornersCount]
            angle = 2 * Math.PI / hex.cornersCount * (i + 0.5)
            x_i = centerX + size * Math.cos angle
            y_i = centerY + size * Math.sin angle

            if i is 0
                #TODO (S.Panfilov) just move?
                #moveTo(x_i, y_i)
                cc.log "moved x: #{x_i}, y: #{y_i}"
            else
                #TODO (S.Panfilov) draw a line
                #lineTo(x_i, y_i)
                cc.log "drawed the line x: #{x_i}, y: #{y_i}"
        hex.id = ObjectsUtils.getCustomPostfixId "#{centerX}-#{centerY}"
        @hexes.push hex