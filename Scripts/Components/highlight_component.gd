extends Node2D

var tilemap_base: TileMap
var tilemap_highground: TileMap
@export var highlight_color: Color
@export var aoe_color: Color
@export var tilesystem: Node2D


func _ready():
	tilemap_base = $HighlightGround
	tilemap_highground = $HighlightHighground
	tilemap_highground.position.y = - tilesystem.highground_offset
	#tilemap_base.set_layer_modulate(0, highlight_color)
	#tilemap_highground.set_layer_modulate(0, highlight_color)
	
func _input(event) -> void:
	if event is InputEventMouseMotion:
		_clear_highlights()

		var hex = tilesystem.mouse_to_hex()
		print(hex)
		var tile

		if tilesystem.tiles.has(hex):
			tile = tilesystem.tiles[hex]
		else:
			return 

		# if cell.highground:
			
		# 	tilemap_highground.set_cells_terrain_connect(0, [cell_coord], 0, 0)
		# else:
		# 	tilemap_base.set_cells_terrain_connect(0, [cell_coord], 0, 0)

func _clear_highlights():
	tilemap_base.clear_layer(0)
	tilemap_highground.clear_layer(0)
