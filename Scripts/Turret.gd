extends KinematicBody2D
var bullet = preload("res://Character/bullet.tscn")
var dash_velocity= Vector2();
var canShoot=true;

func _ready():
	pass # Replace with function body.
	
	
func _process(delta):
	if Input.is_action_pressed("ui_machine_action") and canShoot:
		_shot();
	look_at(get_global_mouse_position());
	pass;

func _shot():
	var bulleto= bullet.instance();
	bulleto.position= $Gun.global_position;
	get_tree().get_root().add_child(bulleto);
	canShoot=false;
	yield(get_tree().create_timer(0.3), "timeout")
	canShoot=true;
	pass;

func _shot_status(canShot):
	print("shooot")
	canShoot= canShot;
	pass;
