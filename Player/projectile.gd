extends Area2D

var alive = false
var trajectory = []
var step = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if alive :
		if step < trajectory.size() - 2:
			position = trajectory[step]
			rotation = (trajectory[step + 1] - position).angle()
			step += 1


func start(points):
	alive = true
	trajectory = points


func _on_timer_timeout():
	queue_free()
