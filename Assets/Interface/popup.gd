extends Control

var pressed = false
@export var speed: float = 0.5
@export var text: String = "Description"

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate.a = 0
	$RichTextLabel.text = text


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !pressed and modulate.a < 1:
		modulate.a += 0.5 * delta
	else:
		modulate.a -= 0.5 * delta
		if modulate.a == 0:
			queue_free()


func _on_button_pressed():
	pressed = true
