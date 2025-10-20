extends Node
const BASIC_ENEMY = preload("uid://bbxblh6xq6x8j")
@onready var player = %Player
var iteration: int = 0

func _ready():
	spawn(BASIC_ENEMY)


func spawn(enemy):
	var new_enemy = enemy.instantiate()
	add_child(new_enemy)
	new_enemy.player = player
	new_enemy.global_position = Vector2(randf_range(100, get_parent().get_viewport_rect().size.x - 100), randf_range(100, get_parent().get_viewport_rect().size.y - 100))


func _on_spawn_timer_timeout():
	iteration += 1
	spawn(BASIC_ENEMY)
