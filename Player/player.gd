extends Node2D

var Projectile = preload("res://Player/projectile.tscn")
const Functions = preload("res://functions.gd")


#General Function properties
@export var step_size: int = 1
@export var max_steps: int = 2000

var current_function
var current_trajectory = []


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#The player controls right now are just for testing. Gonna change it once interface gets implemented
	handle_input()
	queue_redraw()


func handle_input():
	if Input.is_action_just_pressed("Shoot"):
		#Create water projectile and give it the trajectory
		$Attack.start()
		$Icon/AnimatedSprite2D.play("Attack")
		var proj_instance = Projectile.instantiate()
		add_child(proj_instance)
		
		proj_instance.start(current_trajectory)

func _draw():
	draw_trajectory()

func draw_trajectory():
	var points = []
	var function = $"../Level/MarginContainer/VBoxContainer"
	var h_shift = function.get_h_shift()
	for i in range(max_steps+1):
		var x = i*step_size
		points.append(Vector2(x + h_shift, -function.evaluate(x)))
	
	$Icon.position = points[0]
	current_trajectory = points
	
	for i in range(points.size() - 1):
		
		draw_line(points[i], points[i+1], Color.RED, 2)

func _on_attack_timeout():
	$Icon/AnimatedSprite2D.play("Idle")
