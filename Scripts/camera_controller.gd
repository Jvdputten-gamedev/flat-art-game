extends Camera2D


@export var current_player: Node2D

func _process(delta):
	position = current_player.position
