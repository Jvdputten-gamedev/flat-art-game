extends Node

@export var _state_chart: StateChart

var selected_combatant: Combatant = null

### Signal response ###
func _on_idle_state_unhandled_input(event: InputEvent):
	if event.is_action_pressed("LMB"):
		var tile = ServiceLocator.tile_service.get_tile_at_mouse_position()
		if tile.has_combatant():
			selected_combatant = tile.get_combatant()
			_state_chart.send_event("combatant_selected")
			BattleEventBus.TileWithCombatantClicked.emit(tile)
			tile.get_combatant().enable_movement_preview()
			return


func _on_combatant_clicked_state_unhandled_input(event: InputEvent):
	if event.is_action_pressed("LMB"):
		var tile = ServiceLocator.tile_service.get_tile_at_mouse_position()
		if ServiceLocator.tile_service.tile_in_aoe(tile):
			selected_combatant.disable_movement_preview()
			selected_combatant.move(tile)
			ServiceLocator.tile_service.highlight_component.clear_aoe()
			_state_chart.send_event("action_canceled")

	if event.is_action_pressed("RMB"):
		_state_chart.send_event("action_canceled")
		selected_combatant.disable_movement_preview()
		BattleEventBus.ActionCanceled.emit()
		selected_combatant = null
		return
	
	
func _on_player_turn_state_unhandled_input(event:InputEvent):
	if event is InputEventMouseMotion:
		ServiceLocator.tile_service.highlight()
