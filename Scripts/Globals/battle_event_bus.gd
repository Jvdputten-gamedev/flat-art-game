extends Node


signal PlayerTurnStart
signal PlayerTurnEnd
signal EnemyTurnStart
signal EnemyTurnEnd


signal ActionCanceled
signal CombatantMoved(combatant: Combatant, from_hex: HexCell, to_cell: HexCell)
signal TileWithCombatantClicked(tile: BasicTile)
signal AoeActive(hexes: Array[HexCell])

signal TileWithPlayerCombatantClicked