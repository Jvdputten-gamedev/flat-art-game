class_name AttackPatterns
extends Node2D

static func get_adjacent(from: HexCell, dir: Vector3i) -> HexCell:
	var cell = HexCell.new(from.cube_coords + dir)
	return cell

static func get_triangle_up(from: HexCell):
	var cells = Array()
	var dirs = [Directions.NORTH, Directions.SOUTHEAST, Directions.SOUTHWEST]
	for dir in dirs:
		cells.append(from.get_adjacent(dir.cube_coords).oddq_coords)
	return cells

static func get_triangle_down(from: HexCell):
	var cells = Array()
	var dirs = [Directions.NORTHEAST, Directions.SOUTH, Directions.NORTHWEST]
	for dir in dirs:
		cells.append(from.get_adjacent(dir.cube_coords).oddq_coords)
	return cells

static func get_all_adjacent(from: HexCell):
	var cells = Array()
	for dir in Directions.DIRECTIONS:
		cells.append(from.get_adjacent(dir.cube_coords).oddq_coords)
	return cells

static func test(from: HexCell):
	print(from)
