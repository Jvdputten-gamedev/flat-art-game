extends Node2D

@export var tilemap: TileMap
@export var player: Node2D
@export var starting_pos: Vector2i
var _astar: AStar2DHex


func _ready() -> void:
	player.position = tilemap.map_to_local(starting_pos)
	_astar = AStar2DHex.new(tilemap)


func _input(event) -> void:
	if event is InputEventMouseMotion:
		tilemap.clear_highlight()
		var hex_coords = tilemap.local_to_map(get_local_mouse_position())
		if tilemap.cell_has_ground(hex_coords):
			tilemap.paint_highlight_on_map([hex_coords])
	
	if event is InputEventMouseButton:
		if event.is_action_pressed("LMB"):
			var to_position = get_local_mouse_position()
			var from_position = player.position

			var path = Array(_astar.get_point_path_from_positions(from_position, to_position))
			player.move_along_path(path)
