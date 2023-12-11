extends Node2D
class_name CombatantGroup

var num_combatants: int
var combatants: Array[Combatant] = []
var navigation_service: Node
var combat_service: Node



func initialize():
	navigation_service = ServiceLocator.get_tile_service()
	_initialize_combatants()


func _initialize_combatants():
	print("    Add nodes to combatant list")
	for combatant in get_children():
		num_combatants += 1
		var hex = HexCell.new(Vector3(0,0,0))
		var tile = ServiceLocator.tile_service.get_tile(hex.id)
		tile.occupy(combatant as Combatant)

