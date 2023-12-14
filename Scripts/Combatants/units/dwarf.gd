extends PlayerCombatant

@export var animationplayer: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animationplayer.playback_default_blend_time = 0
	animationplayer.speed_scale = 1.4


func get_animation_player() -> AnimationPlayer:
	return animationplayer
	

