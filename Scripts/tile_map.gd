extends TileMap

const TERRAIN_SET = 0
const HIGHLIGHT_TERRAIN = 0

enum Layers {WATER = 0, GROUND = 1, HIGHLIGHT = 2, AOE = 3}

func paint_highlight_on_map(coordinates):
	set_cells_terrain_connect(Layers.HIGHLIGHT, coordinates, TERRAIN_SET, HIGHLIGHT_TERRAIN)

func clear_highlight() -> void:
	clear_layer(Layers.HIGHLIGHT)

func get_ground_cells() -> Array[Vector2i]:
	return get_used_cells(Layers.GROUND)

func get_ground_data(cell_coords) -> TileData:
	return get_cell_tile_data(Layers.GROUND, cell_coords)

func cell_has_ground(cell_coords) -> bool:
	var data = get_cell_tile_data(Layers.GROUND, cell_coords)
	if data:
		return true
	else:
		return false

func get_surrounding_ground_cells(cell_coord) -> Array:
	var out = Array()
	var neighbors = get_surrounding_cells(cell_coord)
	for neighbor in neighbors:
		if cell_has_ground(neighbor):
			out.append(neighbor)
	return out 



	
	
