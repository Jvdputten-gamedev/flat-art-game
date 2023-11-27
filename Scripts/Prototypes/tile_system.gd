extends Node2D



@export var tilemap: TileMap
@export var basic_tile: PackedScene
@export var tile_container: Node2D
@export var quake_delay: float = 0.1
@export var sine_time: float = 0.1
@export var transition_type: Tween.TransitionType
@export var ease_type: Tween.EaseType
@export var highground_offset: int = 32

var tiles: Dictionary

var cell_size: float = 128  # Defined as the distance between center and right corner in pixels


func _ready():
	spawn_tiles()


func spawn_tiles():
	tiles = {}
	for cell in tilemap.get_used_cells(0):
		_spawn_tile_at_cell(cell)
		tilemap.set_cell(0, cell)

func _spawn_tile_at_cell(cell: Vector2i):
	var tile
	if cell.y < 3:
		tile = basic_tile.instantiate().initialize(cell, -highground_offset)
	else:
		tile = basic_tile.instantiate().initialize(cell, 0)
	tile_container.add_child(tile)
	tiles[cell] = tile


func hex_to_local(hex: HexCell) -> Vector2:
	"""
	size = 128
	basis x = (x = 6/4, y = 1/2)
	basis y = (x=0, y= 1)

	[ 6/4, 0  
	1/2, 1]
	"""
	var x = cell_size * (1.5 * hex.axial_coords.x)
	var y = cell_size * (0.5 * hex.axial_coords.x + hex.axial_coords.y)
	return Vector2(x, y)

func local_to_hex(point: Vector2i) -> HexCell:
	"""
	size = 128
	basis x = (x = 6/4, y = 1/2)
	basis y = (x=0, y= 1)

	[ 2/3, 0  
	-1/3, 1]
	"""
	var q = (2./3 * point.x) / cell_size
	var r = (-1./3 * point.x + 1 * point.y) / cell_size
	return HexCell.new(Vector2(q, r))


func mouse_to_hex() -> HexCell:
	return local_to_hex(get_local_mouse_position())


func mouse_to_hex_center():
	var hex: HexCell = mouse_to_hex()
	return hex_to_local(hex)


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
