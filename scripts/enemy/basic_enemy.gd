extends Enemy
@onready var player = %Player
const BASIC_PROJECTILE = preload("uid://d0uslmf1fd1p6")

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


func _on_firing_timer_timeout():
	fire()

func fire():
	var new_projectile: Projectile = BASIC_PROJECTILE.instantiate()
	get_parent().add_child(new_projectile)
	new_projectile.type = 'enemy'
	new_projectile.global_position = global_position
	new_projectile.movement_destination = (player.global_position - global_position) * 100
