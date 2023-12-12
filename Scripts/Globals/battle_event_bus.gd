extends Node


signal PlayerTurnStart
signal PlayerTurnEnd
signal EnemyTurnStart
signal EnemyTurnEnd


signal ActionCanceled
signal TileWithCombatantClicked(tile: BasicTile)
signal AoeActive(hexes: Array[HexCell])

signal TileWithPlayerCombatantClicked