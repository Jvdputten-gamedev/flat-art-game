extends Node2D

@export var animationplayer: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_animation_player() -> AnimationPlayer:
	return animationplayer