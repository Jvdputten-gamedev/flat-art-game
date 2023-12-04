extends HexCell
class_name BasicTile

@export var sprite: Sprite2D

var occupant: Node2D  

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

func initialize(hex: HexCell):
	position = hex.to_point()

	var cell = hex.oddq_coords
	z_index = -100 + 2*cell.y + abs(cell.x%2)

	return self

