extends Service
class_name NavigationService

var tilemap: HexTileMap
var _astar: AStar2DHex

	
func initialize() -> void:
	print("  3.1 Initialize navigation service, setup pathfinding")
	_astar = AStar2DHex.new()

func update_astar() -> void: 
	_astar.update()

func get_local_point_path(from_position: Vector2i, to_position: Vector2i) -> Array:
	return _astar.get_local_point_path(from_position, to_position)


func _unhandled_input(event):
	if event.is_action_pressed("LMB"):
		queue_redraw()
		

func _draw():
	var to_position = get_local_mouse_position()
	var from_position = Vector2i(0,0)
	var path = self.get_local_point_path(from_position, to_position)
	draw_polyline(path, Color.BLUE, 5)




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




	
	





