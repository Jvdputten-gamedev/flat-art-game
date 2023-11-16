extends Service

var _tilemap: TileMap
var _astar: AStar2DHex

func _ready() -> void:
	print("Navigation service ready")
	
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




