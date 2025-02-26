extends Label

var value = 0
var step = 20
signal v_shift_changed(to_what)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".text = str(value)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_v_shift_up() -> void:
	value += step
	$".".text = str(value)
	v_shift_changed.emit(value)


func _on_v_shift_down() -> void:
	value -= step
	$".".text = str(value)
	v_shift_changed.emit(value)


func _on_h_shift_up() -> void:
	pass # Replace with function body.


func _on_h_shift_down() -> void:
	pass # Replace with function body.
