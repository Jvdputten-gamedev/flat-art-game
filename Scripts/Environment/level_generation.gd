extends Node

@export var level_size: int = 5
@export var basic_tile: PackedScene
@export var tile_container: Node2D


func spawn_base_level():
	print("  2.1 Spawning level")
	var tile_service = ServiceLocator.get_tile_service()
	var origin = HexCell.new(Vector2(0,0))
	var hexes = origin.get_all_within(level_size, true)
	for hex in hexes:
		var tile = tile_service.spawn_at(hex)
		tile_container.add_child(tile)
