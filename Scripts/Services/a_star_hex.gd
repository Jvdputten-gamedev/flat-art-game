extends AStar2D
class_name AStar2DHex

var _tilemap: TileMap

func _ready():
	pass

func _init(tilemap: TileMap) -> void:
	self._tilemap = tilemap
	_initialize_astar_grid()
	BattleEventBus.connect("CombatantMoved", _on_combatant_moved)
	print("connect to combatantmoved")

	
func _initialize_astar_grid() -> void:
	var grid_size = _tilemap.get_used_rect().size
	self.reserve_space(grid_size.x * grid_size.y)
	update()

func _compute_cost(from_id: int, to_id: int):
	# connected points are always adjacent, the cost is always 1
	# The actual cost is defined in the add_point function
	return 1


func _get_astar_cell_id(cell: Vector2i) -> int:
	var id = abs(hash(str(cell.x) + str(cell.y)))
	return id

func update() -> void:
	var cells = _tilemap.get_ground_cells()
	_update_astar_grid_points(cells)
	_update_astar_connections(cells)

func _update_astar_grid_points(cells: Array[Vector2i]) -> void:
	clear()
	# Loop through all cells in the grid and add them as points in the astar grid
	for cell in cells:
		var id = _get_astar_cell_id(cell)
		self.add_point(id, _tilemap.map_to_local(cell))
	

func _update_astar_connections(cells: Array[Vector2i]) -> void:
	for cell in cells:
		_update_neighbor_connections(cell)
	

func _update_neighbor_connections(cell_coord: Vector2i) -> void:
	var id = _get_astar_cell_id(cell_coord)
	var neighbors = _tilemap.get_surrounding_ground_cells(cell_coord)
	for neighbor in neighbors:
		var to_id = _get_astar_cell_id(neighbor)
		self.connect_points(id, to_id, false)

func _occupy_cell(cell: Vector2i):
	var cell_id = _get_astar_cell_id(cell)
	set_point_disabled(cell_id, true)

func _free_cell(cell: Vector2i):
	var cell_id = _get_astar_cell_id(cell)
	set_point_disabled(cell_id, false)

func get_local_point_path(from_pos: Vector2, to_pos: Vector2) -> PackedVector2Array:
	var from_cell = _tilemap.local_to_map(from_pos)
	var to_cell = _tilemap.local_to_map(to_pos)
	
	var from_id = _get_astar_cell_id(from_cell)
	var to_id = _get_astar_cell_id(to_cell)
	if self.has_point(from_id) and self.has_point(to_id):
		return Array(self.get_point_path(from_id, to_id))
	return [] 

func compute_move_cost(from_cell: Vector2i, to_cell: Vector2i) -> int:
	var from_id = _get_astar_cell_id(from_cell)
	var to_id = _get_astar_cell_id(to_cell)

	return self.get_point_path(from_id, to_id).size() - 1

### Signal responses ###
func _on_combatant_moved(_combatant, from_cell, to_cell):
	var from_id = _get_astar_cell_id(from_cell)
	var to_id = _get_astar_cell_id(to_cell)

	_free_cell(from_cell)
	_occupy_cell(to_cell)
