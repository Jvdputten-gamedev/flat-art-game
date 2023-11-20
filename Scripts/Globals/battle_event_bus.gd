extends Node


signal PlayerTurnStart
signal PlayerTurnEnd
signal EnemyTurnStart
signal EnemyTurnEnd


signal ActionCanceled
signal CombatantMoved(combatant: Combatant, from_cell: Vector2i, to_cell: Vector2i)
signal CombatantClicked()