extends Service
class_name TileService


@export var tilemap: TileMap
@export var basic_tile: PackedScene
@export var tile_container: Node2D

var tiles: Dictionary

var hex_size: float = 128  # Defined as the distance between center and right corner in pixels


func get_used_tiles():
	return tiles.values()	

func local_to_hex(point: Vector2) -> HexCell:
	"""
	[ 2/3, 0  
	-1/3, 1]
	"""
	var q = (2./3 * point.x) / hex_size
	var r = (-1./3 * point.x + point.y) / hex_size
	var hex = HexCell.new(Vector2(q, r))
	return hex


func mouse_to_hex() -> HexCell:
	return local_to_hex(get_local_mouse_position())

func mouse_to_hex_center():
	var hex: HexCell = mouse_to_hex()
	return hex.to_point()


