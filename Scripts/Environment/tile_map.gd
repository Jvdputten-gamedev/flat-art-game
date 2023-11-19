extends TileMap
class_name HexTileMap

const TERRAIN_SET = 0
const HIGHLIGHT_TERRAIN = 0

enum Layers {WATER = 0, GROUND = 1, AOE = 2, HIGHLIGHT = 3}

@export var player: Node2D

var _cell_data: Dictionary


func initialize():
	print(" Initialize tile map")
	var navigation_service = ServiceLocator.get_navigation_service()
	navigation_service.tilemap = self
	initialize_cell_data()
	set_cell_data(Vector2i(0,0), player)

func initialize_cell_data():
	_cell_data = {}
	var cells = get_ground_cells()
	for cell_coord in cells:
		_cell_data[cell_coord] = null

func get_cell_data(cell_coord: Vector2i):
	return _cell_data[cell_coord]

func set_cell_data(cell_coord: Vector2i, value: Object):
	_cell_data[cell_coord] = value


func paint_highlight_on_map(cells: Array[Vector2i]):
	cells = _intersect_with_ground(cells)
	set_cells_terrain_connect(Layers.HIGHLIGHT, cells, TERRAIN_SET, HIGHLIGHT_TERRAIN)

func paint_AOE_on_map(cells):
	cells = _intersect_with_ground(cells)	
	set_cells_terrain_connect(Layers.AOE, cells, TERRAIN_SET, HIGHLIGHT_TERRAIN)

func clear_highlight() -> void:
	clear_layer(Layers.HIGHLIGHT)

func clear_AOE() -> void:
	clear_layer(Layers.AOE)
	
func _intersect_with_ground(cells: Array[Vector2i]) -> Array[Vector2i]:
	var out: Array[Vector2i] = []
	for cell in cells:
		if cell_has_ground(cell):
			out.append(cell as Vector2i)
	return out

func get_ground_cells() -> Array[Vector2i]:
	return get_used_cells(Layers.GROUND)

func get_AOE_cells() -> Array[Vector2i]:
	return get_used_cells(Layers.AOE)

func get_random_available_cell() -> Vector2i:
	var cells = get_ground_cells()
	return cells.pick_random()

func get_ground_data(cell_coord: Vector2i) -> TileData:
	return get_cell_tile_data(Layers.GROUND, cell_coord)

func cell_has_ground(cell_coord: Vector2i) -> bool:
	var data = get_cell_tile_data(Layers.GROUND, cell_coord)
	if data:
		return true
	else:
		return false

func get_surrounding_ground_cells(cell_coord: Vector2i) -> Array[Vector2i]:
	var out: Array[Vector2i] = []
	var neighbors = get_surrounding_cells(cell_coord)
	for neighbor in neighbors:
		if cell_has_ground(neighbor):
			out.append(neighbor as Vector2i)
	return out


func _input(event) -> void:
	if event is InputEventMouseMotion:
		clear_highlight()
		var cell_coord = local_to_map(get_local_mouse_position())
		if cell_has_ground(cell_coord):
			paint_highlight_on_map([cell_coord])

	if event.is_action_pressed("LMB"):
		var cell_coord = local_to_map(get_local_mouse_position())
		print(get_cell_data(cell_coord))
		


	
	
