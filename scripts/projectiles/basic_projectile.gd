extends Projectile

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_area_entered(area):
	area.queue_free()
	queue_free()


func _on_body_entered(body):
	if type == 'enemy':
		if body.get('type') != null:
			body.health -= 1
			body.update()
			queue_free()
