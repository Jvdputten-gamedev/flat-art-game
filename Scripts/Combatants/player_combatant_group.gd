extends CombatantGroup

var selected_combatant: Combatant

func initialize() -> void:
	print("  4.1 Initializing player combatant group")
	super.initialize()

func start_turn() -> void:
	pass
	

func _on_move_state_unhandled_input(event) -> void:
	if event.is_action_pressed("LMB"):
		# If clicked in hightlighted area, perform action
		if navigation_service.is_local_mouse_position_in_AOE():
			if selected_combatant.is_moving():
				return
			
			var path = navigation_service.get_local_point_path(selected_combatant.position, get_local_mouse_position())
			selected_combatant.move_along_path(path)
			selected_combatant.cell_coord  = navigation_service.get_cell_at_local_mouse_position()

		BattleEventBus.emit_signal("ActionCanceled")
		navigation_service.tilemap.clear_AOE()



func _on_base_state_unhandled_input(event):

	if event.is_action_pressed("LMB"):
		var combatant = combat_service.get_combatant_on_current_mouse_position()
		if combatant:
			selected_combatant = combatant
			combat_service.show_combatant_movement_range(combatant)
			BattleEventBus.emit_signal("CombatantClicked")
		else:
			selected_combatant = null
			
		
