export class MovementG extends KeyBinding {
  direction: string[]
  isForwarding: boolean
  isMoving: boolean
  namespace: 'movement'
  constructor()
  private aboutForward(): void
  private aboutMove(): void
  init(): void
  private report(): void
  sprint(): void
  private startForward(): void
  stopForward(): void
}
