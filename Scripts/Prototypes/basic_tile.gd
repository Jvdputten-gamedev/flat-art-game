extends Node2D
class_name BasicTile

@export var sprite: Sprite2D

"""
cellsize is 256 x 128
the center of cell at 0,0 is at 128, 64
going down a cell equals transposing by 128
with (0,0) as reference, the (0, j*128) + (128, 64)

moving right offsets every odd row with 64 on the y-axis, the x-axis increases by 192 px each step (3/4 of the width)

with (0,0) as reference:
(i*192, 64*i%2) + (128, 64)


combined this becomes
(i*192, j*128 + 64*i%2) + 128, 64
"""


static func cell_to_cell_center(cell: Vector2i, offset):
	var i = cell.x
	var j = cell.y
	var center = Vector2(i*192, j*128 + 64*(i%2)) + Vector2(128, 64)
	center.y += offset
	return center

func initialize(cell: Vector2i, offset):
	position = BasicTile.cell_to_cell_center(cell, offset)
	z_index = -100 + 2*cell.y + cell.x%2
	return self
