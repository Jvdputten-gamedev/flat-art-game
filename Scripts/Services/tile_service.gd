extends Service
class_name TileService


@export var basic_tile: PackedScene

var tiles: Dictionary = {}
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
	var hex = local_to_hex(get_local_mouse_position())
	return hex

func mouse_to_hex_center():
	var hex: HexCell = mouse_to_hex()
	return hex.to_point()

func get_tile_at_mouse_position() -> BasicTile:
	var hex = mouse_to_hex()
	if tiles.has(hex.id):
		var tile = tiles[hex.id]
		return tile
	else:
		return null

func delete(tile: BasicTile):
	if tile:
		tile.queue_free()
		tiles.erase(tile.id)

func delete_tile_at_mouse_position():
	var tile = get_tile_at_mouse_position()
	delete(tile)

func spawn_at(hex: HexCell):

	if !tiles.has(hex.id):
		var tile = basic_tile.instantiate().initialize(hex)
		EventBus.emit_signal("TileSpawn", tile)
		tiles[hex.id] = tile

func spawn_tile_at_mouse_position():
	spawn_at(mouse_to_hex())



