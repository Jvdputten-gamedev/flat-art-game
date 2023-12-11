extends HexCell
class_name BasicTile

@export var sprite: Sprite2D

var _combatant: Combatant  = null
	
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

func has_combatant() -> bool:
	return self._combatant != null

func get_combatant() -> Combatant:
	return self._combatant

