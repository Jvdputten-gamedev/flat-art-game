extends Node2D

@export var highlight: Node2D

func initialize() -> void:
	print("2. Initialize environment.")
	highlight.initialize()
	EventBus.connect("TileSpawn", _on_tile_spawn)


func _on_tile_spawn(tile: BasicTile) -> void:
	$GroundTiles.add_child(tile)




