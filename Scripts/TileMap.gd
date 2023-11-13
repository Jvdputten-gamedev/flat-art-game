extends TileMap

enum Layers {WATER = 0, GROUND = 1, HIGHLIGHT = 2, AOE = 3}
const TERRAIN_SET = 0
const HIGHLIGHT_TERRAIN = 0

func paint_highlight_on_map(coordinates):
	set_cells_terrain_connect(Layers.HIGHLIGHT, coordinates, TERRAIN_SET, HIGHLIGHT_TERRAIN)

func clear_highlight() -> void:
	clear_layer(Layers.HIGHLIGHT)

func hex_has_ground(hex_coords) -> bool:
	var data = get_cell_tile_data(Layers.GROUND, hex_coords)
	if data:
		return true
	else:
		return false


	
	
