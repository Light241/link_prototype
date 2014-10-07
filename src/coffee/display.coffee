'use strict'

RESOLUTIONS =
    iPadRetina:
        large: 2048
        small: 1536
    iPad:
        large: 1024
        small: 768
    iPhoneSixPlus:
        large: 2208
        small: 1242
    iPhoneSix:
        large: 1334
        small: 750
    iPhoneFive:
        large: 1136
        small: 640

DisplayHelper = ->
    isNative: cc.sys.isNative
    searchPaths: jsb.fileUtils.getSearchPaths()
    displayWidth: cc.view.getFrameSize().width
    displayHeight: cc.view.getFrameSize().height
    isIPadRetina: ->
        isPortrait = @width is RESOLUTIONS.iPadRetina.large and @height is RESOLUTIONS.iPadRetina.small
        isLandscape = @width is RESOLUTIONS.iPadRetina.small and @height is RESOLUTIONS.iPadRetina.large
        isPortrait or isLandscape
    iPad: ->
        isPortrait = @width is RESOLUTIONS.iPad.large and @height is RESOLUTIONS.iPad.small
        isLandscape = @width is RESOLUTIONS.iPad.small and @height is RESOLUTIONS.iPad.large
        isPortrait or isLandscape
    iPhoneSixPlus: ->
        isPortrait = @width is RESOLUTIONS.iPhoneSixPlus.large and @height is RESOLUTIONS.iPhoneSixPlus.small
        isLandscape = @width is RESOLUTIONS.iPhoneSixPlus.small and @height is RESOLUTIONS.iPhoneSixPlus.large
        isPortrait or isLandscape
    iPhoneSix: ->
        isPortrait = @width is RESOLUTIONS.iPhoneSix.large and @height is RESOLUTIONS.iPhoneSix.small
        isLandscape = @width is RESOLUTIONS.iPhoneSix.small and @height is RESOLUTIONS.iPhoneSix.large
        isPortrait or isLandscape
    iPhoneFive: ->
        isPortrait = @width is RESOLUTIONS.iPhoneFive.large and @height is RESOLUTIONS.iPhoneFive.small
        isLandscape = @width is RESOLUTIONS.iPhoneFive.small and @height is RESOLUTIONS.iPhoneFive.large
        isPortrait or isLandscape
    isLandscape: ->
        #TODO (S.Panfilov)
    isPortrait: ->
        !@isLandscape()