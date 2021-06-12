extends KinematicBody2D

var motion = Vector2();

#var bullet = preload("res://character/Bullet.tscn")
var dash = false;
var destination;
var dash_frames = 0
var recoil_dash = Vector2();
var dash_velocity= Vector2();
var canShoot=true;
var canDash=true;
var speed=5;
func _ready():
	
	pass # Replace with function body.
	
	
func _process(delta):
	var movement = Vector2.ZERO;
	motion=Vector2.ZERO;
	
	if Input.is_action_pressed("ui_right"):
		motion.x=speed;
	if Input.is_action_pressed("ui_left"):
		motion.x=-speed;
	if Input.is_action_pressed("ui_up"):
		motion.y=-speed;
	if Input.is_action_pressed("ui_down"):
		motion.y=speed;

	if Input.is_action_pressed("ui_shoot") and canShoot:
		_shot();
		
	if Input.is_action_just_pressed("ui_dash") and canDash:
		_dash();
		


	if dash:
		_decrease_dash();
		movement = dash_velocity;
	else:
		movement=motion;
		
	move_and_collide(movement);
	pass;

func _decrease_dash():
	if dash_frames==0:
		dash=false;
		yield(get_tree().create_timer(0.5), "timeout")
		canDash=true;
	
	if dash_frames > 0:
		dash_frames -= 1
		dash_velocity=dash_velocity+recoil_dash;
		recoil_dash=Vector2.ZERO;
	pass;

func _shot():
	#var bulleto= bullet.instance();
	#bulleto.position= $Gun.global_position;
	#get_tree().get_root().add_child(bulleto);
	canShoot=false;
	yield(get_tree().create_timer(0.3), "timeout")
	canShoot=true;
	pass;
	
func _dash():
	_recoil_dash();
	dash_velocity=motion*5
	dash=true;
	canDash=false;
	dash_frames=10;
	pass;

func _recoil_dash():
	if motion.x ==1 :
		recoil_dash.x=-1;
	elif motion.x==-1:
		recoil_dash.x=1;
	if motion.y==1:
		recoil_dash.y=-1;
	elif motion.y==-1:
		recoil_dash.y=1;
	pass;
