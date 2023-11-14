extends AStar2D
class_name AStar2DHex


var _grid_size: Vector2i
var _tilemap: TileMap
var _astar_cell_id: Dictionary

func _init(tilemap: TileMap) -> void:
	self._tilemap = tilemap
	_initialize_astar_grid()
		


func _initialize_astar_grid() -> void:
	_grid_size = _tilemap.get_used_rect().size
	print(_grid_size)
	self.reserve_space(_grid_size.x * _grid_size.y)
	update()

func _get_astar_cell_id(cell: Vector2i) -> int:
	return _astar_cell_id[cell]

func _set_astar_cell_id() -> void:
	_astar_cell_id = {}
	var i = 0
	for cell in _tilemap.get_ground_cells():
		_astar_cell_id[cell] = i
		i = i + 1
	print(_astar_cell_id)

func update() -> void:
	_set_astar_cell_id()
	_update_astar_grid_points()
	_update_astar_connections()

func _update_astar_grid_points() -> void:
	clear()
	# Loop through all cells in the grid and add them as points in the astar grid
	for cell in _astar_cell_id:
		print(cell)
		var id = _astar_cell_id[cell]
		self.add_point(id, _tilemap.map_to_local(cell))
	

func _update_astar_connections() -> void:
	for cell in _astar_cell_id:
		_update_neighbor_connections(cell)
	

func _update_neighbor_connections(cell_coord: Vector2i) -> void:
	var id = _get_astar_cell_id(cell_coord)
	var neighbors = _tilemap.get_surrounding_ground_cells(cell_coord)
	for neighbor in neighbors:
		var to_id = _get_astar_cell_id(neighbor)
		self.connect_points(id, to_id, false)

func get_point_path_from_positions(from_pos: Vector2i, to_pos: Vector2i) -> PackedVector2Array:
	var from_cell = _tilemap.local_to_map(from_pos)
	var to_cell = _tilemap.local_to_map(to_pos)
	var from_id = _get_astar_cell_id(from_cell)
	var to_id = _get_astar_cell_id(to_cell)
	if self.has_point(from_id) and self.has_point(to_id):
		return self.get_point_path(from_id, to_id)
	return [] 




