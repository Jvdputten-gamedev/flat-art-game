extends Node

@export var _state_chart: StateChart

var selected_combatant: Combatant = null

### Signal response ###
func _on_idle_state_unhandled_input(event: InputEvent):
	if event.is_action_pressed("LMB"):
		var tile = ServiceLocator.tile_service.get_tile_at_mouse_position()
		if tile.has_combatant():
			selected_combatant = tile.get_combatant()
			_state_chart.send_event("combatant_clicked")
			BattleEventBus.TileWithCombatantClicked.emit(tile)
			tile.get_combatant().enable_movement_preview()
			return


func _on_combatant_clicked_state_unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		var tile = ServiceLocator.tile_service.get_tile_at_mouse_position()
		if tile:
			if ServiceLocator.tile_service.tile_in_aoe(tile):
				selected_combatant.enable_movement_preview()
			else:
				selected_combatant.disable_movement_preview()
		

func _on_player_turn_state_unhandled_input(event:InputEvent):
	if event is InputEventMouseMotion:
		ServiceLocator.tile_service.highlight()
