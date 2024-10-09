class_name Player
extends Area2D
## The class of the game player.


## The rotation degrees of the player.
const ROTATIONS: Dictionary = {
	Vector2.LEFT: 180,
	Vector2.RIGHT: 0,
	Vector2.UP: 270,
	Vector2.DOWN: 90
}
## The player raycast
@onready var _ray_cast: RayCast2D = $RayCast
## The timer used to reset the can_eat flag.
@onready var _timer: Timer = $Timer
## The player score.
var score: int = 0
## The normal color of the player.
var normal_modulate: Color
## The power up color of the player.
var power_up_modulate: Color
## The player current direction.
var _direction: Vector2
## The turns of the player.
var _turn: Vector2i
## The flag indicating if the player can eat the squares.
var _can_eat: bool = false
## The signal emitted when the score changes.
signal score_changed
## The signal emitted at a game over.
signal game_over



## Connects the [signal area_entered].
func _ready() -> void:
	self.area_entered.connect(self._on_area_entered)
	self._timer.timeout.connect(func() -> void:
		self.modulate = self.normal_modulate
		self._can_eat = false)



## Moves the player.
func _physics_process(delta: float) -> void:
	
	var turn: Vector2i = Vector2i(floor(Input.get_axis("ui_left", "ui_right")), 0)
	
	if not self.get_tree().get_nodes_in_group("circles"):
		print("Win")
	if not turn:
		turn.y = floor(Input.get_axis("ui_up", "ui_down"))
	if not self._turn:
		self._turn = turn
	if self._turn and Vector2i(self.position) % 32 == Vector2i.ONE * 16:
		self._direction = self._turn
		self.rotation_degrees = Player.ROTATIONS[self._direction]
		self._turn = Vector2i.ZERO
		return
	if self._ray_cast.get_collider() == null:
		self.position += self._direction * 2


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
		if self._can_eat:
			area.removed.emit()
			return
		self.set_physics_process(false)
		self.game_over.emit()
		return
	if area is Diamond:
		self._can_eat = true
		self.modulate = self.power_up_modulate
		area.queue_free()
		self._timer.start()
