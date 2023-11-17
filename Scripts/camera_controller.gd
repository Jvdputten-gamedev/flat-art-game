extends Camera2D


@export var current_player: Node2D

func _process(_delta):
	position = current_player.position
