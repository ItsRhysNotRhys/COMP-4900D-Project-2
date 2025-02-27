extends VBoxContainer

# to test ui with different transformations enabled
var debug = true

# keep track of which function to use
const Functions = preload("res://functions.gd")

var function = Functions.functions.LINEAR:
	get:
		return function
	set(new_function):
		function = new_function
		

# default values for all functions
var v_shift = 0
var h_shift = 0
var v_flip = 1 # this should only be 1 or -1
var h_flip = 1 # this should only be 1 or -1
var v_scale = 1
var h_scale = 1

# step sizes for different transformations
var v_shift_step = 20
var h_shift_step = 20
var v_scale_step = 1
var h_scale_step = 1

# level specific settings
var has_v_shift = false
var has_h_shift = false
var has_v_flip = false
var has_h_flip = false
var has_v_scale = false
var has_h_scale = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# assume linear function by default
	function = Functions.functions.LINEAR
	
	# remove splinbox grey backgrounds
	$vShift/SpinBox.get_line_edit().flat = true
	$hShift/SpinBox.get_line_edit().flat = true
	$vScale/SpinBox.get_line_edit().flat = true
	$hScale/SpinBox.get_line_edit().flat = true
	
	if debug:
		$debug_ui.show()
		



func toggle_transformation(type) -> void:
	if type == Functions.transformations.VERTICAL_SHIFT:
		has_v_shift = not has_v_shift
		if has_v_shift:
			$vShift.show()
		else:
			$vShift.hide()
	elif type == Functions.transformations.HORIZONTAL_SHIFT:
		has_h_shift = not has_h_shift
		if has_h_shift:
			$hShift.show()
		else:
			$hShift.hide()
	elif type == Functions.transformations.VERTICAL_SCALE:
		has_v_scale = not has_v_scale
		if has_v_scale:
			$vScale.show()
		else:
			$vScale.hide()
	elif type == Functions.transformations.HORIZONTAL_SCALE:
		has_h_scale = not has_h_scale
		if has_h_scale:
			$hScale.show()
		else:
			$hScale.hide()
	elif type == Functions.transformations.VERTICAL_FLIP:
		has_v_flip = not has_v_flip
		if has_v_flip:
			$vFlip.show()
		else:
			$vFlip.hide()
	elif type == Functions.transformations.HORIZONTAL_FLIP:
		has_h_flip = not has_h_flip
		if has_h_flip:
			$hFlip.show()
		else:
			$hFlip.hide()






# create a list of points, which can be used for tracing the graph or determining the projectile trajectory
func evaluate(x) -> int:
	var value = 0
	if function == Functions.functions.LINEAR:
		value = v_flip * v_scale * ((h_flip * h_scale * x) + h_shift) + v_shift
	elif function == Functions.functions.QUAD:
		value = v_flip * v_scale * ((h_flip * h_scale * x) + h_shift) * ((h_flip * h_scale * x) + h_shift) + v_shift
	# add new functions here as needed
	return value


#### signals from function ui related to applying/changing a transformation




#### ui debugging, toggle each transformation
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



## update transformation values
func _on_v_shift_value_changed(value: float) -> void:
	v_shift = value
func _on_h_shift_value_changed(value: float) -> void:
	h_shift = value
func _on_v_scale_value_changed(value: float) -> void:
	v_scale = value
func _on_h_scale_value_changed(value: float) -> void:
	h_scale = value
func _on_v_flip() -> void:
	v_flip = not v_flip
func _on_h_flip() -> void:
	h_flip = not h_flip
