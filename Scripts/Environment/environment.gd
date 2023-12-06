extends Node2D

@export var highlight: Node2D
@export var level_generator: Node2D

func _ready() -> void:
	print("2. Initialize environment.")
	level_generator.spawn_base_level()




