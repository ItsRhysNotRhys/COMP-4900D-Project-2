extends Area2D

signal change_scene

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		area.queue_free()
		$AnimatedSprite2D.play("Smoke")
		$AudioStreamPlayer.play()
		$Timer.start()

func _on_timer_timeout() -> void:
	change_scene.emit()
