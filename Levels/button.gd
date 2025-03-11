extends Button

@onready var next_scene_path := "res://Levels/lore_screen.tscn"

func _on_pressed() -> void:
	get_tree().change_scene_to_file(next_scene_path)
