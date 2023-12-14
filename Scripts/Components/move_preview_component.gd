extends Node2D
class_name MovePreviewComponent


@export var mover_visuals: CanvasGroup
@export var ghost_shader: ShaderMaterial
@onready var line: Line2D = $Line2D
var mover_shade: CanvasGroup

func _ready():
	EventBus.MovePreviewCollisionEntered.connect(_on_move_preview_collision_entered)


	mover_shade = mover_visuals.duplicate()
	mover_shade.scale = Vector2(-0.3, 0.3)
	mover_shade.material = ghost_shader
	add_child(mover_shade)

func update_move_preview(path: PackedVector2Array):
	if path:
		line.points = path
		mover_shade.position = path[-1]


### Signal response ###
func _on_move_preview_collision_entered(tile: BasicTile):
	if ServiceLocator.tile_service.tile_in_aoe(tile):
		show()
	else:
		hide()
		return

	var nav = ServiceLocator.navigation_service
	var path = nav.get_local_point_path(mover_visuals.position, tile.position)
	update_move_preview(path)


