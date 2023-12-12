extends Node2D

@export var level_generator: Node2D
@export var tile_container: Node2D

func _ready() -> void:
	print("2. Initialize environment.")
	EventBus.SpawnTile.connect(_on_spawn_tile)

	level_generator.spawn_base_level()
	ServiceLocator.initialize_services()

func _on_spawn_tile(tile: BasicTile):
	tile_container.add_child(tile)


func _unhandled_input(event):
	if event.is_action_pressed("LMB"):
		var tile = ServiceLocator.tile_service.get_tile_at_mouse_position()
		print(tile.get_combatant())
		

	# if event.is_action_released("RMB"):
	# 	ServiceLocator.tile_service.delete_tile_at_mouse_position()
