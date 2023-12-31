extends Node2D
class_name HighlightComponent

@export var highlight_color: Color
@export var aoe_color: Color

var tilemap: TileMap

enum Layers {AOE = 0, HIGHLIGHT = 1}

func _ready():
	tilemap = $HighlightGround
	tilemap.set_layer_modulate(Layers.HIGHLIGHT, highlight_color)
	tilemap.set_layer_modulate(Layers.AOE, aoe_color)
	BattleEventBus.TileWithCombatantClicked.connect(_on_tile_with_combatant_clicked)
	BattleEventBus.ActionCanceled.connect(clear_aoe)

func paint_highlight(hex) -> void:
	var tile_service = ServiceLocator.tile_service
	clear_highlights()
	if tile_service.tiles.has(hex.id):
		tilemap.set_cells_terrain_connect(Layers.HIGHLIGHT, [hex.oddq_coords], 0, 0)

func paint_aoe(hexes) -> void:
	clear_aoe()
	hexes = ServiceLocator.tile_service.intersect_with_available(hexes)
	var oddq_list = hexes.map(func(x): return x.oddq_coords)
	tilemap.set_cells_terrain_connect(Layers.AOE, oddq_list, 0, 0)

func get_aoe_hexes() -> Array[HexCell]:
	var out: Array[HexCell] = []
	for cell in tilemap.get_used_cells_by_id(Layers.AOE):
		out.append(HexCell.new(cell))
	return out


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

func clear_highlights():
	tilemap.clear_layer(Layers.HIGHLIGHT)

func clear_aoe():
	tilemap.clear_layer(Layers.AOE)

func show_combatant_movement_range(from: HexCell, movement_range: int):
	var hexes = from.get_all_within(movement_range)
	hexes = ServiceLocator.tile_service.intersect_with_available(hexes)
	
	var out: Array[HexCell] = []
	for to in hexes:
		var move_cost = ServiceLocator.navigation_service.compute_move_cost(from, to)
		if move_cost <= movement_range:
			out.append(to)
	paint_aoe(out)



### Signal responses ###
func _on_tile_with_combatant_clicked(tile: BasicTile):
	clear_highlights()
	var combatant = tile.get_combatant()
	show_combatant_movement_range(tile, combatant.movement_range)





