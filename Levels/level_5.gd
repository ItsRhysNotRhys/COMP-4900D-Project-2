extends Node2D

@export var next_scene_path : String
@onready var vbox := $Level/MarginContainer/VBoxContainer

# enums for function types and transformation types
const Functions = preload("res://functions.gd")

func _ready() -> void:
	$Fire.change_scene.connect(_on_fire_change_scene)
	vbox.function = Functions.functions.LINEAR
	vbox.toggle_transformation(Functions.transformations.HORIZONTAL_SHIFT)
	#set default values
	vbox.v_flip = -1
	vbox.v_shift = 8
	vbox.write_function()

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
