extends Button

@onready var next_scene_path := "res://Levels/level_1.tscn"

func _on_pressed() -> void:
	print("pressed")
	get_tree().change_scene_to_file(next_scene_path)
