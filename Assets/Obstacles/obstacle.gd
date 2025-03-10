extends Area2D

var Splash = preload("res://Player/splash.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Projectile"):
		var effect = Splash.instantiate()
		effect.position = area.position
		area.get_parent().add_child(effect)
		area.queue_free()
