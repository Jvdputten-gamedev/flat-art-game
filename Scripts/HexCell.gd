extends Node2D
class_name HexCell

var cube_coords = Vector3(0, 0, 0) 
var oddq_coords:
	get:
		get_oddq_coords()
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
		return set_oddq_coords(val)
	elif typeof(val) == TYPE_OBJECT and val.has_method("get_cube_coords"):
		return val.get_cube_coords()
	return
		
func get_cube_coords():
	# Returns a Vector3 of the cube coordinates
	return cube_coords

func set_oddq_coords(val: Vector2i):
	var x = val.x
	var y = val.y
	var q = x
	var r = y - (x - (x & 1)) / 2
	self.cube_coords = Vector3i(q, r, -q-r)


func get_oddq_coords() -> Vector2i:
	var col = self.cube_coords.x
	var row = self.cube_coords.y + (self.cube_coords.x - (self.cube_coords.x & 1)) / 2
	return Vector2i(col,row)
