extends TileMap

const HIGHLIGHT_LAYER: int = 1

func _process(_delta):
	
		erase_highlights()
		highlight_tile_under_cursor()


func erase_highlights():
		var highlighted_cells = get_used_cells(1)
		for cell in highlighted_cells:
			erase_cell(HIGHLIGHT_LAYER, cell)
			
func highlight_tile_under_cursor():
		var tile_coords = local_to_map(get_global_mouse_position())
		set_cell(HIGHLIGHT_LAYER, tile_coords, 3, Vector2i(0,0))
	
	
