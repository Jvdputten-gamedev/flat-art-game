extends Node2D

var tilemap: TileMap
@export var highlight_color: Color
@export var aoe_color: Color
@export var tilesystem: TileSystem



func _ready():
	tilemap = $HighlightGround
	tilemap.set_layer_modulate(0, highlight_color)
	
func _input(event) -> void:
	if event is InputEventMouseMotion:
		_clear_highlights()

		var hex = tilesystem.mouse_to_hex()
		if tilesystem.tiles.has(hex.id):

			var tile = tilesystem.tiles[hex.id]
			tilemap.set_cells_terrain_connect(0, [hex.oddq_coords], 0, 0)

	if event.is_action_pressed("LMB"):
		_clear_highlights()
		var hex = tilesystem.mouse_to_hex()
		paint_aoe(hex.get_all_adjacent())


func paint_aoe(hexes) -> void:
	#var oddq_list = []
	#for hex in hexes:
		#oddq_list.append(hex.oddq_coords)
	tilemap.set_cells_terrain_connect(1, hexes, 0, 0)



func _clear_highlights():
	tilemap.clear_layer(0)

func _clear_aoe():
	tilemap.clear_layer(1)

