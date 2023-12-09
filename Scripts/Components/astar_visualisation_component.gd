extends Node2D
class_name AStar2DVisualizer

@export var point_radius: float = 6
@export var scale_multiplier: float = 16
@export var offset: Vector2 = Vector2(0,0)
@export var enabled_point_color: Color = Color('00ff00')
@export var disabled_point_color: Color = Color('ff0000')
@export var line_color: Color = Color('0000ff')
@export var line_width: float = 2

var astar : AStar2D

func visualize(new_astar : AStar2D):
	astar = new_astar
	queue_redraw()

func clear():
	astar = null
	queue_redraw()

func _point_pos(id):
	return offset + astar.get_point_position(id) * scale_multiplier

func _draw():
	if not astar:
		return
	
	for point_id in astar.get_point_ids():
		
		for other_id in astar.get_point_connections(point_id):
			draw_line(astar.get_point_position(point_id), astar.get_point_position(other_id), line_color, line_width)
			
		var point_color = disabled_point_color if astar.is_point_disabled(point_id) else enabled_point_color
		draw_circle(astar.get_point_position(point_id), point_radius, point_color)