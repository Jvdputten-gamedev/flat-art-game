extends Node2D


var navigation_service: Node
var combat_service: Node
@export var player: Node2D

func initialize() -> void:
	navigation_service = ServiceLocator.get_navigation_service()
	combat_service = ServiceLocator.get_combat_service()

	player.position = navigation_service.map_to_local(Vector2i(0,0))
	combat_service.player_position = player.position


func _input(event) -> void:
	if event is InputEventMouseButton:
		if event.is_action_pressed("RMB"):
			print(player.is_moving())
		if event.is_action_pressed("LMB"):
			if player.is_moving():
				return

			var to_position = get_local_mouse_position()
			var from_position = player.position
			var path = navigation_service.get_local_point_path(from_position, to_position)
			print(path)
			player.move_along_path(path)
