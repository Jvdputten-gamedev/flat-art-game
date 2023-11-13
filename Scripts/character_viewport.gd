extends Node2D


@export var character: Node2D
var animation_player: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player = character.get_animation_player()
	pass # Replace with function body.


func move_to_position(to: Vector2) -> void:
	if to.x > self.position.x:
		self.scale.x = -0.5
	else:
		self.scale.x = 0.5 
	
	var tween  = create_tween()
	animation_player.play("walk")
	tween.tween_property(self, "position", to, 0.45)
	await tween.finished
	animation_player.play("Idle")