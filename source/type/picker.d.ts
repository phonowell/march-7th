export class PickerG extends KeyBinding {
  private listShapeForbidden: [number, number][]
  namespace: 'picker'
  private tsPick: number
  constructor()
  private checkShape(p: [number, number]): boolean
  init(): void
  private listen(): void
  next(): void
  private skip(): boolean
}
