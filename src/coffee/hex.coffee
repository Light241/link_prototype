'use strict'

HexUtils = ->
    #add(center, polar(size, 2 * PI / 6 * (i + 0.5))
    hexes: {}
    hexesConfig:
        type: 'Pointy topped'
        coordinateSystem: 'Axial'
        startFrom: 'Left-top'
        cornersCount: 6
    setHexesConfig: (size) ->
        @hexesConfig.hexSize = size
        @hexesConfig.hexHeight = size * 2
        @hexesConfig.hexWidth = Math.sqrt(3) / 2 * @hexesConfig.hexHeight
        @hexesConfig.horizontalDistance = @hexesConfig.hexWidth
    calculateHex: (centerX, centerY) ->
        hex =
            centerX: centerX
            centerY: centerY
            corners: []

        for i in [0...@hexesConfig.cornersCount]
            angle = 2 * Math.PI / @hexesConfig.cornersCount * (i + 0.5)
            hex.corners.push
                number: i
                x: centerX + @hexesConfig.hexSize * Math.cos angle
                y: centerY + @hexesConfig.hexSize * Math.sin angle
    generateHexes: (centerX, centerY, widthHexCount, heightHexCount) ->
        hexesCount = widthHexCount * heightHexCount
        for i in [0...hexesCount]
            hex = {}
            if i is 0
                hex = @calculateHex centerX, centerY
            else
                hex = @calculateHex newHexCenterX, newHexCenterY
            offset = @getOffsetForHex centerX, centerY, widthHexCount, heightHexCount, i
            newHexCenterX = offset.x
            newHexCenterY = offset.y
            axial = @getAxialCoords widthHexCount, heightHexCount, i
            hex.q = axial.q
            hex.r = axial.r
            hex.id = ObjectsUtils.getCustomPostfixId "#{hex.q}-#{hex.r}"
            hex.alias = "HEX_#{hex.q}-#{hex.r}"
            @hexes[hex.id] = hex
        @hexes
    convertCubeToAxial: (x, z) ->
        q: x
        r: z
    convertAxialToCube: (q, r) ->
        x: q
        z: r
        y: (-x) - z
    getOffsetForHex: (centerX, centerY, widthHexCount, heightHexCount, hexNumber) ->
        #TODO (S.Panfilov)
    getAxialCoords: (widthHexCount, heightHexCount, hexNumber) ->
        result = {}
        if hexNumber is 0
            result.q = 0
            result.r = 0
        if hexNumber <= widthHexCount
            result.q = hexNumber
            result.r = 0
        if hexNumber > widthHexCount
            r = hexNumber % widthHexCount
            result.q = i - (r * widthHexCount)
            result.r = r