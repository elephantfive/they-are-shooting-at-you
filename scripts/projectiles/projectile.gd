extends Area2D
class_name Projectile

@export var speed: float = 400
var type: String
var movement_destination: Vector2

func _physics_process(delta):
	global_position = global_position.move_toward(movement_destination, speed * delta)
