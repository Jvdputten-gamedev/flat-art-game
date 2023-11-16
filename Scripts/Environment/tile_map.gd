extends TileMap

const TERRAIN_SET = 0
const HIGHLIGHT_TERRAIN = 0

enum Layers {WATER = 0, GROUND = 1, HIGHLIGHT = 2, AOE = 3}

func _ready():
	print("Tile map ready")

func initialize():
	var navigation_service = ServiceLocator.get_navigation_service()
	navigation_service._tilemap = self

func paint_highlight_on_map(coordinates):
	set_cells_terrain_connect(Layers.HIGHLIGHT, coordinates, TERRAIN_SET, HIGHLIGHT_TERRAIN)

func clear_highlight() -> void:
	clear_layer(Layers.HIGHLIGHT)

func get_ground_cells() -> Array[Vector2i]:
	return get_used_cells(Layers.GROUND)

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
		var hex_coords = local_to_map(get_local_mouse_position())
		if cell_has_ground(hex_coords):
			paint_highlight_on_map([hex_coords])


	
	
