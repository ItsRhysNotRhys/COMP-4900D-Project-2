extends VBoxContainer

# to test ui with different transformations enabled
var debug = false

# enums for function types and transformation types
const Functions = preload("res://functions.gd")

var function = Functions.functions.LINEAR:
	get:
		return function
	set(new_function):
		function = new_function
		if function == Functions.functions.QUAD:
			$ui_box/MarginContainer/VBoxContainer/function_box/squared.show()
			$ui_box/MarginContainer/VBoxContainer/function_template/squared.show()
		else:
			$ui_box/MarginContainer/VBoxContainer/function_box/squared.hide()
			$ui_box/MarginContainer/VBoxContainer/function_template/squared.hide()
		write_function()

# to make the play area have heigh of 10 units
var grid_size = 1080 / 10

# default values for all functions
var v_shift: int = 0
var h_shift: int = 0
var v_flip: int = 1 # this should only be 1 or -1
var h_flip: int = 1 # this should only be 1 or -1
var v_scale: float = 1
var h_scale: float = 1

# step sizes for different transformations
var v_shift_step = 20
var h_shift_step = 20
var v_scale_step = 1
var h_scale_step = 1

# level specific settings
var has_change_func = false
var has_v_shift = false
var has_h_shift = false
var has_v_flip = false
var has_h_flip = false
var has_v_scale = false
var has_h_scale = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	write_function()
	
	if debug:
		$debug_ui.show()
		


func toggle_transformation(type) -> void:
	if type == Functions.transformations.VERTICAL_SHIFT:
		has_v_shift = not has_v_shift
		if has_v_shift:
			$ui_box/MarginContainer/VBoxContainer/vShift.show()
		else:
			$ui_box/MarginContainer/VBoxContainer/vShift.hide()
	elif type == Functions.transformations.HORIZONTAL_SHIFT:
		has_h_shift = not has_h_shift
		if has_h_shift:
			$ui_box/MarginContainer/VBoxContainer/hShift.show()
		else:
			$ui_box/MarginContainer/VBoxContainer/hShift.hide()
	elif type == Functions.transformations.VERTICAL_SCALE:
		has_v_scale = not has_v_scale
		if has_v_scale:
			$ui_box/MarginContainer/VBoxContainer/vScale.show()
		else:
			$ui_box/MarginContainer/VBoxContainer/vScale.hide()
	elif type == Functions.transformations.HORIZONTAL_SCALE:
		has_h_scale = not has_h_scale
		if has_h_scale:
			$ui_box/MarginContainer/VBoxContainer/hScale.show()
		else:
			$ui_box/MarginContainer/VBoxContainer/hScale.hide()
	elif type == Functions.transformations.VERTICAL_FLIP:
		has_v_flip = not has_v_flip
		if has_v_flip:
			$ui_box/MarginContainer/VBoxContainer/vFlip.show()
		else:
			$ui_box/MarginContainer/VBoxContainer/vFlip.hide()
	elif type == Functions.transformations.HORIZONTAL_FLIP:
		has_h_flip = not has_h_flip
		if has_h_flip:
			$ui_box/MarginContainer/VBoxContainer/hFlip.show()
		else:
			$ui_box/MarginContainer/VBoxContainer/hFlip.hide()



# create a list of points, which can be used for tracing the graph or determining the projectile trajectory
func evaluate(x: float) -> int:
	var value = 0
	x = x / grid_size
	if function == Functions.functions.LINEAR:
		value = v_flip * v_scale * ((h_flip * h_scale * x) + h_shift) + v_shift
	elif function == Functions.functions.QUAD:
		value = v_flip * v_scale * ((h_flip * h_scale * x) + h_shift) * ((h_flip * h_scale * x) + h_shift) + v_shift
	# add new functions here as needed
	return value * grid_size


# write function in latex
func write_function() -> void:
	var f = "f(x) = "
	
	# compute the main term
	if (v_flip == -1):
		f += "-"
	if (v_scale != 1):
		f += str(v_scale)
	if (h_flip == -1) or (h_scale != 1) or (h_shift != 0):
		f += "("
		if (h_flip == -1):
			f += "-"
		if (h_scale != 1):
			f += str(h_scale)
		f += "x"
		if (h_shift < 0):
			f += " - " + str(-h_shift)
		elif (h_shift > 0):
			f += " + " + str(h_shift)
		f += ")"
	else:
		f += "x"

	# set the main term text
	$ui_box/MarginContainer/VBoxContainer/function_box/VBoxContainer/mainTerm.text = f
	
	# write the vertical shift
	if (v_shift == 0):
		f = ""
	elif (v_shift > 0):
		f = " + " + str(v_shift)
	else:
		f = " - " + str(-v_shift)
	$ui_box/MarginContainer/VBoxContainer/function_box/VBoxContainer2/vShift.text = f

#### ui debugging, toggle each transformation
func _on_debug_change_func() -> void:
	has_change_func = not has_change_func
	if has_change_func:
		$ui_box/MarginContainer/VBoxContainer/changeFunc.show()
	else:
		$ui_box/MarginContainer/VBoxContainer/changeFunc.hide()
func _on_debug_v_shift() -> void:
	toggle_transformation(Functions.transformations.VERTICAL_SHIFT)
func _on_debug_h_shift() -> void:
	toggle_transformation(Functions.transformations.HORIZONTAL_SHIFT)
func _on_debug_v_scale() -> void:
	toggle_transformation(Functions.transformations.VERTICAL_SCALE)
func _on_debug_h_scale() -> void:
	toggle_transformation(Functions.transformations.HORIZONTAL_SCALE)
func _on_debug_v_flip() -> void:
	toggle_transformation(Functions.transformations.VERTICAL_FLIP)
func _on_debug_h_flip() -> void:
	toggle_transformation(Functions.transformations.HORIZONTAL_FLIP)


# update function type
func _on_change_func(index: Functions.functions) -> void:
	function = index
	if (index == Functions.functions.QUAD):
		$ui_box/MarginContainer/VBoxContainer/function_box/squared.show()
	else:
		$ui_box/MarginContainer/VBoxContainer/function_box/squared.hide()
	write_function()

# update transformation values
func _on_v_shift_value_changed(value: int) -> void:
	v_shift = value
	write_function()
func _on_h_shift_value_changed(value: int) -> void:
	h_shift = value
	write_function()
func _on_v_scale_value_changed(value: float) -> void:
	v_scale = value
	write_function()
func _on_h_scale_value_changed(value: float) -> void:
	h_scale = value
	write_function()
func _on_v_flip() -> void:
	v_flip *= -1
	write_function()
func _on_h_flip() -> void:
	h_flip *= -1
	write_function()
