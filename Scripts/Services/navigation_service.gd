extends Service
class_name NavigationService

var _astar: AStar2DHex
@export var _astar_visualiser: AStar2DVisualizer

func initialize() -> void:
	print("  3.1 Initialize navigation service, setup pathfinding.")
	_astar = AStar2DHex.new()

func update_astar() -> void: 
	if _astar:
		_astar.update()

func get_path_between_tiles(from_tile: BasicTile, to_tile: BasicTile) -> PackedVector2Array:
	return _astar.get_path_between_tiles(from_tile, to_tile)

func get_local_point_path(from_position: Vector2i, to_position: Vector2i) -> Array:
	return _astar.get_local_point_path(from_position, to_position)

func compute_move_cost(from_hex: HexCell, to_hex: HexCell) -> int:
	return _astar.compute_move_cost(from_hex, to_hex)

func get_astar() -> AStar2DHex:
	return _astar

func visualize_astar_grid():
	_astar_visualiser.visualize(_astar)

func clear_astar_grid():
	_astar_visualiser.clear()


# func show_combatant_movement_range(combatant: Combatant):
# 	var hexcell = HexCell.new(combatant.cell_coord)
# 	var cells = hexcell.get_all_within(combatant.movement_range)
# 	cells = tilemap._intersect_with_ground(cells)
# 	cells = tilemap._intersect_with_available(cells)
	
# 	var out: Array[Vector2i] = []
# 	for cell in cells:
# 		var move_cost = _astar.compute_move_cost(combatant.cell_coord, cell)
# 		if move_cost <= combatant.movement_range:
# 			out.append(cell as Vector2i)
# 	tilemap.paint_AOE_on_map(out)




	
	





