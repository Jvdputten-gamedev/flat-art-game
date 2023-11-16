extends Node2D

func _ready():
	$Services.register()
	$Environment.initialize()
	$Services.initialize()
	$Combatants.initialize()


