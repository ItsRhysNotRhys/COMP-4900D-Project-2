extends Area2D

@export var speed = 8
var incr = 0
var alive = false
var trajectory = []
var step = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if alive :
		incr += 1
		if incr % speed == 0:
			if step < trajectory.size() - 2:
				position = trajectory[step]
				rotation = (trajectory[step + 1] - position).angle()
				step += 20

func start(points):
	alive = true
	trajectory = points

func _on_timer_timeout():
	queue_free()
