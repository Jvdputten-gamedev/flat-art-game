extends Service
class_name TileService


@export var basic_tile: PackedScene
@export var highlight_component: HighlightComponent

var tiles: Dictionary = {}
var hex_size: float = 128  # Defined as the distance between center and right corner in pixels.

func _ready():
	pass

func highlight() -> void:
	highlight_component.paint_highlight(mouse_to_hex())

func has_id(tile_id: int) -> bool:
	return tiles.has(tile_id)

func tile_in_aoe(tile: BasicTile) -> bool:
	var aoe = highlight_component.get_aoe_hexes()
	for hex in aoe:
		if hex.id == tile.id:
			return true
	return false

func local_to_hex(point: Vector2) -> HexCell:
	"""
	[ 2/3, 0  
	-1/3, 1]
	"""

	var q = (2./3 * point.x) / hex_size
	var r = (-1./3 * point.x + point.y) / hex_size

	var hex = HexCell.new(Vector2(q, r))
	return hex

func local_to_tile(point: Vector2) -> BasicTile:
	var hex = local_to_hex(point)
	if tiles.has(hex.id):
		return tiles[hex.id]
	else:
		return null

func mouse_to_hex() -> HexCell:
	var hex = local_to_hex(get_local_mouse_position())
	return hex

func mouse_to_hex_center():
	var hex: HexCell = mouse_to_hex()
	return hex.to_point()

func get_tile_at_mouse_position() -> BasicTile:
	var hex = mouse_to_hex()
	return get_tile(hex.id)

func get_tile_at_position(pos: Vector2) -> BasicTile:
	var hex = local_to_hex(pos)
	return get_tile(hex.id)	

func get_tile(tile_id: int) -> BasicTile:
	if tiles.has(tile_id):
		return tiles[tile_id]
	else:
		return null

func intersect_with_available(hexes: Array[HexCell]) -> Array[HexCell]:
	return hexes.filter(func(hex): return tiles.has(hex.id))

func delete(tile: BasicTile):
	if tile:
		tile.queue_free()
		tiles.erase(tile.id)
		ServiceLocator.navigation_service.update_astar()

func delete_tile_at_mouse_position():
	var tile = get_tile_at_mouse_position()
	delete(tile)

func spawn_at(hex: HexCell) -> BasicTile:
	var tile
	if !tiles.has(hex.id):
		tile = basic_tile.instantiate().initialize(hex)
		tiles[hex.id] = tile

		EventBus.SpawnTile.emit(tile)
		ServiceLocator.navigation_service.update_astar()
	return tile

func get_random_available_tile() -> BasicTile:
	return tiles.values()[randi() % tiles.size()]

func spawn_tile_at_mouse_position():
	spawn_at(mouse_to_hex())




