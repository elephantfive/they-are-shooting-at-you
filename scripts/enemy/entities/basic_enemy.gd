extends Enemy

var movement_direction: Vector2

func _ready():
	movement_direction.x = randf_range(-1.0, 1.0)
	movement_direction.y = randf_range(-1.0, 1.0)


func _physics_process(delta):
	velocity = velocity.lerp(movement_direction * speed, acceleration * delta)
	move_and_slide()

func _on_movement_timer_timeout():
	movement_direction.x = randf_range(-1.0, 1.0)
	movement_direction.y = randf_range(-1.0, 1.0)
