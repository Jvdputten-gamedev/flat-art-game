extends CanvasLayer

@export var title_text: String
@export var button1_text: String
@export var button2_text: String
@export var button3_text: String
@export var button4_text: String

var title: Label
var button1: Button
var button2: Button
var button3: Button
var button4: Button


func _ready():
    title = $"Control/MarginContainer/MarginContainer/Label"
    title.text = title_text

    button1 = $"Control/MarginContainer/Buttons/Action-1"
    button1.text = button1_text

    button2 = $"Control/MarginContainer/Buttons/Action-2"
    button2.text = button2_text

    button3 = $"Control/MarginContainer/Buttons/Action-3"
    button3.text = button3_text

    button4 = $"Control/MarginContainer/Buttons/Action-4"
    button4.text = button4_text

func set_title(text: String):
    title.text = text


func _on_action_1_pressed():
    EventBus.emit_signal("Action1Pressed")

func _on_action_2_pressed():
    EventBus.emit_signal("Action2Pressed")

func _on_action_3_pressed():
    EventBus.emit_signal("Action3Pressed")
    
func _on_action_4_pressed():
    EventBus.emit_signal("Action4Pressed")