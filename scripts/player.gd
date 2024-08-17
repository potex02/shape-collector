class_name Player
extends Area2D
## The class of the game player.


## The player direction.
var direction: Vector2


## Moves the player.
func _physics_process(delta: float) -> void:
	
	var old_direction: Vector2 = self.direction
	
	self.direction = Vector2(Input.get_axis("ui_left", "ui_right"), 0)
	if not self.direction:
		self.direction.y = Input.get_axis("ui_up", "ui_down")
	self.direction = direction.normalized()
	if not self.direction:
		self.direction = old_direction
	if self._can_move():
		self.position += direction * 2


## Checks if the playe can move.
func _can_move() -> bool:
	
	var directions: Dictionary = {
		Vector2.LEFT: $RayCasts/Left,
		Vector2.RIGHT: $RayCasts/Right,
		Vector2.UP: $RayCasts/Up,
		Vector2.DOWN: $RayCasts/Down,
	}
	
	print(self.direction)
	if not self.direction:
		return true
	print(directions[self.direction].get_collider())
	return directions[self.direction].get_collider() == null
