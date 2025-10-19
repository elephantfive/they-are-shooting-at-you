extends CharacterBody2D
var speed: float = 400.0
var movement_direction: Vector2
var acceleration: float = 5.0
var deceleration: float = 10.0
var abilities: Array = ['basic_shoot']
const PLAYER_PROJECTILE = preload("uid://bukkivmhj31wo")


func _input(event):
	if event.is_action('movement'):
		movement_direction.x = Input.get_action_strength('right') - Input.get_action_strength('left')
		movement_direction.y = Input.get_action_strength('down') - Input.get_action_strength('up')
	if event.is_action('actions'):
		for i in abilities.size():
			if event.is_action_pressed(str(i)):
				call(abilities[i])


func _physics_process(delta):
	if movement_direction != Vector2(0,0):
		velocity = velocity.lerp(movement_direction * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(movement_direction, deceleration * delta)
	move_and_slide()

func basic_shoot():
	var new_projectile: PlayerProjectile = PLAYER_PROJECTILE.instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.global_position = global_position
	new_projectile.movement_destination = (get_global_mouse_position() - global_position) * 100
