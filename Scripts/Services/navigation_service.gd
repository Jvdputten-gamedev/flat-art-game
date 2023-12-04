extends Service

var tilemap: HexTileMap
var _astar: AStar2DHex

	
func initialize() -> void:
	print("  3.1 Initialize navigation service, setup pathfinding")
	_astar = AStar2DHex.new()

func update_astar() -> void: 
	_astar.update()

func get_cell_at_local_mouse_position():
	var cell = tilemap.local_to_map(get_local_mouse_position())
	if tilemap.cell_has_ground(cell):
		return cell
	else:
		return null

func is_local_mouse_position_in_AOE() -> bool:
	var mouse_cell = get_cell_at_local_mouse_position()
	if mouse_cell in tilemap.get_AOE_cells():
		return true
	else: 
		return false

func get_random_available_position():
	return map_to_local(tilemap.get_random_available_cell())

func map_to_local(coord: Vector2i) -> Vector2:
	return tilemap.map_to_local(coord)

func local_to_map(_position: Vector2) -> Vector2i:
	return tilemap.local_to_map(_position)

func get_local_point_path(from_position: Vector2i, to_position: Vector2i) -> Array:
	return _astar.get_local_point_path(from_position, to_position)

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




	
	





