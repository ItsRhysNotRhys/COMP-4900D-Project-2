extends Node2D

@export var next_scene_path : String
@onready var vbox := $Level/MarginContainer/MarginContainer/VBoxContainer
@onready var main_text := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/function_template/VBoxContainer/mainTerm
@onready var v_shift_text := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/function_template/VBoxContainer3/v_shift
@onready var v_shift_spinbox := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/vShift/SpinBox
@onready var h_shift_spinbox := $Level/MarginContainer/MarginContainer/VBoxContainer/ui_box/MarginContainer/VBoxContainer/hShift/SpinBox

# enums for function types and transformation types
const Functions = preload("res://functions.gd")

func _ready() -> void:
	$Fire.change_scene.connect(_on_fire_change_scene)
	vbox.function = Functions.functions.QUAD
	vbox.toggle_transformation(Functions.transformations.VERTICAL_FLIP)
	#vbox.toggle_transformation(Functions.transformations.VERTICAL_SCALE)
	vbox.toggle_transformation(Functions.transformations.HORIZONTAL_SHIFT)
	vbox.toggle_transformation(Functions.transformations.VERTICAL_SHIFT)
	
	# set default values
	#vbox.v_flip = -1
	vbox.v_scale = 0.2
	vbox.write_function()
	
	# set function template text
	main_text.text = "f(x) = [color='#76b5c5']±[/color][color='#BDB76B']a[/color](x [color='#FA8072']+ c[/color])"
	v_shift_text.text = ""
	
	# set horizontal transformation min value
	h_shift_spinbox.min_value = -7
	
	# set vertical transformation max value
	#v_shift_spinbox.max_value = 2

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
