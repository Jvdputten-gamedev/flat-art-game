extends CombatantGroup

@export var player: Node2D

func initialize() -> void:
	super.initialize()

	combat_service.player_position = player.position
	combat_service.player_range = 3


func start_turn() -> void:
	print("Start player turn")


# func _unhandled_input(event) -> void:
# 	if event is InputEventMouseButton:
# 		if event.is_action_pressed("LMB"):
# 			if player.is_moving():
# 				return

# 			var to_position = get_local_mouse_position()
# 			var from_position = player.position

# 			var path = navigation_service.get_local_point_path(from_position, to_position)
# 			player.move_along_path(path)


func _on_player_turn_state_unhandled_input(event) -> void:
	# If clicked outside highlight area, cancel action
	if event.is_action_pressed("LMB"):
		print("Clicked anywhere canceling action")
		navigation_service.tilemap.clear_AOE()
		BattleEventBus.emit_signal("ActionCanceled")


func _on_move_state_unhandled_input(event) -> void:
	if event.is_action_pressed("LMB"):
		# If clicked in hightlighted area, perform action
		if navigation_service.is_local_mouse_position_in_AOE():
			print("Moving")
			BattleEventBus.emit_signal("ActionCanceled")
