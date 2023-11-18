extends CombatantGroup

@export var player: Node2D

func initialize() -> void:
	super.initialize()

	player.position = navigation_service.map_to_local(Vector2i(0,0))
	combat_service.player_position = player.position
	combat_service.player_range = 3


func start_turn() -> void:
	print("Start player turn")


func _unhandled_input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("LMB"):
			if player.is_moving():
				return

			var to_position = get_local_mouse_position()
			var from_position = player.position

			var path = navigation_service.get_local_point_path(from_position, to_position)
			player.move_along_path(path)
