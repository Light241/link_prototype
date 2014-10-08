class ObjectsUtils
    getS4: ->
        Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1)
    getRandomId: ->
        "#{@getS4()}#{@getS4()}-#{@getS4()}-#{@getS4()}-#{@getS4()}-#{@getS4()}#{@getS4()}#{@getS4()}"
    getCustomPostfixId: (postfix)->
        "#{@getRandomId()}_#postfix"