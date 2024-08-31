class_name Square
extends Area2D
## The class representing an enemy square in the game.


func _ready() -> void:
	self.area_entered.connect(func (area: Area2D) -> void:
		if area is Player:
			area.set_physics_process(false)
		)
