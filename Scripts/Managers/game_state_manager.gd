extends Node

@export var _state_chart: StateChart



### Signal response ###
func _on_idle_state_unhandled_input(event):
	if event.is_action_pressed("LMB"):
		var tile = ServiceLocator.tile_service.get_tile_at_mouse_position()
		if tile.has_combatant():
			_state_chart.send_event("combatant_clicked")
			BattleEventBus.TileWithCombatantClicked.emit(tile)
			return

