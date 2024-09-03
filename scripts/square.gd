class_name Square
extends Area2D
## The class representing an enemy square in the game.


## The sqaure raycast
@onready var ray_cast: RayCast2D = $RayCast
## The directions data of the square.
var directions: Array =  [
	[Vector2.LEFT, 180],
	[Vector2.RIGHT, 0],
	[Vector2.UP, 270],
	[Vector2.DOWN, 90]
]
## The square current direction.
var direction: Vector2



## Moves the square.
func _physics_process(delta: float) -> void:
	if Vector2i(self.position) % 32 == Vector2i.ONE * 16:
		
		var rand: float = randf()
		
		if rand < 0.5:
			
			var turn: Array = self.directions[int(rand * 8)]
			
			self.direction = turn[0]
			self.rotation_degrees = turn[1]
			return
	if self.ray_cast.get_collider() == null:
		self.position += self.direction * 2
