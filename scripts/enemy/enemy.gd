extends CharacterBody2D
class_name Enemy
var movement_direction: Vector2

@export var speed: float = 400.0
@export var acceleration: float = 5.0
@export var color: Color = Color(1, 0, 0)
@export var movement_time: float = 2.0
@export var fire_time: float = 2.0

var player: CharacterBody2D
const BASIC_PROJECTILE = preload("uid://d0uslmf1fd1p6")
var movement_iterations: int = 0


func _ready():
	$MovementTimer.wait_time = movement_time
	$MovementTimer.start()
	$FiringTimer.wait_time = fire_time
	$FiringTimer.start()
	movement_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))


func _physics_process(delta):
	velocity = velocity.lerp(movement_direction * speed, acceleration * delta)
	move_and_slide()

func _on_movement_timer_timeout():
	movement_iterations += 1
	if movement_iterations < 10:
		movement_direction = Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	else:
		collision_layer = 32 #Arbitrary value != 1
		collision_mask = 32
		if global_position.x > get_viewport_rect().size.x / 2:
			movement_direction.x = 1
		else:
			movement_direction.x = -1
		if global_position.y > get_viewport_rect().size.y / 2:
			movement_direction.y = 1
		else:
			movement_direction.y = -1


func _on_firing_timer_timeout():
	fire()

func fire():
	var new_projectile: Projectile = BASIC_PROJECTILE.instantiate()
	get_tree().get_root().add_child(new_projectile)
	new_projectile.type = 'enemy'
	new_projectile.damage = 1
	new_projectile.global_position = global_position
	new_projectile.movement_destination = (player.global_position - global_position) * 100


func _on_visible_on_screen_notifier_2d_screen_exited():
	if movement_iterations < 10:
		movement_direction = player.global_position / player.global_position
	else:
		queue_free()
