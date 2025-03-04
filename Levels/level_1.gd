extends Node2D

@export var next_scene_path : String
@onready var vbox := $Level/MarginContainer/MarginContainer/VBoxContainer
@onready var main_text := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/function_template/VBoxContainer/mainTerm
@onready var v_shift_text := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/function_template/VBoxContainer3/v_shift

# enums for function types and transformation types
const Functions = preload("res://functions.gd")

func _ready() -> void:
	$Fire.change_scene.connect(_on_fire_change_scene)
	vbox.function = Functions.functions.LINEAR
	vbox.toggle_transformation(Functions.transformations.VERTICAL_SHIFT)
	
	#set function template text through code - can also set it through the inspector,
	# but values set through the inspector may get overwritten if we make changes
	# to the margin container scene, so it's safer to set text and min/max values through code
	main_text.text = "f(x) = x"
	v_shift_text.text = "[color='#9370db'] + d[/color]"

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
