# @ts-check

class Scene2G

  constructor: ->

    ### @type import('./type/scene2').Scene2G['cache'] ###
    @cache = {
      last: 'unknown'
    }

    ### @type import('./type/scene2').Scene2G['mapAbout'] ###
    @mapAbout = {
      battle: @aboutBattle
      dialogue: @aboutDialogue
      loading: @aboutLoading
      menu: @aboutMenu
      'mini-menu': @aboutMiniMenu
      normal: @aboutNormal
    }

  ###* @type import('./type/scene2').Scene2G['aboutBattle'] ###
  aboutBattle: ->

    unless @checkIsBattle() then return []
    list = @makeListName 'battle'

    return list

  ###* @type import('./type/scene2').Scene2G['aboutDialogue'] ###
  aboutDialogue: ->

    unless @checkIsDialogue() then return []
    list = @makeListName 'dialogue'

    return list

  ###* @type import('./type/scene2').Scene2G['aboutLoading'] ###
  aboutLoading: ->

    unless @checkIsLoading() then return []
    list = @makeListName 'loading'

    return list

  ###* @type import('./type/scene2').Scene2G['aboutMenu'] ###
  aboutMenu: ->

    unless @checkIsMenu() then return []
    list = @makeListName 'menu'

    if @checkIsMap()
      $.push list, 'map'
      return list

    if @checkIsParty()
      $.push list, 'party'
      return list

    return list

  ###* @type import('./type/scene2').Scene2G['aboutMiniMenu'] ###
  aboutMiniMenu: ->

    unless @checkIsMiniMenu() then return []
    list = @makeListName 'mini-menu'

    return list

  ###* @type import('./type/scene2').Scene2G['aboutNormal'] ###
  aboutNormal: ->

    unless @checkIsNormal() then return []
    list = @makeListName 'normal'

    return list

  ###* @type import('./type/scene2').Scene2G['check'] ###
  check: ->

    list = [
      'loading'
      'battle'
      'normal'
      'menu'
      'mini-menu'
      'dialogue'
    ]

    unless @cache.last == 'unknown'
      list = $.filter list, (name) => @cache.last != name
      $.unshift list, @cache.last

    for name in list
      fn = @mapAbout[name]
      result = fn()
      unless $.length result then continue
      @cache.last = name
      return result

    @cache.last = 'unknown'
    return []

  ###* @type import('./type/scene2').Scene2G['checkIsBattle'] ###
  checkIsBattle: -> ColorManager.findAll 0xE9D095, [
    '84%', '4%'
    '95%', '6%'
  ]

  ###* @type import('./type/scene2').Scene2G['checkIsDialogue'] ###
  checkIsDialogue: -> ColorManager.findAll 0xFFC300, [
    '45%', '79%'
    '55%', '82%'
  ]

  ###* @type import('./type/scene2').Scene2G['checkIsLoading'] ###
  checkIsLoading: ->

    p = [Window2.bounds.width - 1, '50%']

    for color in [0x000000]
      if (ColorManager.get p) == color then return true

    return false

  ###* @type import('./type/scene2').Scene2G['checkIsMap'] ###
  checkIsMap: -> @throttle 'check-is-map', 1e3, ->
    return ColorManager.findAll 0xEDE5DA, [
      '1%', '38%'
      '2%', '40%'
    ]

  ###* @type import('./type/scene2').Scene2G['checkIsMenu'] ###
  checkIsMenu: ->

    unless ColorManager.findAny [0xFFFFFF, 0xDCC491], [
      '96%', '2%'
      '98%', '6%'
    ] then return false

    if @checkIsBattle() then return false
    if @checkIsNormal() then return false

    return true

  ###* @type import('./type/scene2').Scene2G['checkIsMiniMenu'] ###
  checkIsMiniMenu: ->

    unless ColorManager.findAll 0xECE5D8, [
      '97%', '1%'
      '98%', '5%'
    ] then return false

    unless ColorManager.findAny [0x3D4555, 0xE2B42A], [
      '97%', '1%'
      '98%', '5%'
    ] then return false

    return true

  ###* @type import('./type/scene2').Scene2G['checkIsNormal'] ###
  checkIsNormal: ->

    if ColorManager.findAll 0xFFFFFF, [
      '11%', '20%'
      '14%', '23%'
    ] then return true

    return false

  ###* @type import('./type/scene2').Scene2G['checkIsParty'] ###
  checkIsParty: -> @throttle 'check-is-party', 1e3, ->
    return ColorManager.findAll 0xFFE9BE, [
      '35%', '4%'
      '73%', '10%'
    ]

  ###* necessary for types, do not remove
  @type import('./type/scene2').Scene2G['makeListName']
  ###
  makeListName: (names...) -> names

  ###* @type import('./type/scene2').Scene2G['throttle'] ###
  throttle: (id, interval, fn) ->

    unless Timer.hasElapsed "scene/#{id}", interval
      Indicator.setCount 'gdip/prevent'
      return @cache[id]

    return @cache[id] = fn()

# @ts-ignore
Scene2 = new Scene2G()