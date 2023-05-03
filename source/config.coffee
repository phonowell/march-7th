# @ts-check

class ConfigG extends EmitterShell

  constructor: ->
    super()

    ###* @type import('./type/config').ConfigG['data'] ###
    @data = {
      'basic/arguments': ''
      'basic/path': ''
      'basic/process': ''
      'better-pickup/enable': '0'
      'misc/use-beep': '0'
      'misc/use-debug-mode': '0'
      'misc/use-mute': '0'
    }

    ###* @type import('./type/config').ConfigG['namespace'] ###
    @namespace = 'config'

    ###* @type import('./type/config').ConfigG['source'] ###
    @source = 'config.ini'

  ###* @type import('./type/config').ConfigG['detectRegion'] ###
  detectPath: ->
    name = "ahk_exe #{@get 'basic/process'}"

    $.noop name
    path = ''
    Native 'WinGet, path, ProcessPath, % name'

    @write 'basic/path', path
    return

  ###* @type import('./type/config').ConfigG['detectRegion'] ###
  detectRegion: ->

    if @read 'basic/process' then return true

    @write 'basic/process', 'StarRail.exe'
    return undefined

  ###* @type import('./type/config').ConfigG['get'] ###
  get: (ipt) -> @data[ipt]

  ###* @type import('./type/config').ConfigG['init'] ###
  init: ->
    Dictionary.noop() # for keeping loading order
    unless @detectRegion() then return
    @load()

  ###* @type import('./type/config').ConfigG['load'] ###
  load: ->

    # basic
    @register 'basic/path'
    @set 'basic/process', @read 'basic/process', 'GenshinImpact.exe'

    # better-pickup
    @register 'better-pickup/enable', 'alt + f'

    # misc
    @register 'misc/use-beep'
    @register 'misc/use-debug-mode'
    @register 'misc/use-mute'

    @emit 'change'

  ###* @type import('./type/config').ConfigG['read'] ###
  read: (ipt, defaultValue = '') ->
    [section, key] = $.split ipt, '/'
    $.noop section, key
    result = ''
    Native 'IniRead, result, % this.source, % section, % key, % A_Space'
    unless result then return $.toLowerCase defaultValue
    return $.toLowerCase result

  ###* @type import('./type/config').ConfigG['register'] ###
  register: (ipt, key = '') ->

    # set value
    @set ipt, @read ipt, '0'

    unless key then return

    # register toggling key
    $.preventDefaultKey key, true
    $.on key, =>
      @toggle ipt
      @emit 'change'

  ###* @type import('./type/config').ConfigG['set'] ###
  set: (ipt, value) ->
    @data[ipt] = value
    return

  ###* @type import('./type/config').ConfigG['toggle'] ###
  toggle: (ipt) ->
    if @get ipt
      @set ipt, $.toString false
      @write ipt, '0'
      console.log "#{ipt}: OFF"
    else
      @set ipt, $.toString true
      @write ipt, '1'
      console.log "#{ipt}: ON"
    return

  ###* @type import('./type/config').ConfigG['write'] ###
  write: (ipt, value) ->
    [section, key] = $.split ipt, '/'
    value = " #{value}"
    $.noop section, key
    Native 'IniWrite, % value, % this.source, % section, % key'
    return

# @ts-ignore
Config = new ConfigG()