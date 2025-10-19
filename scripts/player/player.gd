extends CharacterBody2D
var speed: float = 400.0
var movement_direction: Vector2
var acceleration: float = 5.0

func _input(event):
	if event.is_action('movement'):
		movement_direction.x = Input.get_action_strength('right') - Input.get_action_strength('left')
		movement_direction.y = Input.get_action_strength('down') - Input.get_action_strength('up')

func _physics_process(delta):
	velocity = velocity.lerp(movement_direction * speed, acceleration * delta)
	move_and_slide()
