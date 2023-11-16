extends Node2D


@export var character: Node2D
var animation_player: AnimationPlayer
var _path: Array
var _moving: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation_player = character.get_animation_player()
	pass # Replace with function body.

func is_moving() -> bool:
	return _moving

func move_along_path(path:Array) -> void:
	_moving = true
	_path = path
	if path.size() > 0:
		_path.pop_front() # remove starting position
		move_to_next_position(_path.pop_front())

func move_to_next_position(to: Vector2) -> void:
	"""Move to the position in world space"""
	if to.x > self.position.x:
		self.scale.x = -0.5
	else:
		self.scale.x = 0.5 
	var tween  = create_tween()
	animation_player.play("walk")
	tween.tween_property(self, "position", to, 0.45)
	tween.connect("finished", _on_hex_move_finished)

func _on_hex_move_finished():
	if _path.size() > 0:
		var next = _path.pop_front()
		move_to_next_position(next)
	else:
		_moving = false
		animation_player.play("Idle")

