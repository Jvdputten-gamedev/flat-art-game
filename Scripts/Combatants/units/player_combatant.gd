extends Combatant
class_name PlayerCombatant

var allegiance: Allegiance = Enums.Allegiance.PLAYER

@export var movement_preview: MovePreviewComponent

func enable_movement_preview():
    movement_preview.show()

func disable_movement_preview():
    movement_preview.hide()
