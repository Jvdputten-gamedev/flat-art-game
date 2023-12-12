extends AStar2D
class_name AStar2DHex

var tile_service: TileService

func _ready():
	pass

func _init() -> void:
	tile_service = ServiceLocator.get_tile_service()
	update()

func _compute_cost(from_id: int, to_id: int):
	# connected points are always adjacent, the cost is always 1
	# The actual cost is defined in the add_point function
	return 1

func update() -> void:
	_update_astar_grid_points()
	_update_astar_connections()

func _update_astar_grid_points() -> void:
	clear()
	# Loop through all hexes in the grid and add them as points in the astar grid
	for tile in tile_service.tiles.values():
		self.add_point(tile.id, tile.to_point())
	
func _update_astar_connections() -> void:
	for tile in tile_service.tiles.values():
		_update_neighbor_connections(tile)
	
func _update_neighbor_connections(tile: BasicTile) -> void:
	var neighbors = tile.get_all_adjacent()
	for neighbor in neighbors:
		if tile_service.has_id(neighbor.id):
			self.connect_points(tile.id, neighbor.id, false)

func occupy(hex: HexCell):
	set_point_disabled(hex.id, true)

func vacate(hex: HexCell):
	set_point_disabled(hex.id, false)

func get_local_point_path(from_pos: Vector2, to_pos: Vector2) -> PackedVector2Array:
	var from_hex = tile_service.local_to_hex(from_pos)
	var to_hex = tile_service.local_to_hex(to_pos)
	
	if self.has_point(from_hex.id) and self.has_point(to_hex.id):
		return Array(self.get_point_path(from_hex.id, to_hex.id))
	return [] 

func compute_move_cost(from_hex: HexCell, to_hex: HexCell) -> int:
	return self.get_point_path(from_hex.id, to_hex.id).size() - 1


