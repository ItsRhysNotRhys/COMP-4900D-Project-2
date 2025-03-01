extends Node2D

@export var next_scene_path : String

# enums for function types and transformation types
const Functions = preload("res://functions.gd")

func _ready() -> void:
	$Fire.change_scene.connect(_on_fire_change_scene)
	$"TestLevel/MarginContainer/VBoxContainer".function = Functions.functions.QUAD
	$"TestLevel/MarginContainer/VBoxContainer".toggle_transformation(Functions.transformations.VERTICAL_SHIFT)
	$"TestLevel/MarginContainer/VBoxContainer".toggle_transformation(Functions.transformations.HORIZONTAL_SHIFT)
	$"TestLevel/MarginContainer/VBoxContainer".toggle_transformation(Functions.transformations.VERTICAL_SCALE)

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
