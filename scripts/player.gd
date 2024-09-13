class_name Player
extends Area2D
## The class of the game player.


## The player sprite.
@onready var sprite: Sprite2D = $Sprite
## The player raycast
@onready var ray_cast: RayCast2D = $RayCast
## The timer used to reset the can_eat flag.
@onready var timer: Timer = $Timer
## The player score.
var score: int = 0
## The rotation degrees of the player.
var rotations: Dictionary = {
	Vector2.LEFT: 180,
	Vector2.RIGHT: 0,
	Vector2.UP: 270,
	Vector2.DOWN: 90
}
## The player current direction.
var direction: Vector2
## The turns of the player.
var turn: Vector2i
## The flag indicating if the player can eat the squares.
var can_eat: bool = false
## The signal emitted when the score changes.
signal score_changed
## The signal emitted at a game over.
signal game_over



## Connects the [signal area_entered].
func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)
	self.timer.timeout.connect(func() -> void:
		self.sprite.modulate = Color.WHITE
		self.can_eat = false)



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
func _collect() -> void:
	self.score += 1
	self.score_changed.emit()


## Handles the areas collisions.
func _on_area_entered(area: Area2D) -> void:
	if area is Circle:
		self._collect()
		area.queue_free()
		return
	if area is Square:
		if self.can_eat:
			area.removed.emit()
			return
		self.set_physics_process(false)
		self.game_over.emit()
		return
	if area is Diamond:
		self.can_eat = true
		self.sprite.modulate = Color(0, 255, 255)
		area.queue_free()
		self.timer.start()
