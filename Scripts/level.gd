extends Node2D

@export var tilemap: TileMap
@export var player: Node2D
@export var starting_pos: Vector2i


func _ready() -> void:
	player.position = tilemap.map_to_local(starting_pos)

func _input(event) -> void:
	if event is InputEventMouseMotion:
		tilemap.clear_highlight()
		var hex_coords = tilemap.local_to_map(get_local_mouse_position())
		if tilemap.hex_has_ground(hex_coords):
			tilemap.paint_highlight_on_map([hex_coords])
	
	if event is InputEventMouseButton:
		if event.button_index == 1:
			var hex_coords = tilemap.local_to_map(get_local_mouse_position())
			if tilemap.hex_has_ground(hex_coords):
				var to_position = tilemap.map_to_local(hex_coords)
				player.move_to_position(to_position)