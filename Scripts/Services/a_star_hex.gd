extends AStar2D
class_name AStar2DHex

var tile_service: TileService

func _ready():
	pass

func _init() -> void:
	tile_service = ServiceLocator.get_tile_service()
	_initialize_astar_grid()
	BattleEventBus.connect("CombatantMoved", _on_combatant_moved)
	print("connect to CombatantMoved")

	
func _initialize_astar_grid() -> void:
	#update()
	pass

func _compute_cost(from_id: int, to_id: int):
	# connected points are always adjacent, the cost is always 1
	# The actual cost is defined in the add_point function
	return 1


func _get_astar_cell_id(cell: Vector2i) -> int:
	var id = abs(hash(str(cell.x) + str(cell.y)))
	return id

func update() -> void:
	var tiles = tile_service.get_used_tiles()
	_update_astar_grid_points(tiles)
	_update_astar_connections(tiles)

func _update_astar_grid_points(tiles: Array[BasicTile]) -> void:
	clear()
	# Loop through all hexes in the grid and add them as points in the astar grid
	for tile in tiles:
		self.add_point(tile.id, tile.to_point())
	

func _update_astar_connections(tiles: Array[BasicTile]) -> void:
	for tile in tiles:
		_update_neighbor_connections(tile)
	

func _update_neighbor_connections(tile: BasicTile) -> void:
	var neighbors = tile.get_all_adjacent()
	for neighbor in neighbors:
		self.connect_points(tile.id, neighbor.id, false)

func _occupy_hex(tile: BasicTile):
	set_point_disabled(tile.id, true)

func _free_hex(tile: BasicTile):
	set_point_disabled(tile.id, false)

func get_local_point_path(from_pos: Vector2, to_pos: Vector2) -> PackedVector2Array:
	var from_hex = tile_service.local_to_hex(from_pos)
	var to_hex = tile_service.local_to_map(to_pos)
	
	if self.has_point(from_hex.id) and self.has_point(to_hex.id):
		return Array(self.get_point_path(from_hex.id, to_hex.id))
	return [] 

func compute_move_cost(from_hex: HexCell, to_hex: HexCell) -> int:
	return self.get_point_path(from_hex.id, to_hex.id).size() - 1

### Signal responses ###
func _on_combatant_moved(_combatant, from_hex, to_hex):
	print("Movement cost: ", self.get_point_path(from_hex.id, to_hex.id).size() - 1)

	_free_hex(from_hex)
	_occupy_hex(to_hex)
