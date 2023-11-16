extends Service

var _tilemap: HexTileMap
var _astar: AStar2DHex

func _ready() -> void:
	print("Navigation service ready")
	UIEventBus.connect("MovePressed", _on_move_pressed)
	
func initialize_astar() -> void:
	_astar = AStar2DHex.new(_tilemap)

func set_tilemap(tilemap: TileMap) -> void:
	self._tilemap = tilemap

func update_astar() -> void: 
	_astar.update()

func map_to_local(coord: Vector2i) -> Vector2:
	return _tilemap.map_to_local(coord)

func get_local_point_path(from_position: Vector2i, to_position: Vector2i) -> Array:
	return _astar.get_local_point_path(from_position, to_position)

func _on_move_pressed():
	# Get the cell coordinate of the player
	var combat_service = ServiceLocator.get_combat_service()
	var player_hex = _tilemap.local_to_map(combat_service.player_position)
	var hexcell = HexCell.new(player_hex)
	var move_range = hexcell.get_all_within(3)
	_tilemap.paint_AOE_on_map(move_range)
	





