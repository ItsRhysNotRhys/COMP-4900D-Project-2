extends Label

var v_shift = 0 # want to export
var h_shift = 0
var v_step = 20
var h_step = 20
signal v_shift_changed(new_value)
signal h_shift_changed(new_value)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".text = str(v_shift)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_v_shift_up() -> void:
	v_shift += v_step
	$".".text = str(v_shift)
	v_shift_changed.emit(v_shift)


func _on_v_shift_down() -> void:
	v_shift -= v_step
	$".".text = str(v_shift)
	v_shift_changed.emit(v_shift)


func _on_h_shift_up() -> void:
	h_shift += h_step
	$".".text = str(h_shift)
	h_shift_changed.emit(h_shift)

func _on_h_shift_down() -> void:
	h_shift -= h_step
	$".".text = str(h_shift)
	h_shift_changed.emit(h_shift)
