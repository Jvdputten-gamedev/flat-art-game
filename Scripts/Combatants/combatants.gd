extends Node2D

@export var player_combatant_group: Node2D
@export var enemy_combatant_group: Node2D

func initialize():
	player_combatant_group.initialize()
