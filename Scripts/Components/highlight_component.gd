extends Node2D

var tilemap_base: TileMap
var tilemap_highground: TileMap
@export var highlight_color: Color
@export var aoe_color: Color
@export var tilesystem: TileSystem



func _ready():
	tilemap_base = $HighlightGround
	tilemap_highground = $HighlightHighground
	tilemap_highground.position.y -= 32
	#tilemap_base.set_layer_modulate(0, highlight_color)
	#tilemap_highground.set_layer_modulate(0, highlight_color)
	
func _input(event) -> void:
	if event is InputEventMouseMotion:
		_clear_highlights()

		var hex = tilesystem.mouse_to_hex()
		if tilesystem.tiles.has(hex.id):
			var tile = tilesystem.tiles[hex.id]
			_set_z_index(tile)
			if tile.highground:
				tilemap_highground.set_cells_terrain_connect(0, [hex.oddq_coords], 0, 0)
			else:
				tilemap_base.set_cells_terrain_connect(0, [hex.oddq_coords], 0, 0)

func _set_z_index(tile: BasicTile):
	tilemap_base.z_index = tile.z_index
	tilemap_highground.z_index = tile.z_index

func _clear_highlights():
	tilemap_base.clear_layer(0)
	tilemap_highground.clear_layer(0)
