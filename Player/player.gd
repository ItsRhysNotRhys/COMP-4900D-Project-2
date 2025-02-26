extends Node2D

var Projectile = preload("res://Player/projectile.tscn")

enum { 
	FUNC_LINEAR,
	FUNC_QUAD,
	
	FUNC_COUNT #keep last for cycling functions
	}
var current_function = FUNC_LINEAR

#General Function properties
@export var step_size: int = 1
@export var max_steps: int = 2000

var current_trajectory = []

# I don't think we need separate values according to which function type we're using
#linear
var mx = 1
var b = 0

#quad
var a = -0.01
var bq = 1
var c = 0
var quad_scale = 200

# can just use this instead
var v_shift = 0
var h_shift = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#The player controls right now are just for testing. Gonna change it once interface gets implemented
	handle_input()
	
	queue_redraw()
	
	pass


func handle_input():
	if Input.is_action_just_pressed("Cycle_functions"):
		current_function = (current_function + 1) % FUNC_COUNT
	
	if current_function == FUNC_LINEAR:
		if Input.is_action_just_pressed("Arrow_up"):
			mx += 0.1
		if Input.is_action_just_pressed("Arrow_down"):
			mx -= 0.1
		if Input.is_action_just_pressed("Arrow_left"):
			b += 25
		if Input.is_action_just_pressed("Arrow_right"):
			b -= 25
	elif current_function == FUNC_QUAD:
		if Input.is_action_just_pressed("Arrow_up"):
			a += 0.1 / quad_scale
		if Input.is_action_just_pressed("Arrow_down"):
			a -= 0.1 / quad_scale
		if Input.is_action_just_pressed("Arrow_left"):
			bq -= 0.1
		if Input.is_action_just_pressed("Arrow_right"):
			bq += 0.1
		if Input.is_action_just_pressed("W"):
			c += 10
		if Input.is_action_just_pressed("S"):
			c -= 10
	
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
	
	if current_function == FUNC_LINEAR:
		#Using the draw line function, iterate through a y = mx + b 
		for i in range(max_steps + 1):
			var x = i * step_size
			var y = mx * (x+h_shift) + v_shift
			
			points.append(Vector2(x, -y)) #Godot has flipped y
			
			
	elif current_function == FUNC_QUAD:
		# y = ax^2 + bx + c
		for i in range(max_steps + 1):
			var x = i * step_size
			var y = a * (x+h_shift) * (x+h_shift) + v_shift
			points.append(Vector2(x, -y))
	
	$Icon.position = points[0]
	current_trajectory = points
	
	for i in range(points.size() - 1):
		
		draw_line(points[i], points[i+1], Color.RED, 2)


func _on_v_shift_changed(new_value: Variant) -> void:
	v_shift = new_value


func _on_h_shift_h_shift_changed(new_value: Variant) -> void:
	h_shift = new_value


func _on_attack_timeout():
	$Icon/AnimatedSprite2D.play("Idle")
