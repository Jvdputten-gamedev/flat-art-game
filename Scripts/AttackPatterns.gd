extends Node2D

@export var tilemap: TileMap
@export var direction_dropdown: OptionButton

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
	print(coordinates)
	tilemap.set_cells_terrain_connect(ATTACK_LAYER, coordinates, TERRAIN_SET, ATTACK_TERRAIN)

func hexcell_array_to_oddq_array(hex_cell_array):
	var oddq_array = []
	for coord in hex_cell_array:
		oddq_array.append(coord.oddq_coords)
	return oddq_array

func get_all_adjacent():
	var cells = Array()
	for dir in Directions.DIRECTIONS:
		cells.append(self.get_adjacent(dir.cube_coords).oddq_coords)
	return cells

func test_get_odd_q():
	var cell = HexCell.new(center_cell.cube_coords)
	print(cell.oddq_coords)

func get_adjacent(dir: Vector3i) -> HexCell:
	var cell = HexCell.new(center_cell.cube_coords + dir)
	return cell

func get_triangle_up():
	var cells = Array()
	var dirs = [Directions.NORTH, Directions.SOUTHEAST, Directions.SOUTHWEST]
	for dir in dirs:
		cells.append(self.get_adjacent(dir.cube_coords).oddq_coords)
	return cells

func get_triangle_down():
	var cells = Array()
	var dirs = [Directions.NORTHEAST, Directions.SOUTH, Directions.NORTHWEST]
	for dir in dirs:
		cells.append(self.get_adjacent(dir.cube_coords).oddq_coords)
	return cells
	
func clear_terrain() -> void:
	tilemap.clear_layer(ATTACK_LAYER)


func _on_adjacent_pressed():
	clear_terrain()
	var cells = get_all_adjacent()
	paint_hex_on_map(cells)


func _on_triangle_up_pressed():
	clear_terrain()
	var cells = get_triangle_up()
	paint_hex_on_map(cells)


func _on_triangle_down_pressed():
	clear_terrain()
	var cells = get_triangle_down()
	paint_hex_on_map(cells)


func _on_direction_item_selected(index):
	clear_terrain()
	var cells = Array()
	var dir = Directions.DIRECTIONS[index]
	cells.append(self.get_adjacent(dir.cube_coords))
	paint_hex_on_map(hexcell_array_to_oddq_array(cells))
