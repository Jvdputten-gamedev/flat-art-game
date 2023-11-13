extends Node2D

var center_cell: HexCell = HexCell.new(Vector2i(2,2))
@export var tilemap: TileMap
@export var character: Node2D

const HIGHLIGHT_LAYER = 4
const TERRAIN_SET: int = 0
const HIGHLIGHT_TERRAIN: int = 0

func paint_highlight_on_map(coordinates):
	tilemap.set_cells_terrain_connect(HIGHLIGHT_LAYER, coordinates, TERRAIN_SET, HIGHLIGHT_TERRAIN)

func clear_terrain() -> void:
	tilemap.clear_layer(HIGHLIGHT_LAYER)

func _input(event):
	if event is InputEventMouseMotion:
		clear_terrain()
		var hex_coords = tilemap.local_to_map(get_local_mouse_position())
		print(hex_coords)
		if hex_has_ground(hex_coords):
			paint_highlight_on_map([hex_coords])
	
	if event is InputEventMouseButton:
		if event.button_index == 1:
			var hex_coords = tilemap.local_to_map(get_local_mouse_position())
			var to_position = tilemap.map_to_local(hex_coords)
			var anim_player = character.get_animation_player()
			var tween  = create_tween()
			tween.tween_property(character, "position", to_position, 0.8)
			anim_player.
			#anim_player.play("walk")
			#await tween.finished 
			#anim_player.stop()

func hex_has_ground(hex_coords):
	var data = tilemap.get_cell_tile_data(1, hex_coords)
	if data:
		return true
	else:
		return false
