extends Node

@export var level_size: int = 5
@export var basic_tile: PackedScene


func spawn_base_level():
	print("  2.1 Spawning level")
	var origin = HexCell.new(Vector2(0,0))
	var hexes = origin.get_all_hexes_within(level_size, true)
	for hex in hexes:
		ServiceLocator.tile_service.spawn_at(hex)
