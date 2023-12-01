extends Node2D
class_name TileSystem


@export var tilemap: TileMap
@export var basic_tile: PackedScene
@export var tile_container: Node2D
@export var quake_delay: float = 0.1
@export var sine_time: float = 0.1
@export var transition_type: Tween.TransitionType
@export var ease_type: Tween.EaseType
@export var highground_offset: int = 32

var tiles: Dictionary

var hex_size: float = 128  # Defined as the distance between center and right corner in pixels


func _ready():
	spawn_tiles()


func spawn_tiles():
	tiles = {}
	for cell in tilemap.get_used_cells(0):
		var hex = HexCell.new(cell)
		_initialize_tile_at(hex)
		tilemap.set_cell(0, cell)

func _initialize_tile_at(hex: HexCell):
	var tile
	tile = basic_tile.instantiate().initialize(hex)
	tile_container.add_child(tile)
	tiles[hex.id] = tile


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

### Signal callbacks	
func _on_button_pressed():
	var tween = get_tree().create_tween().set_parallel().set_ease(ease_type)
	for key in tiles:
		var tile = tiles[key]
		var delay = key.x * quake_delay
		var start = tile.position.y
		var end = tile.position.y - 100 
		tween.tween_property(tile, "position:y", end, sine_time).set_delay(delay).set_trans(transition_type).from(start)
		tween.tween_property(tile, "position:y", start, sine_time).set_delay(delay + sine_time).set_trans(transition_type).from(end)


func _on_disco_pressed():
	var tween = get_tree().create_tween().set_parallel().set_ease(ease_type)
	for key in tiles:
		var tile = tiles[key]
		var delay = randf()*2
		var start_color = Color.WHITE
		var color = Color.from_hsv(randf(), 1.0, 1.0)
		tween.tween_property(tile.sprite, "modulate", color, sine_time).set_delay(delay).set_trans(transition_type).from(start_color)
		tween.tween_property(tile.sprite, "modulate", start_color, sine_time).set_delay(delay + sine_time).set_trans(transition_type).from(color)


func _on_spawn_pressed():
	var tween = get_tree().create_tween().set_parallel().set_ease(Tween.EASE_OUT)
	for key in tiles:
		var tile = tiles[key]
		var delay = randf()*2
		var start = tile.position.y - 1500
		var end = tile.position.y
		tile.position.y = start
		tween.tween_property(tile, "position:y", end, 1).set_delay(delay).set_trans(Tween.TRANS_QUAD).from(start)
