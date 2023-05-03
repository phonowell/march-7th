# @ts-check

class MovementG extends KeyBinding

  constructor: ->
    super()

    ###* @type import('./type/movement').MovementG['direction'] ###
    @direction = []

    ###* @type import('./type/movement').MovementG['isForwarding'] ###
    @isForwarding = false

    ###* @type import('./type/movement').MovementG['isMoving'] ###
    @isMoving = false

    ###* @type import('./type/movement').MovementG['namespace'] ###
    @namespace = 'movement'

  ###* @type import('./type/movement').MovementG['aboutForward'] ###
  aboutForward: ->

    [key, token] = ['alt + w', 'toggle']

    # on event 'toggle', start or stop auto-forward
    @on token, =>
      if State.is 'domain' then return
      if @isForwarding then @stopForward() else @startForward()

    Scene.useExact 'normal', =>

      $.preventDefaultKey key, true
      @registerEvent token, key

      return =>

        $.preventDefaultKey key, false
        @unregisterEvent token, key

        # stop auto-forward if it is running
        if @isForwarding then @stopForward()

  ###* @type import('./type/movement').MovementG['aboutMove'] ###
  aboutMove: ->

    @on 'move', @report

    @on 'move:start', =>

      if @isForwarding and $.includes @direction, 's'
        @stopForward()

    Scene.useExact 'normal', =>

      [interval, token] = [100, 'movement/move']

      Timer.loop token, interval, =>

        cache = {
          direction: @direction
          isMoving: @isMoving
        }

        @direction = $.filter ['w', 'a', 's', 'd'], (key) ->
          # exclude `alt + w`
          if key == 'w' then return ($.isPressing 'w') and not $.isPressing 'alt'
          return $.isPressing key
        @isMoving = ($.length @direction) > 0

        if $.eq @direction, cache.direction then return
        @emit 'move'

        if @isMoving == cache.isMoving then return
        if @isMoving then @emit 'move:start' else @emit 'move:end'

      return =>
        Timer.remove token
        @direction = []
        @isMoving = false
        @emit 'move'
        @emit 'move:end'

  ###* @type import('./type/movement').MovementG['init'] ###
  init: ->
    @aboutForward()
    @aboutMove()

  ###* @type import('./type/movement').MovementG['report'] ###
  report: ->

    token = 'movement/report'

    unless @isMoving
      console.log "##{token}: -"
      return

    console.log "##{token}:", $.join @direction, ', '

  ###* @type import('./type/movement').MovementG['sprint'] ###
  sprint: -> $.click 'right'

  ###* @type import('./type/movement').MovementG['startForward'] ###
  startForward: ->

    @isForwarding = true
    console.log 'auto forward [ON]'
    $.press 'w:down'

    $.preventDefaultKey 'w', true
    $.on 'w:down.stop-forward', =>
      @stopForward()
      $.press 'w:down'

  ###* @type import('./type/movement').MovementG['stopForward'] ###
  stopForward: ->

    @isForwarding = false
    console.log 'auto forward [OFF]'
    $.press 'w:up'

    $.preventDefaultKey 'w', false
    $.off 'w:down.stop-forward'

# @ts-ignore
Movement = new MovementG()