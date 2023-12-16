extends Node2D
class_name Combatant

@export var combatant_name: String
@export var movement_range: int
@export var allegiance: Enums.Allegiance

func _ready():
	EventBus.MouseEnteredMovePreviewCollision.connect(_on_mouse_entered_move_preview_collision)

func _to_string():
	return "{name} ({allegiance})".format({"name": combatant_name, "allegiance": Enums.Allegiance.keys()[allegiance]})

func get_current_hex():
	return ServiceLocator.tile_service.local_to_hex(position)

func get_current_tile():
	return ServiceLocator.tile_service.local_to_tile(position)

func move(to_tile: BasicTile):
	var current_tile = get_current_tile()
	current_tile.vacate()
	to_tile.occupy(self)
	position = to_tile.to_point()


### Signal response ###
func _on_mouse_entered_move_preview_collision(tile: BasicTile):

	if ServiceLocator.tile_service.tile_in_aoe(tile):
		enable_movement_preview()
	else:
		disable_movement_preview()
		return
	var path = ServiceLocator.navigation_service.get_path_between_tiles(get_current_tile(), tile)
	movement_preview.update_move_preview(path)







