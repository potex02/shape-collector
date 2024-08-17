class_name Player
extends Area2D
## The class of the game player.


## Moves the player
func _physics_process(delta: float) -> void:
	
	var direction: Vector2
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	if not direction:
		direction.y = Input.get_axis("ui_up", "ui_down")
	print(self.overlaps_body(self.get_parent().get_node("TileMap")))
	self.position += direction
