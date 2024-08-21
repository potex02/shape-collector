class_name Player
extends Area2D
## The class of the game player.


## The playe raycast
@onready var ray_cast: RayCast2D = $RayCast
## The player score.
var score: int = 0
## The rotation degrees of the player.
var rotations: Dictionary = {
	Vector2.LEFT: 180,
	Vector2.RIGHT: 0,
	Vector2.UP: 270,
	Vector2.DOWN: 90
}
## The player direction.
var direction: Vector2
## The turns of the player.
var turn: Vector2i

## Moves the player.
func _physics_process(delta: float) -> void:
	
	var turn: Vector2i = Vector2i(floor(Input.get_axis("ui_left", "ui_right")), 0)
	
	if not turn:
		turn.y = floor(Input.get_axis("ui_up", "ui_down"))
	if not self.turn:
		self.turn = turn
	if self.turn and Vector2i(self.position) % 32 == Vector2i.ONE * 16:
		self.direction = self.turn
		self.rotation_degrees = self.rotations[self.direction]
		self.turn = Vector2i.ZERO
		return
	if self.ray_cast.get_collider() == null:
		self.position += self.direction * 2


## Collects a circle.
func collect() -> void:
	self.score += 1
	print(self.score)
