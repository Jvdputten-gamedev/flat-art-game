extends AStar2D
class_name AStar2DHex


var _grid_size: Vector2i
var _tilemap: TileMap

func _init(tilemap: TileMap) -> void:
	self._tilemap = tilemap
	_initialize_astar_grid()
	var cells = tilemap.get_surrounding_cells(Vector2i(1,4))
	for cell in cells:
		print(_get_astar_cell_id(cell))
	


func _initialize_astar_grid() -> void:
	_grid_size = _tilemap.get_used_rect().size
	self.reserve_space(_grid_size.x * _grid_size.y)
	update()

func _get_astar_cell_id(cell: Vector2i) -> int:
	return cell.y + cell.x*_grid_size.y

func update() -> void:
	_update_astar_grid_points()
	_update_astar_connections()

func _update_astar_grid_points() -> void:
	clear()
	# Loop through all cells in the grid and add them as points in the astar grid
	for i in _grid_size.x:
		for j in _grid_size.y:
			var cell_coord = Vector2i(i,j)
			var idx = _get_astar_cell_id(cell_coord)
			if _tilemap.cell_has_ground(cell_coord):
				self.add_point(idx, _tilemap.map_to_local(cell_coord))
	

func _update_astar_connections() -> void:
	var cells = _tilemap.get_ground_cells()
	for cell_coord in cells:
		_update_neighbor_connections(cell_coord)
	

func _update_neighbor_connections(cell_coord: Vector2i) -> void:
	var id = _get_astar_cell_id(cell_coord)
	var neighbors = _tilemap.get_surrounding_cells(cell_coord)
	for neighbor in neighbors:
		var to_id = _get_astar_cell_id(neighbor)
		if self.has_point(to_id):
			self.connect_points(id, to_id, false)

func get_point_path_from_positions(from_pos: Vector2i, to_pos: Vector2i) -> PackedVector2Array:
	var from_cell = _tilemap.local_to_map(from_pos)
	var to_cell = _tilemap.local_to_map(to_pos)
	var from_id = _get_astar_cell_id(from_cell)
	var to_id = _get_astar_cell_id(to_cell)
	if self.has_point(from_id) and self.has_point(to_id):
		return self.get_point_path(from_id, to_id)
	return [] 




