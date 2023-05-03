# @ts-check

class StateG extends EmitterShell

  constructor: ->
    super()

    ### @type import('./type/state').StateG['cache'] ###
    @cache = {}

    ###* @type import('./type/state').StateG['list'] ###
    @list = []

    ###* @type import('./type/state').StateG['namespace'] ###
    @namespace = 'state'

  ###* @type import('./type/state').StateG['checkIsFree'] ###
  checkIsFree: ->

    unless ColorManager.findAll [0xFFFFFF, 0x323232], [
      '94%', '80%'
      '95%', '82%'
    ] then return false

    return true

  ###* @type import('./type/state').StateG['init'] ###
  init: ->

    @on 'change', =>
      unless $.length @list
        console.log '#state: -'
      else console.log '#state:', $.join @list, ', '

  ###* @type import('./type/state').StateG['is'] ###
  is: (names...) ->

    for name in names

      if $.startsWith name, 'not-'
        name2 = $.subString name, 4
        if $.includes @list, name2 then return false
        continue

      unless $.includes @list, name then return false
      continue

    return true

  ###* @type import('./type/state').StateG['makeListName'] ###
  makeListName: -> []

  ###* @type import('./type/state').StateG['throttle'] ###
  throttle: (id, interval, fn) ->

    unless Timer.hasElapsed "state/#{id}", interval
      Indicator.setCount 'gdip/prevent'
      return @cache[id]

    return @cache[id] = fn()

  ###* @type import('./type/state').StateG['update'] ###
  update: ->

    d = list: @makeListName()

    do => # free

      unless Scene.is 'normal' then return
      if $.includes d.list, 'frozen' then return

      # free
      if @checkIsFree()
        $.push d.list, 'free'
        return

    if $.eq d.list, @list then return
    @list = d.list
    @emit 'change'

# @ts-ignore
State = new StateG()