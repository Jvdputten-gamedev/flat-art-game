extends Node2D
class_name MovePreviewComponent


@export var mover_visuals: Node2D
var mover_shade: Node2D
@onready var line: Line2D = $Line2D

func _ready():
    EventBus.Action1Pressed.connect(_on_action_1_pressed)
    mover_shade = mover_visuals.duplicate()
    add_child(mover_shade)
    mover_shade.visible = false

func update_move_preview(path: PackedVector2Array):
    line.points = path
    mover_shade.visible = true
    mover_shade.position = path[-1]



func _on_action_1_pressed():
    var nav = ServiceLocator.navigation_service
    var path = nav.get_local_point_path(mover_visuals.position, ServiceLocator.tile_service.get_random_available_tile().to_point())
    update_move_preview(path)
