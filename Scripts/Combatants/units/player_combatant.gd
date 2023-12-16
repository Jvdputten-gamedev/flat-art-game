extends Combatant
class_name PlayerCombatant

@export var movement_preview: MovePreviewComponent
@export var state_chart: PlayerCombatantStateChart


func _ready():
	EventBus.MouseEnteredMovePreviewCollision.connect(_on_mouse_entered_move_preview_collision)
	disable_movement_preview()

	
func enable_movement_preview():
	if movement_preview:
		movement_preview.show()

func disable_movement_preview():
	if movement_preview:
		movement_preview.hide()


### Signal response ###
func _on_mouse_entered_move_preview_collision(tile: BasicTile):

	if ServiceLocator.tile_service.tile_in_aoe(tile):
		enable_movement_preview()
	else:
		disable_movement_preview()
		return
	var path = ServiceLocator.navigation_service.get_path_between_tiles(get_current_tile(), tile)
	movement_preview.update_move_preview(path)