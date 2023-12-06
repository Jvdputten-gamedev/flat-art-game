extends Node2D

@export var highlight_color: Color
@export var aoe_color: Color

var tilemap: TileMap
var tile_service: TileService

enum Layers {AOE = 0, HIGHLIGHT = 1}

func _ready():
	tilemap = $HighlightGround
	tilemap.set_layer_modulate(Layers.HIGHLIGHT, highlight_color)
	tilemap.set_layer_modulate(Layers.AOE, aoe_color)
	tile_service = ServiceLocator.get_tile_service()
	
func _input(event) -> void:
	if event is InputEventMouseMotion:
		_clear_highlights()
		
		var hex = tile_service.mouse_to_hex()
		if tile_service.tiles.has(hex.id):
			tilemap.set_cells_terrain_connect(Layers.HIGHLIGHT, [hex.oddq_coords], 0, 0)

func paint_aoe(hexes) -> void:
	_clear_aoe()
	var oddq_list: Array[Vector2i] = []
	for hex in hexes:
		if tile_service.tiles.has(hex.id):
			oddq_list.append(hex.oddq_coords)
	tilemap.set_cells_terrain_connect(Layers.AOE, oddq_list, 0, 0)


func highlight_player_spawn() -> void:
	"""
	(-2, -2) -> (-2, 4)
	(-3, -1) -> (-3, 4)
	(-4, 0) -> (-4, 4)
	"""
	var hexes: Array[HexCell] = []
	# row -2
	for q in range(-2, 5):
		hexes.append(HexCell.new(Vector2(-2, q)))
	# row -1
	for q in range(-1, 5):
		hexes.append(HexCell.new(Vector2(-3, q)))
	# row -0
	for q in range(0, 5):
		hexes.append(HexCell.new(Vector2(-4, q)))
	paint_aoe(hexes)
		

func highlight_enemy_spawn() -> void:
	"""
	(2, -4) -> (2, 2)
	(3, -4) -> (3, 1)
	(4, -4) -> (4, 0)
	"""
	var hexes: Array[HexCell] = []
	# row 2
	for q in range(-4, 3):
		hexes.append(HexCell.new(Vector2(2, q)))
	# row 3
	for q in range(-4, 2):
		hexes.append(HexCell.new(Vector2(3, q)))
	# row 4
	for q in range(-4, 1):
		hexes.append(HexCell.new(Vector2(4, q)))
	paint_aoe(hexes)

func _clear_highlights():
	tilemap.clear_layer(Layers.HIGHLIGHT)

func _clear_aoe():
	tilemap.clear_layer(Layers.AOE)

