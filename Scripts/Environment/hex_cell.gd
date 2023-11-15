extends Node2D
class_name HexCell

var cube_coords = Vector3(0, 0, 0)

var axial_coords:
	get:
		return get_axial_coords()
	set(val): 
		set_axial_coords(val)

var oddq_coords:
	get:
		return get_oddq_coords()
	set(val):
		set_oddq_coords(val)



func _init(coords=null):
	if coords:
		self.cube_coords = self.obj_to_coords(coords) 

func new_hex(coords):
	# Returns a new HexCell instance
	return get_script().new(coords)
	

func obj_to_coords(val):
	# Returns suitable cube coordinates for the given object
	# The given object can an be one of:
	# * Vector3 of standard cube coords;
	# * Vector2 of offset coords;
	# * HexCell instance
	# Any other type of value will return null
	#
	# NB that offset coords are NOT supported, as they are
	# indistinguishable from axial coords.
	
	if typeof(val) == TYPE_VECTOR3I:
		return val
	elif typeof(val) == TYPE_VECTOR2I:
		set_oddq_coords(val)
		return cube_coords
	elif typeof(val) == TYPE_OBJECT and val.has_method("get_cube_coords"):
		return val.get_cube_coords()
	return
		
	
func get_axial_coords():
	return Vector2i(self.cube_coords.x, self.cube_coords.y)
		
func set_axial_coords(val: Vector2i):
	set_cube_coords(axial_to_cube_coords(val))
			

func set_cube_coords(val):
	if abs(val.x + val.y + val.z) > 0.0001:
		print("WARNING: Invalid cube coordinates for hex (x+y+z!=0): ", val)
		return
	cube_coords = val

func axial_to_cube_coords(val) -> Vector3i:
	var x = val.x
	var y = val.y
	return Vector3i(x, y, -x -y)


func set_oddq_coords(val: Vector2i):
	var x = val.x
	var y = val.y
	var q = x
	var r = y - (x - (x & 1)) / 2
	self.set_axial_coords(Vector2i(q, r))


func get_oddq_coords() -> Vector2i:
	var col = self.cube_coords.x
	var row = self.cube_coords.y + (self.cube_coords.x - (self.cube_coords.x & 1)) / 2
	return Vector2i(col,row)

"""
Finding neighbours
"""
func get_adjacent(dir):
	var cell = HexCell.new(self.cube_coords + dir)
	return cell

func get_all_adjacent():
	var cells = Array()
	for dir in Directions.DIRECTIONS:
		cells.append(get_adjacent(dir.cube_coords).oddq_coords)
	return cells

func get_all_within(distance):
	var cells = Array()
	for dx in range(-distance, distance + 1):
		for dy in range(max(-distance, -distance - dx), min(distance, distance - dx) + 1):
			cells.append(HexCell.new(self.cube_coords + axial_to_cube_coords(Vector2i(dx, dy))).oddq_coords)
	return cells
