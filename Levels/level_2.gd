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
	vbox.toggle_transformation(Functions.transformations.VERTICAL_SCALE)
	
	#set function template text through code
	main_text.text = "f(x) = [color='#BDB76B']a[/color]x"
	v_shift_text.visible = false

func _on_fire_change_scene() -> void:
	get_tree().change_scene_to_file(next_scene_path)
