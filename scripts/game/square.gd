class_name Square
extends Area2D
## The class representing an enemy square in the game.

## The directions data of the square.
const DIRECTIONS: Array =  [
	[Vector2.LEFT, 180],
	[Vector2.RIGHT, 0],
	[Vector2.UP, 270],
	[Vector2.DOWN, 90]
]
## The sqaure raycast
@onready var _ray_cast: RayCast2D = $RayCast
## The flag indicating if it's the first call to _physics_process.
var first: bool = true
## The square current direction.
var _direction: Vector2
## The signal emitted at the square removing from the level.
signal removed


## Moves the square.
func _physics_process(delta: float) -> void:
	if self.first:
		self.first = false
		return
	if Vector2i(self.position) % 32 == Vector2i.ONE * 16:
		
		var rand: float = randf()
		
		if rand < 0.5:
			
			var turn: Array = Square.DIRECTIONS[int(rand * 8)]
			
			self._direction = turn[0]
			self.rotation_degrees = turn[1]
			return
	if self._ray_cast.get_collider() == null:
		self.position += self._direction * 2
