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
	
func clear_terrain() -> void:
	tilemap.clear_layer(ATTACK_LAYER)

func _on_direction_item_selected(index:int):
	AttackPatterns.test(index)
