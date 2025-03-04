extends Node2D

@export var next_scene_path : String
@onready var vbox := $Level/MarginContainer/MarginContainer/VBoxContainer
@onready var main_text := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/function_template/VBoxContainer/mainTerm
@onready var v_shift_text := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/function_template/VBoxContainer3/v_shift
@onready var v_shift_spinbox := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/hShift/SpinBox

# enums for function types and transformation types
const Functions = preload("res://functions.gd")

func _ready() -> void:
	$Fire.change_scene.connect(_on_fire_change_scene)
	vbox.function = Functions.functions.LINEAR
	vbox.toggle_transformation(Functions.transformations.VERTICAL_FLIP)
	vbox.toggle_transformation(Functions.transformations.VERTICAL_SCALE)
	vbox.toggle_transformation(Functions.transformations.HORIZONTAL_SHIFT)
	vbox.toggle_transformation(Functions.transformations.VERTICAL_SHIFT)
	
	#set function template text through code
	main_text.text = "f(x) = [color='#76b5c5']±[/color][color='#BDB76B']a[/color](x [color='#FA8072']- c[/color])"
	v_shift_text.text = "[color='#9370db'] + d[/color]"
	
	#set horizontal transformation min value through code
	v_shift_spinbox.min_value = -4

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
