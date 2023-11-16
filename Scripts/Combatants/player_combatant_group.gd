extends Node2D


var navigation_service: Node
@export var player: Node2D

func initialize() -> void:
	player = $CharacterViewport
	navigation_service = ServiceLocator.get_navigation_service()

	player.position = navigation_service.map_to_local(Vector2i(0,0))


func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("LMB"):
			if player.is_moving():
				return

			var to_position = get_local_mouse_position()
			var from_position = player.position
			var path = navigation_service.get_local_point_path(from_position, to_position)
			player.move_along_path(path)
