extends HBoxContainer

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


func toggle_transformation(type) -> void:
	if type == Functions.transformations.VERTICAL_SHIFT:
		has_v_shift = true
	elif type == Functions.transformations.HORIZONTAL_SHIFT:
		has_h_shift = true
	elif type == Functions.transformations.VERTICAL_SCALE:
		has_v_scale = true
	elif type == Functions.transformations.HORIZONTAL_SCALE:
		has_h_scale = true
	elif type == Functions.transformations.VERTICAL_FLIP:
		has_v_flip = true
	elif type == Functions.transformations.HORIZONTAL_FLIP:
		has_h_flip = true

	update_function_ui()


# update the ui of the function
func update_function_ui() -> void:
	# check if we allow vertical shifts
	if (has_v_shift):
		$plus.show()
		$v_shift.show()
	else:
		$plus.hide()
		$v_shift.hide()

	# check if we allow horizontal shifts
	if (has_h_shift):
		$main_term/plus.show()
		$main_term/h_shift.show()
	else:
		$main_term/plus.hide()
		$main_term/h_shift.hide()

	# check if we allow vertical scaling
	if (has_v_scale):
		$v_scale.show()
	else:
		$v_scale.hide()

	# check if we allow horizontal scaling
	if (has_h_scale):
		$main_term/h_scale.show()
	else:
		$main_term/h_scale.hide()

	#check if we allow vertical reflection
	if (has_v_flip):
		$v_flip.show()
	else:
		$v_flip.hide()

	# check if we allow horizontal reflection
	if (has_h_flip):
		$main_term/h_flip.show()
	else:
		$main_term/h_flip.hide()
	
	# check if certain parentheses should be shown or hidden
	#todo




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

# vertical shift
func _on_v_shift_up() -> void:
	v_shift += v_shift_step
	$v_shift/v_shift.text = str(v_shift)

func _on_v_shift_down() -> void:
	v_shift -= v_shift_step
	$v_shift/v_shift.text = str(v_shift)

# horizontal shift
func _on_h_shift_up() -> void:
	h_shift += h_shift_step
	$main_term/h_shift/h_shift.text = str(h_shift)

func _on_h_shift_down() -> void:
	h_shift += h_shift_step
	$main_term/h_shift/h_shift.text = str(h_shift)

# vertical scaling
func _on_v_scale_up() -> void:
	v_scale += v_scale_step
	$v_scale/v_scale.text = str(v_scale)
	pass # Replace with function body.

func _on_v_scale_down() -> void:
	v_scale -= v_scale_step
	$v_scale/v_scale.text = str(v_scale)

# horizontal scaling
func _on_h_scale_up() -> void:
	h_scale += h_scale_step
	$main_term/h_scale/h_scale.text = str(h_scale)

func _on_h_scale_down() -> void:
	h_scale -= h_scale_step
	$main_term/h_scale/h_scale.text = str(h_scale)

# vertical reflection
func _on_v_flip() -> void:
	v_flip *= -1
	if v_flip < 0:
		$v_flip/v_flip.text = "-"
	else:
		$v_flip/v_flip.text = "+"

# horizontal reflection
func _on_h_flip() -> void:
	h_flip *= -1
	if h_flip< 0:
		$main_term/h_flip/h_flip.text = "-"
	else:
		$main_term/h_flip/h_flip.text = "+"
