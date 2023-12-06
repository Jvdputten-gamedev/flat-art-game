extends Node2D

@export var highlight: Node2D
@export var level_generator: Node2D

func initialize() -> void:
	print("2. Initialize environment.")
	highlight.initialize()
	level_generator.spawn_base_level()




