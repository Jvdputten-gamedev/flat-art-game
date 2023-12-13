extends LevelBase

@export var level_size: int = 4
@export var basic_tile: PackedScene
@export var ui: CanvasLayer


func _ready():
	super()
	print("Level ready..")
	spawn_base_level()
	
	EventBus.connect("Action1Pressed", _on_action_1_pressed)
	ui.button1.text = "Player spawn"
	EventBus.connect("Action2Pressed", _on_action_2_pressed)
	ui.button2.text = "Enemy spawn"

func spawn_base_level():
	var origin = HexCell.new(Vector2(0,0))
	var hexes = origin.get_all_within(level_size, true)
	for hex in hexes:
		tile_service.spawn_at(hex)

func _unhandled_input(event):
	if event.is_action_pressed("RMB"):
		tile_service.delete_tile_at_mouse_position()
		ui.set_title("Number of tiles: {0}".format([len(tile_service.get_used_tiles())]))

	if event.is_action_pressed("LMB"):
		tile_service.spawn_tile_at_mouse_position()
		ui.set_title("Number of tiles: {0}".format([len(tile_service.get_used_tiles())]))
		print(tile_service.mouse_to_hex().axial_coords)

func _on_action_1_pressed():
	environment.highlight.highlight_player_spawn()

func _on_action_2_pressed():
	environment.highlight.highlight_enemy_spawn()
