extends Node2D



@export var tilemap: TileMap
@export var basic_tile: PackedScene
@export var tile_container: Node2D
@export var quake_delay: float = 0.1
@export var sine_time: float = 0.1
@export var transition_type: Tween.TransitionType
@export var ease_type: Tween.EaseType

var tiles: Dictionary

func _ready():
	spawn_tiles()


func spawn_tiles():
	tiles = {}
	for cell in tilemap.get_used_cells(0):
		_spawn_tile_at_cell(cell)
		tilemap.set_cell(0, cell)

	for cell in tilemap.get_used_cells(1):
		_spawn_tile_at_cell(cell, -32)
		tilemap.set_cell(1, cell)

func _input(event) -> void:
	if event is InputEventMouseMotion:
		tilemap.clear_layer(2)
		var cell_coord = tilemap.local_to_map(get_local_mouse_position())
		tilemap.set_cells_terrain_connect(2, [cell_coord], 0, 0)

		

func _click_to_cell():
	var click = get_local_mouse_position()
	return tilemap.local_to_map(click)

func _cell_to_cell_center(cell: Vector2i):
	var i = cell.x
	var j = cell.y
	return Vector2(i*192, j*128 + 64*(i%2)) + Vector2(128, 64)

func _click_to_cell_center():
	var clicked_cell = _click_to_cell()
	return _cell_to_cell_center(clicked_cell)


func _spawn_tile_at_cell(cell: Vector2i, offset = 0):
	var tile = basic_tile.instantiate().initialize(cell, offset)
	tile_container.add_child(tile)
	tiles[cell] = tile

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
