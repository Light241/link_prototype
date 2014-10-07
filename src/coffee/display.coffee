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
    isResolution: width, height ->
        (@width is width) and (@height is height)
    isIPadRetina: ->
        isPortrait = @isResolution RESOLUTIONS.iPadRetina.large RESOLUTIONS.iPadRetina.small
        isLandscape = @isResolution RESOLUTIONS.iPadRetina.small RESOLUTIONS.iPadRetina.large
        (isPortrait or isLandscape) and @isNative
    iPad: ->
        isPortrait = @isResolution RESOLUTIONS.iPad.large RESOLUTIONS.iPad.small
        isLandscape = @isResolution RESOLUTIONS.iPad.small RESOLUTIONS.iPad.large
        (isPortrait or isLandscape) and @isNative
    iPhoneSixPlus: ->
        isPortrait = @isResolution RESOLUTIONS.iPhoneSixPlus.large RESOLUTIONS.iPhoneSixPlus.small
        isLandscape = @isResolution RESOLUTIONS.iPhoneSixPlus.small RESOLUTIONS.iPhoneSixPlus.large
        (isPortrait or isLandscape) and @isNative
    iPhoneSix: ->
        isPortrait = @isResolution RESOLUTIONS.iPhoneSix.large RESOLUTIONS.iPhoneSix.small
        isLandscape = @isResolution RESOLUTIONS.iPhoneSix.small RESOLUTIONS.iPhoneSix.large
        (isPortrait or isLandscape) and @isNative
    iPhoneFive: ->
        isPortrait = @isResolution RESOLUTIONS.iPhoneFive.large RESOLUTIONS.iPhoneFive.small
        isLandscape = @isResolution RESOLUTIONS.iPhoneFive.small RESOLUTIONS.iPhoneFive.large
        (isPortrait or isLandscape) and @isNative
    isLandscape: ->
        #TODO (S.Panfilov)
    isPortrait: ->
        !@isLandscape()