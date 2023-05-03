type Name = 'free'
type NameNot = `not-${Name}`
type NamePossible = Name | NameNot

export class StateG extends EmitterShell {
  private cache: object
  private list: Name[]
  namespace: 'state'
  constructor()
  private checkIsFree(): boolean
  init(): void
  is(...names: NamePossible[]): boolean
  private makeListName(): Name[]
  private throttle(id: string, interval: number, fn: () => boolean): boolean
  update(): void
}
