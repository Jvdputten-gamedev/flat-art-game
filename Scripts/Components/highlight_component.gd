extends Node2D

@export var highlight_color: Color
@export var aoe_color: Color

var tilemap: TileMap
var tile_service: TileService

enum Layers {AOE = 0, HIGHLIGHT = 1}

func _ready():
	tile_service = ServiceLocator.get_tile_service()
	tilemap = $HighlightGround
	tilemap.set_layer_modulate(Layers.HIGHLIGHT, highlight_color)
	tilemap.set_layer_modulate(Layers.AOE, aoe_color)
	
func _input(event) -> void:
	if event is InputEventMouseMotion:
		_clear_highlights()

		var hex = tile_service.mouse_to_hex()
		if tile_service.tiles.has(hex.id):
			tilemap.set_cells_terrain_connect(Layers.HIGHLIGHT, [hex.oddq_coords], 0, 0)

	if event.is_action_pressed("LMB"):
		_clear_aoe()
		var hex = tile_service.mouse_to_hex()
		paint_aoe(hex.get_all_within(3))


func paint_aoe(hexes) -> void:
	var oddq_list: Array[Vector2i] = []
	for hex in hexes:
		oddq_list.append(hex.oddq_coords)
	tilemap.set_cells_terrain_connect(Layers.AOE, oddq_list, 0, 0)


func _clear_highlights():
	tilemap.clear_layer(Layers.HIGHLIGHT)

func _clear_aoe():
	tilemap.clear_layer(Layers.AOE)

