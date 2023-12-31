extends Node2D

@export var tilemap: TileMap
@export var direction_dropdown: OptionButton
@export var slider: HSlider

var center_cell: HexCell = HexCell.new(Vector2i(4,4))
const TERRAIN_SET: int = 0
const ATTACK_TERRAIN: int = 0
const ATTACK_LAYER: int = 1

func _ready():
	setup_dropdown()

func setup_dropdown():
	for dir in Directions.DIRECTIONS:
		direction_dropdown.add_item(dir.name, dir.idx)

func paint_hex_on_map(coordinates):
	tilemap.set_cells_terrain_connect(ATTACK_LAYER, coordinates, TERRAIN_SET, ATTACK_TERRAIN)
	
func clear_terrain() -> void:
	tilemap.clear_layer(ATTACK_LAYER)

func _on_adjacent_pressed():
	clear_terrain()
	var cells = AttackPatterns.get_all_adjacent(center_cell)
	paint_hex_on_map(cells)


func _on_triangle_up_pressed():
	clear_terrain()
	var cells = AttackPatterns.get_triangle_up(center_cell)
	paint_hex_on_map(cells)


func _on_triangle_down_pressed():
	clear_terrain()
	var cells = AttackPatterns.get_triangle_down(center_cell)
	paint_hex_on_map(cells)

func _on_direction_item_selected(index:int):
	clear_terrain()
	var cells = Array()
	var dir = Directions.DIRECTIONS[index]
	cells.append(AttackPatterns.get_adjacent(center_cell, dir.cube_coords).oddq_coords)
	paint_hex_on_map(cells)




func _on_range_slider_drag_ended(value_changed:bool):
	if value_changed:
		clear_terrain()
		var cells = center_cell.get_all_within(slider.value)
		print(cells)
		paint_hex_on_map(cells)

