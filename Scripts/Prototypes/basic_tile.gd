extends HexCell
class_name BasicTile

@export var sprite: Sprite2D
@export var move_preview_collision_area: Area2D

var _combatant: Combatant  = null

func _ready():
	move_preview_collision_area.mouse_entered.connect(_on_mouse_entered)

func initialize(hex: HexCell):
	position = hex.to_point()
	cube_coords = hex.cube_coords

	var cell = hex.oddq_coords
	z_index = -100 + 2*cell.y + abs(cell.x%2)
	return self

func occupy(combatant: Combatant) -> void:
	ServiceLocator.navigation_service.get_astar().occupy(self)
	self._combatant = combatant

func vacate() -> void:
	ServiceLocator.navigation_service.get_astar().vacate(self)
	self._combatant = null

func is_vacant() -> bool:
	return ServiceLocator.navigation_service.get_astar().is_vacant(self)

func is_occupied() -> bool:
	return ServiceLocator.navigation_service.get_astar().is_occupied(self)

func has_combatant() -> bool:
	return self._combatant != null

func get_combatant() -> Combatant:
	return self._combatant


func get_all_tiles_within(distance: int, add_origin = false):
	var hexes = get_all_hexes_within(distance, add_origin)
	var tiles: Array[BasicTile] = []
	for hex in hexes:
		tiles.append(ServiceLocator.tile_service.get_tile(hex.id))
	return tiles


## Signal responses
func _on_mouse_entered() -> void:
	EventBus.MouseEnteredMovePreviewCollision.emit(self)

