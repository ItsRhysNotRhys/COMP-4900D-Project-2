extends SpinBox

@onready var arrows = load("res://Assets/Interface/arrows.svg")
@onready var arrows_up_disabled = load("res://Assets/Interface/arrows_up_disabled.svg")
@onready var arrows_down_disabled = load("res://Assets/Interface/arrows_down_disabled.svg")

func _ready() -> void:
	if (value == min_value):
		add_theme_icon_override("updown", arrows_down_disabled)
	elif (value == max_value):
		add_theme_icon_override("updown", arrows_up_disabled)
	else:
		add_theme_icon_override("updown", arrows)

func _on_value_changed(value: float) -> void:
	if (value == min_value):
		add_theme_icon_override("updown", arrows_down_disabled)
	elif (value == max_value):
		add_theme_icon_override("updown", arrows_up_disabled)
	else:
		add_theme_icon_override("updown", arrows)
