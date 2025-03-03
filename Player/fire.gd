extends Area2D

signal change_scene

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		area.queue_free()
		$AnimatedSprite2D.play("Smoke")
		$Timer.start()
	
	 #starts 1 second timer (so we can play a little animation or something before the level changes)

func _on_timer_timeout() -> void:
	change_scene.emit()
