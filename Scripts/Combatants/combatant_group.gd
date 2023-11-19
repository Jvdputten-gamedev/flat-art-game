extends Node2D
class_name CombatantGroup

var num_combatants: int
var combatants: Array[Combatant] = []
var navigation_service: Node
var combat_service: Node


func initialize():
	navigation_service = ServiceLocator.get_navigation_service()
	combat_service = ServiceLocator.get_combat_service()
	_initialize_combatants()


func _initialize_combatants():
	print("    Add nodes to combatant list")
	for combatant in get_children():
		num_combatants += 1
		var cell = navigation_service.tilemap.get_random_available_cell()
		combatant.position = navigation_service.map_to_local(cell)
		combatant.cell_coord = cell
		combatants.append(combatant as Combatant)



func start_turn():
	pass

