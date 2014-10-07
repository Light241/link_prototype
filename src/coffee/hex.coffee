'use strict'

HexUtils = ->
    #add(center, polar(size, 2 * PI / 6 * (i + 0.5))
    hexes: []
    hexesConfig:
        type: 'Pointy topped'
        cornersCount: 6
    setHexesConfig: (size) ->
        @hexesConfig.hexSize = size
        @hexesConfig.hexHeight = size * 2
        @hexesConfig.hexWidth = Math.sqrt(3)/2 * @hexesConfig.hexHeight
        @hexesConfig.horizontalDistance = @hexesConfig.hexWidth
    addHex: (centerX, centerY) ->
        hex =
            centerX: centerX
            centerY: centerY

        for i in [0..@hexesConfig.cornersCount]
            angle = 2 * Math.PI / @hexesConfig.cornersCount * (i + 0.5)
            x_i = centerX + @hexesConfig.hexSize * Math.cos angle
            y_i = centerY + @hexesConfig.hexSize * Math.sin angle

            if i is 0
                #TODO (S.Panfilov) just move?
                #moveTo(x_i, y_i)
                cc.log "moved x: #{x_i}, y: #{y_i}"
            else
                #TODO (S.Panfilov) draw a line
                #lineTo(x_i, y_i)
                cc.log "drawed the line x: #{x_i}, y: #{y_i}"
        hex.id = ObjectsUtils.getCustomPostfixId "#{Math.floor centerX}-#{Math.floor centerY}"
        @hexes.push hex
        hex
    generateHexes: (centerX, centerY, count) ->
        for i in [0..count]
            hex = @addHex centerX, centerY
