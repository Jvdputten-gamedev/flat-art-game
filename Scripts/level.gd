extends Node2D

@export var services: Node
@export var environment: Node2D
@export var combatants: Node2D

func _ready():
	services.register()
	environment.initialize()
	services.initialize()
	combatants.initialize()



