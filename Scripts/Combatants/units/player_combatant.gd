extends Combatant
class_name PlayerCombatant

@export var movement_preview: MovePreviewComponent

func enable_movement_preview():
    if movement_preview:
        movement_preview.show()

func disable_movement_preview():
    if movement_preview:
        movement_preview.hide()
