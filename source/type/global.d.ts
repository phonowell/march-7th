import { EmitterShell as ES } from 'node_modules/shell-ahk/dist/type/emitterShell'

import { AreaG } from './area'
import { CameraG } from './camera'
import { ClientG } from './client'
import { ColorManagerG } from './color-manager'
import { ConfigG } from './config'
import { DictionaryG } from './dictionary'
import { GdipG } from './gdip'
import { IndicatorG } from './indicator'
import { JsonG } from './json'
import { KeyBinding as KB } from './key-binding'
import { MenuG } from './menu'
import { MovementG } from './movement'
import { PickerG } from './picker'
import { PointG } from './point'
import { RecorderG } from './recorder'
import { ReplayerG } from './replayer'
import { SceneG } from './scene'
import { Scene2G } from './scene2'
import { Shell } from './shell'
import { SoundG } from './sound'
import { StateG } from './state'
import { TimerG } from './timer'
import { UtilityG } from './utility'
import { WindowG } from './window'

declare global {
  class Console {
    namespace: 'console'
    init(): void
    update(): void
  }

  class EmitterShell {
    constructor()
    on: ES['on']
    once: ES['once']
    off: ES['off']
    emit: ES['emit']
  }

  class KeyBinding extends EmitterShell {
    registerEvent: KB['registerEvent']
    unregisterEvent: KB['unregisterEvent']
  }

  const $: Shell
  const A_ScreenHeight: number
  const A_ScreenWidth: number
  const A_language: string
  const Format: (f: string, v: string | number) => string
  const GetKeyState: (key: string, type: string) => boolean
  const Native: (...args: unknown[]) => unknown
  const OnExit: (fn: Fn) => void
  const Round: (a: number, b: number) => number
  const ShiftAppVolumeTopped: (app: string, volume: number) => void
  const XInput_Init: () => void

  const XInput_GetState: (target: number) => {
    wButtons: number
    bLeftTrigger: number
    bRightTrigger: number
    sThumbLX: number
    sThumbLY: number
    sThumbRX: number
    sThumbRY: number
  }

  const Area: AreaG
  const Camera: CameraG
  const Client: ClientG
  const ColorManager: ColorManagerG
  const Config: ConfigG
  const Dictionary: DictionaryG
  const Gdip: GdipG
  const Indicator: IndicatorG
  const Json2: JsonG
  const Menu2: MenuG
  const Movement: MovementG
  const Picker: PickerG
  const Point: PointG
  const Recorder: RecorderG
  const Replayer: ReplayerG
  const Scene2: Scene2G
  const Scene: SceneG
  const Sound: SoundG
  const State: StateG
  const Timer: TimerG
  const Utility: UtilityG
  const Window2: WindowG
  const area: never
  const camera: never
  const client: never
  const colorManager: never
  const config: never
  const dictionary: never
  const gdip: never
  const indicator: never
  const json2: never
  const json: never
  const menu2: never
  const menu: never
  const movement: never
  const picker: never
  const point: never
  const recorder: never
  const replayer: never
  const scene2: never
  const scene: never
  const sound: never
  const state: never
  const timer: never
  const utility: never
  const window2: never
}

export type AreaLike = (number | string)[] | (number | string)[][]
export type Fn = (...args: unknown[]) => unknown
export type PointLike = (number | string)[]
