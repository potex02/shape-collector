class_name Circle
extends Area2D
## The class representing the circles to collect in the game.


## Adds the circle to the circles group.
func _ready() -> void:
	self.add_to_group("circles")
