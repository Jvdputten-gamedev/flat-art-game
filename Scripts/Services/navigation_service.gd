extends Service

var tilemap: HexTileMap
var _astar: AStar2DHex

func _ready() -> void:
	UiEventBus.connect("MovePressed", _on_move_pressed)

	
func initialize() -> void:
	print("  3.1 Initialize navigation service, setup pathfinding")
	_astar = AStar2DHex.new(tilemap)

func set_tilemap(map: TileMap) -> void:
	self.tilemap = map

func update_astar() -> void: 
	_astar.update()

func get_cell_at_local_mouse_position() -> Vector2i:
	return tilemap.local_to_map(get_local_mouse_position())

func is_local_mouse_position_in_AOE() -> bool:
	var mouse_cell = get_cell_at_local_mouse_position()
	if mouse_cell in tilemap.get_AOE_cells():
		return true
	else: 
		return false

func get_random_available_position():
	return map_to_local(tilemap.get_random_available_cell())


func map_to_local(coord: Vector2i) -> Vector2:
	return tilemap.map_to_local(coord)

func local_to_map(_position: Vector2) -> Vector2i:
	return tilemap.local_to_map(_position)

func get_local_point_path(from_position: Vector2i, to_position: Vector2i) -> Array:
	return _astar.get_local_point_path(from_position, to_position)


### Signal responses ###
### ---------------- ###

func _on_move_pressed():
	# Get the cell coordinate of the player
	var combat_service = ServiceLocator.get_combat_service()
	var player_hex = tilemap.local_to_map(combat_service.player_position)
	var hexcell = HexCell.new(player_hex)
	var cells_in_range = hexcell.get_all_within(combat_service.player_range)
	tilemap.paint_AOE_on_map(cells_in_range)




	
	





