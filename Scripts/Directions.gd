extends Node2D

const DIR_N = Vector3i(0, -1, 1)
const DIR_NE = Vector3i(1, -1, 0)
const DIR_SE = Vector3i(1, 0, -1)
const DIR_S = Vector3i(0, 1, -1)
const DIR_SW = Vector3i(-1, 1, 0)
const DIR_NW = Vector3i(-1, 0, 1)

class Direction:
	var idx: int
	var cube_coords: Vector3i
	var name: String

	func _init(index: int, _cube_coords: Vector3i, _name: String):
		self.idx = index
		self.cube_coords = _cube_coords
		self.name = _name
	
var NORTH = Direction.new(0, DIR_N, "North")
var NORTHEAST = Direction.new(1, DIR_NE, "North east")
var SOUTHEAST = Direction.new(2, DIR_SE, "South east")
var SOUTH = Direction.new(3, DIR_S, "South")
var SOUTHWEST = Direction.new(4, DIR_SW, "South west")
var NORTHWEST = Direction.new(5, DIR_NW, "North west")

var DIRECTIONS = [NORTH, NORTHEAST, SOUTHEAST, SOUTH, SOUTHWEST, NORTHWEST]




