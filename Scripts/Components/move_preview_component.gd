extends Node2D
class_name MovePreviewComponent


@export var mover_visuals: CanvasGroup
@export var ghost_shader: ShaderMaterial
@onready var line: Line2D = $Line2D
var mover_shade: CanvasGroup
var preview_active: bool = false

func _ready():
	EventBus.Action1Pressed.connect(_on_action_1_pressed)
	mover_shade = mover_visuals.duplicate()
	mover_shade.scale = Vector2(0.5, 0.5)
	mover_shade.material = ghost_shader
	add_child(mover_shade)
	mover_shade.visible = false

func update_move_preview(path: PackedVector2Array):
	if path:
		line.points = path
		mover_shade.visible = true
		mover_shade.position = path[-1]


func _input(event):
	if event is InputEventMouseMotion and preview_active:
		var nav = ServiceLocator.navigation_service
		var path = nav.get_local_point_path(mover_visuals.position, get_global_mouse_position())
		update_move_preview(path)

func toggle():
	preview_active = !preview_active



func _on_action_1_pressed():
	toggle()
