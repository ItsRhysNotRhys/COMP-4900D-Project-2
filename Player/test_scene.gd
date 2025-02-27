extends Node2D

@export var next_scene_path : String

func _ready() -> void:
	$Fire.change_scene.connect(_on_fire_change_scene)

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)


func _on_change_function(new_function: Variant) -> void:
	pass # Replace with function body.
