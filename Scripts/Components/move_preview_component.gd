extends Node2D
class_name MovePreviewComponent

@export var mover_visuals: CanvasGroup
@export var ghost_shader: ShaderMaterial
@export var line: Line2D
var mover_shade: CanvasGroup

func _ready():
	mover_shade = mover_visuals.duplicate()
	mover_shade.scale = Vector2(-0.3, 0.3)
	mover_shade.material = ghost_shader
	add_child(mover_shade)
	hide()

func update_move_preview(path: PackedVector2Array):
	if path:
		line.points = Array(path).map(func(x): return line.to_local(x))
		mover_shade.global_position = path[-1]





