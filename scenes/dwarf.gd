extends Node2D

@export var animationplayer: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animationplayer.playback_default_blend_time = 0.2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_animation_player() -> AnimationPlayer:
	return animationplayer
