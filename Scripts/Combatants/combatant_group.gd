extends Node2D
class_name CombatantGroup

var num_combatants: int
var combatants: Array[Unit] = []
var navigation_service: Node
var combat_service: Node


func initialize():
	navigation_service = ServiceLocator.get_navigation_service()
	combat_service = ServiceLocator.get_combat_service()
	_initialize_combatants()


func _initialize_combatants():
	for child in get_children():
		num_combatants += 1
		combatants.append(child as Unit)


func start_turn():
	pass

