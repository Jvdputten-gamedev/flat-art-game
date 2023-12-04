extends Node2D
class_name HexCell

var hex_size: float = 128
var cube_coords = Vector3(0, 0, 0):
	set(val):
		if abs(val.x + val.y + val.z) > 0.0001:
			print("WARNING: Invalid cube coordinates for hex (x+y+z!=0): ", val)
			return
		cube_coords = round_coords(val)

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

var id:
	get:
		return abs(hash(str(oddq_coords.x) + str(oddq_coords.y)))
		

func _init(coords=null):
	if coords:
		cube_coords = self.obj_to_coords(coords)

func new_hex(coords):
	# Returns a new HexCell instance
	return get_script().new(coords)
	

func obj_to_coords(val):
	# Returns suitable cube coordinates for the given object
	# The given object can an be one of:
	# * Vector3 of standard cube coords;
	# * Vector2i of offset coords;
	# * Vector2 of Axial coords
	# * HexCell instance
	# Any other type of value will return null
	#
	# NB that offset coords are NOT supported, as they are
	# indistinguishable from axial coords.

	
	if typeof(val) == TYPE_VECTOR3:
		return val
	elif typeof(val) == TYPE_VECTOR2:
		# Receive Axial coords
		return axial_to_cube_coords(val)

	elif typeof(val) == TYPE_VECTOR2I:
		# Receive oddq coords through TileMap
		return oddq_to_cube(val)

	elif typeof(val) == TYPE_OBJECT and val.has_method("get_cube_coords"):
		return val.get_cube_coords()
	return

func round_coords(val):
	# Rounds floaty coordinate to the nearest whole number cube coords
	if typeof(val) == TYPE_VECTOR2:
		val = axial_to_cube_coords(val)
	
	# Straight round them
	var rounded = Vector3(round(val.x), round(val.y), round(val.z))
	
	# But recalculate the one with the largest diff so that x+y+z=0
	var diffs = (rounded - val).abs()
	if diffs.x > diffs.y and diffs.x > diffs.z:
		rounded.x = -rounded.y - rounded.z
	elif diffs.y > diffs.z:
		rounded.y = -rounded.x - rounded.z
	else:
		rounded.z = -rounded.x - rounded.y
	
	return rounded
		
	
func get_axial_coords():
	return Vector2(self.cube_coords.x, self.cube_coords.y)
		
func set_axial_coords(val: Vector2):
	cube_coords = axial_to_cube_coords(val)

func axial_to_cube_coords(val) -> Vector3:
	var x = val.x
	var y = val.y
	return Vector3(x, y, -x -y)

func oddq_to_cube(val: Vector2i) -> Vector3:
	var q = val.x
	var r = val.y - (val.x - (val.x&1)) / 2
	return Vector3(q, r, -q-r)

func set_oddq_coords(val: Vector2i):
	var x = val.x
	var y = val.y
	var q = x
	var r = y - (x - (x & 1)) / 2
	self.set_axial_coords(Vector2(q, r))


func get_oddq_coords() -> Vector2i:
	var x = int(cube_coords.x)
	var y = int(cube_coords.y)
	var col = x
	var row = y + (x - (x & 1)) / 2
	return Vector2i(col,row)


func to_point() -> Vector2:
	"""
	size = 128
	basis x = (x = 6/4, y = 1/2)
	basis y = (x=0, y= 1)

	[ 6/4, 0  
	1/2, 1]
	"""

	var x = hex_size * (1.5 * axial_coords.x)
	var y = hex_size * (0.5 * axial_coords.x + axial_coords.y)
	return Vector2(x, y)


"""
Finding neighbours
"""
func get_adjacent(dir):
	var hex = HexCell.new(self.cube_coords + Vector3(dir))
	return hex

func get_all_adjacent():
	var hexes: Array[HexCell] = []
	for dir in Directions.DIRECTIONS:
		hexes.append(get_adjacent(dir.cube_coords))
	return hexes

func get_all_within(distance: int, remove_origin = true):
	var hexes: Array[HexCell] = []
	for dx in range(-distance, distance + 1):
		for dy in range(max(-distance, -distance - dx), min(distance, distance - dx) + 1):
			hexes.append(HexCell.new(self.cube_coords + axial_to_cube_coords(Vector2(dx, dy))))

	if remove_origin:
		hexes.erase(self)
	return hexes
