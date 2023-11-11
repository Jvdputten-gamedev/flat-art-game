extends Node2D

@export var tilemap: TileMap

var center_cell: HexCell = HexCell.new(Vector2i(4,4))
var terrain_set: int = 0
var attack_terrain: int = 0
var layer: int = 1

const DIR_N = Vector3(0, -1, 1)
const DIR_NE = Vector3(1, -1, 0)
const DIR_SE = Vector3(1, 0, -1)
const DIR_S = Vector3(0, 1, -1)
const DIR_SW = Vector3(-1, 1, 0)
const DIR_NW = Vector3(-1, 0, 1)
const DIR_ALL = [DIR_N, DIR_NE, DIR_SE, DIR_S, DIR_SW, DIR_NW]


func _ready():
	self.test_north()

func paint_hex_on_map(coordinates: Array[Vector2i]):
	tilemap.set_cells_terrain_connect(layer, coordinates, terrain_set, attack_terrain)

func hexcell_array_to_oddq_array(hex_cell_array: Array[HexCell]) -> Array[Vector2i]:
	var oddq_array = []
	for coord in hex_cell_array:
		oddq_array.append(coord.oddq_coords)
	return oddq_array


func test_north():
	var cell = [self.get_adjacent(DIR_N)]
	paint_hex_on_map(hexcell_array_to_oddq_array(cell))

func get_adjacent(dir: Vector3i) -> HexCell:
	var cell = HexCell.new(Vector2i(1,1))
	print("in adjacent", cell.cube_coords)
	return cell

	# return HexCell.new(center_cell.cube_coords + dir)
	

