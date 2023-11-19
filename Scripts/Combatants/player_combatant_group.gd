extends CombatantGroup

@export var player: Combatant

func initialize() -> void:
	print("  4.1 Initializing player combatant group")
	super.initialize()



func start_turn() -> void:
	pass
func _unhandled_input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("LMB"):
			if player.is_moving():
				return

			var to_cell = navigation_service.get_cell_at_local_mouse_position()
			if to_cell in navigation_service.tilemap.get_ground_cells():
				player.cell_coord = to_cell

			var path = navigation_service.get_local_point_path(player.position, get_local_mouse_position())
			player.move_along_path(path)


func _on_player_turn_state_unhandled_input(event) -> void:
	# If clicked outside highlight area, cancel action
	if event.is_action_pressed("LMB"):
		navigation_service.tilemap.clear_AOE()
		BattleEventBus.emit_signal("ActionEnded")
		print("Back to base")


func _on_move_state_unhandled_input(event) -> void:
	if event.is_action_pressed("LMB"):
		# If clicked in hightlighted area, perform action
		if navigation_service.is_local_mouse_position_in_AOE():
			print("Moving")
			BattleEventBus.emit_signal("ActionEnded")

