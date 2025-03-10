extends Node2D

@export var next_scene_path : String
@onready var vbox := $Level/MarginContainer/VBoxContainer

# enums for function types and transformation types
const Functions = preload("res://functions.gd")

func _ready() -> void:
	$Fire.change_scene.connect(_on_fire_change_scene)
	vbox.function = Functions.functions.QUAD
	vbox.toggle_transformation(Functions.transformations.VERTICAL_SHIFT)
	vbox.toggle_transformation(Functions.transformations.HORIZONTAL_SHIFT)
	vbox.toggle_transformation(Functions.transformations.VERTICAL_SCALE)

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
